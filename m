Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131630AbRDXBPT>; Mon, 23 Apr 2001 21:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132668AbRDXBPJ>; Mon, 23 Apr 2001 21:15:09 -0400
Received: from ip164-173.fli-ykh.psinet.ne.jp ([210.129.164.173]:21955 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S131630AbRDXBOw>;
	Mon, 23 Apr 2001 21:14:52 -0400
Message-ID: <3AE4D383.4FA68904@yk.rim.or.jp>
Date: Tue, 24 Apr 2001 10:14:43 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre4 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Got a Kernel OOPS, and the problem with OOPS itself.
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got a kernel oops today.

I had oopses twice this month.

One thing I noticed about the latest kernel oopses in 2.4.3 and
2.4.4-pre4 which I am using:
while I manually tried to copy the OOPS dump info on the CRT
screen, somehow the interrupt was NOT disabled (!?) and
some stray interrupt from peripheral or something
triggered the oops process AGAIN.
So the information was scrolled up and new data
was dumped. The attached ksymoops output is
such output from the second oops.
The original screen dump was being recorded but  before
I came down to the Call Trace part, the screen scrolled
with the new oops message. Hmm...
This occured with the todays OOPS. The last OOPS a few weeks ago
was worse in that the machine then rebooted!?

I wonder if the interrupt can be totally disabled before
the OOPS message is printed.
Or maybe the kernel bug is such that the interrupt handling
is in a funny state when OOPS condition occurs.
I have never had this problem in recording oopses before.
I was no stranger to oopses while I had a scsi driver debugged
by the maintainer to handle multi-lun CD changer.
So I wrote down screenful of oops messages many times and
not a single problem like this on earlier kernel versions.

Will anyone kindly look into the possibility of loose
software/hardware
interrupt not disabled when OOPS dumping occurs?

Anyway, here is the output of
ksymoops for the second screenfull of dump when
an OOPS occured today.

(At the end, I attach the partial listing of the
first screenful of messages before it was scrolled and gone.)

Considering what happened as explained above, the original oops
probably came from do_page_fault.
The system crashed while I was typing something using emacs.

KERNEL :
Linux duron 2.4.4-pre4 #15 Thu Apr 19 01:58:23 JST 2001 i686 unknown
AMD Duron 750Mhz. 256MB memory, 80MB swap.


ishikawa@duron$ !ksy
ksymoops < oops-2001-04-24-b.txt
ksymoops 2.3.7 on i686 2.4.4-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4-pre4/ (default)
     -m /boot/System.map-2.4.4-pre4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

(*** CAUTION: The following line and up and EIP values are bogus
     for this screenful info. They were recorded from the first
screenful,
     but subsequently replaced by a new screenful as explained above.
***)

Unable to handle kernel NULL pointer reference at runtime address 0
(ditto for this line and the next eip!)
c01189e0

(*** The values below are valid for the second screenful of oops.
     Call trace grew from the first screenful, and so may have the
     original call trace PLUS whatever caused the second oops dump
     (probably some type of interrupt. )
      ***)

*pde = 00000000
EFLAGS: 00010202
eax: 00000010 ebx: 00005000 ecx: 00000020 edx: cff07144
esi: 00000070 edi: 0000001c ebp: d0800000 esp: cefdbc80
Process (pid: 0, Stackpage=cefdb000)
Stack: 00005000 cff07140 cff07000 d0800000 cff07144 00005000 00000001
00000020
       cff07140 c0185969 cff07000 cfbf1d80 04000001 0000000b cefdbd0c
00005048
       00000014 c0107f7f 0000000b cff07000 cefdbd0c 000002c0 c028dbc0
0000000b
Call Trace: [<d0800000>][<c0107192>][<c010f587>][<c010f250>]
 [<c01195cc>][<c0119705>][<c0106d88>][<c01189e0>]
 [<c0118a45>][<c010ad46>][<c0115fbb>][<c0115ed8>]
 [<c0115dcf>][<c0108131>][<c0106d14>][<c01120b0>]
 [<c0114c5f>][<c010f250>][<c0107192>][<c010f587>]
 [<c010f250>][<c0106d88>][<c0178b80>][<c0178b9c>]
 [<c010f250>][<c0178b9c>][<c01fe086>][<c0178b80>]
 [<c0178b80>][<c010f2ae>]
Code: 8b 18 8b 48 0c 81 e1 ff 3f 00 00 89 4c 24 14 66 85 db 0f 8d
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; d0800000 <_end+105467d0/105577d0>
Trace; c0107192 <die+42/50>
Trace; c010f587 <do_page_fault+337/430>
Trace; c010f250 <do_page_fault+0/430>
Trace; c01195cc <send_signal+2c/f0>
Trace; c0119705 <send_sig_info+25/a0>
Trace; c0106d88 <error_code+34/3c>
Trace; c01189e0 <count_active_tasks+10/30>
Trace; c0118a45 <timer_bh+45/260>
Trace; c010ad46 <timer_interrupt+66/120>
Trace; c0115fbb <bh_action+1b/70>
Trace; c0115ed8 <tasklet_hi_action+38/60>
Trace; c0115dcf <do_softirq+3f/70>
Trace; c0108131 <do_IRQ+a1/b0>
Trace; c0106d14 <ret_from_intr+0/20>
Trace; c01120b0 <panic+d0/e0>
Trace; c0114c5f <do_exit+3f/220>
Trace; c010f250 <do_page_fault+0/430>
 Trace; c0107192 <die+42/50>
Trace; c010f587 <do_page_fault+337/430>
Trace; c010f250 <do_page_fault+0/430>
Trace; c0106d88 <error_code+34/3c>
Trace; c0178b80 <scrup+70/130>
Trace; c0178b9c <scrup+8c/130>
Trace; c010f250 <do_page_fault+0/430>
Trace; c0178b9c <scrup+8c/130>
Trace; c01fe086 <tvecs+3f5e/a500>
Trace; c0178b80 <scrup+70/130>
Trace; c0178b80 <scrup+70/130>
Trace; c010f2ae <do_page_fault+5e/430>
Code;  00000000 Before first symbol

(*** The objdump's address can't be trusted because
     EIP for the second screenful of OOPS scrolled up and could not
     be seen. Scrolling up probably occurred due to the longer
     call trace dump.
     But the code data itself is correct. ***)

00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 18                     mov    (%eax),%ebx
Code;  00000002 Before first symbol
   2:   8b 48 0c                  mov    0xc(%eax),%ecx
Code;  00000005 Before first symbol
   5:   81 e1 ff 3f 00 00         and    $0x3fff,%ecx
Code;  0000000b Before first symbol
   b:   89 4c 24 14               mov    %ecx,0x14(%esp,1)
Code;  0000000f Before first symbol
   f:   66 85 db                  test   %bx,%bx
Code;  00000012 Before first symbol
  12:   0f 8d 00 00 00 00         jge    18 <_EIP+0x18> 00000018 Before
first symbol

Kernel panic: Aieee, killing interrupt handler!

1 warning issued.  Results may not be reliable.
ishikawa@duron$


Appendix. Just in case, this is the
partial memo of the first screenful before the software/hardware
interrupt somehow crept in and produced new dump messages.

--- begin quoe

Attempt to kill the idle task
In idle task - not syncing
Unable to handle kernel NULL pointer reference at runtime address 0
Printing eip:
c01189e0
*pde = 00000000
Oops = 0000
CPU : 0
FIP : 0010:[<c01189e0>]
EFALGS: 00010207
eax: c1444000 ebx: 00000001 ecx: 00002000 edx: 00000000
esi: c0291240 edi: 00000000 ebp: cefdbeb0 esp: cefdbe4c
cs: 0018 es: 0018 ss: 0018
Process (pid: 0, Stackpage: cefdb000)
Stack: c0118a45 00000000 c0291240 00000000 cefdbeb0 0000004b c010ad45
cefdbeb8
       c0115fbb 00000000 c0115ed8 00000000 00000001 c0291280 0000000e
c0115dcf

       *** When I wrote down up to this, the screen scrolled with new
       oops message!? ***

>From the /boot/System.map-2.4.4-pre4, at least eip is somewhere in
the following routines.
  >c0118940 T update_process_times
**>c01189d0 t count_active_tasks
  >c0118a00 T timer_bh


--- end quote


