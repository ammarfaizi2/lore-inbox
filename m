Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSJVXvz>; Tue, 22 Oct 2002 19:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262276AbSJVXvz>; Tue, 22 Oct 2002 19:51:55 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:18636 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262210AbSJVXvx>; Tue, 22 Oct 2002 19:51:53 -0400
Date: Tue, 22 Oct 2002 16:52:03 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@zip.com.au>
Subject: New panic (io-apic / timer?) going from 2.5.44 to 2.5.44-mm1
Message-ID: <440550000.1035330723@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm ... 2.5.43-mm2 and 2.5.44 work fine, but 2.5.44-mm1 (and mm2)
panic consistently on boot for a 16 way NUMA-Q.

Normally this box will boot with TSC on or off. If anyone has any pointers as
to what's changed in the mm patchset going from 43-mm2 to 44-mm1 that
might have touched this area (I can't see anything), please poke me in the
eye. Otherwise I'll just keep digging into it ....

Diff of bootlogs with TSC on below. As per usual for SMP panics, it's garbage ;-(

 BIOS bug, IO-APIC#7 ID 13 is already used!...
 ... fixing up to 9. (tell your hw vendor)
 ...changing IO-APIC physical APIC ID to 9 ... ok.
-..TIMER: vector=0x31 pin1=2 pin2=0
-testing the IO APIC.......................
-
-
-
-
-
-
-
-
+ge<4>al prot, 5-19 fault: 0000
+1 <4>C 5-22  3
+ EIP: , 6-060:[<0, 7-008>], 7-8ot ta, 7-18, 7-19S, 7-200, 2
+1e<4>, 7-000, 7-2eb, 8-0321c60   ecx: c0320, 9-8 edx: 0, 9-180, 9-19:<4>, 9-20 
, 9-21 c3a38000   ebp: 00000001   esp: c3a39f14
+ector=0x31 pin1=2 pin2=0
+ 0068
+Process  (pid: 49194, threadinf<3>..38000 task=f01c07f6)mer notStack: ted to IO
 APIC
+00...t00000011 set up timer (IRQ0) through t e 8259A ... 0320c24 . found   n 0)
 ...a c02dc960 c02c4800 00000000 00000000  <4>c3d.
+64..00000046  set uf40 mer        ual Wire IRQ0000000 00128868 c02b1e3c 0004200
0 c01078cc k<4>00nu0003  <4>c02b2128 ourcCall160.
+:number  [<c011d745>13 tasklet_hi_action+0x85/0xe0
+O-APIC #14 re] ido_ssft24.
+xnumber of  [-AP108f40>] ido_IRQ+0x100/0x1mber  [<c01078c #5 registn_int 24.
++numb/0x20
+O-APIC #8d72>] trelease.
+nnumberem+0xIO-APIC #7 [<c0118ccd 24.prinumber o5f IO-APIC
+8Code: ters: 24.
+anue.er of IO-A0IC #9 r panic: Aiee, killingngnterrup APIC...............rrupt 
handl
+ - not syncing
+. .
+.... register #00: 0D000000

If I patch it so that I can turn TSC off, and do so, I now get:

..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ... failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... failed :(.
Kernel panic: IO-APIC + timer doesn't work! pester mingo@redhat.com

which never used to happen before ... a good boot does this

... fixing up to 9. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 9 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................








.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 699.0999 MHz.
..... host bus clock speed is 99.0999 MHz.


