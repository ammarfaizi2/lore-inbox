Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289186AbSA3NDl>; Wed, 30 Jan 2002 08:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289190AbSA3ND0>; Wed, 30 Jan 2002 08:03:26 -0500
Received: from aboukir-101-2-1-easter.adsl.nerim.net ([62.4.19.191]:56962 "HELO
	verveine") by vger.kernel.org with SMTP id <S289186AbSA3NDJ>;
	Wed, 30 Jan 2002 08:03:09 -0500
Date: Wed, 30 Jan 2002 14:03:00 +0100
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: cpqarray SMP 2.4.14
Message-ID: <20020130140300.A3534@easter-eggs.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Operating-System: Debian Gnu/Linux 2.4.14
From: pbrugier@easter-eggs.com (Brugier Pascal)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody

I'd a thread with Mark Hahn and Denis Vlasenko about cpqarray and SMP
problems with 2.4.14. but they told me that it's better to go now on the
mailing list because the problem become harder.

I'll resume this and hope it will be usefull for everybody.

The machine:

Compaq Proliant DL 360
2 HD scsi 9,1 G
Raid 1
2 eepro 100
SMP (but 1 CPU)

The partitions:

/dev/ida/c0d0p1 swap
/dev/ida/c0d0p2 /
/dev/ida/c0d0p3 /tmp
/dev/ida/c0d0p4 /var

The problems:

1 When i want to edit a file: /var/log/mylogdir/mylogfile (140 Mb)
  the server hangs whith this messages:

invalid operand
CPU:    0L
EIP:    0010:[<c0123154>] Not tainted
EFLAGS: 00010046
eax: 00000000   ebx: d99a9f60   ecx: 00000002   edx: c1665740  
esi: 00000002   edi: c1665740   ebp: 00000001   esp: c01fbf18  
ds: 0018        es: 0018        ss: 0018
Process swapper (pid: 0, stackpage=c01fb000)
Stack: d99a9f60 c012f92b 00000000 dfa01f48 c1821800 e082a885 d99a9f60
00000001
       dfffa680 24000001 00000003 c01fbf94 00000002 c0107f8d 00000003
       c1821800
       c01fbf94 00000060 c0230960 00000003 c01fbf8c
       c01080f6 00000003
       c01fbf94
Call Trace: [<c012f92b>] [<e082a885>] [<c0107f8d>] [<c01080f6>]
[<c01053e9>] [<c0105360>] [<c0109ed8>] [<c0105360>] [<c0105360>]
[<c0105383>] [<c01053e9<] [<c0105000>] [<c0105027>]

Code: 0f 0b 8d 5a 24 8d 42 28 39 42 28 74 11 b9 01 00 00 00 ba 03
<0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

2 If i want to copy /var/log/mylogdir/mylogfile
 
Kernel says:
            
invalid request on ida/c0d0 = (cmd=30 sect=837624 cnt=248 sg=1 ret=10)

When this arrived i didn't know about ksymoops but i find in Sysmap
only answers for "Call Trace":

c0105360 t default_idle
c0105000 T _stex

I think to that when the system want to swap it hangs to (writing on
another partition), and it was the same when he wants to rotate a file
which is to big for the "bug" .

I've to say that these didn't arrived when i did the same tests with
little files.

##############

When i tried to find a solution for this problem, i read the kernel
changelogs since the 2.4.13 and if find that the cpqarray was modified
for the 2.4.14, then i downgrad to the 2.4.13 and now everything work
fine.

Can you confirm that downgrading was the solution or explain if it's
another problem and which one.

Is the modification for cpqarray solving this problem (i don't want to
use it now it's only for my knowledge :-) ).

I'll thank you very much

Best regards

PS: excuse me for my bad english

-- 
Pascal Brugier
---------------------------------------------------------------
Easter-eggs                               Spécialiste GNU/Linux
44-46 rue de l'Ouest  -  75014 Paris  -  France  -  Métro Gaité
Phone: +33 (0) 1 43 35 00 37    -    Fax: +33 (0) 1 43 35 00 76
mailto:pbrugier@easter-eggs.com  -   http://www.easter-eggs.com
---------------------------------------------------------------
709D77A2 -   ED24 4E29 E5B4 FDE7 56A4  352D F24E 7E68 709D 77A2
_______________________________________________________________
