Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288870AbSATSI5>; Sun, 20 Jan 2002 13:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288882AbSATSIs>; Sun, 20 Jan 2002 13:08:48 -0500
Received: from sente.pl ([195.117.126.124]:58889 "EHLO sente.pl")
	by vger.kernel.org with ESMTP id <S288870AbSATSIe>;
	Sun, 20 Jan 2002 13:08:34 -0500
Subject: 2.4.18-pre3 ReiserFS crashes not for the first time...
From: Grzegorz Prokopski <greg@sente.pl>
To: linux-kernel@vger.kernel.org
Cc: greg@sente.pl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 20 Jan 2002 17:09:06 +0100
Message-Id: <1011542953.695.0.camel@greg>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

First I must say I have not sent anythink like that to LKML yet,
but gonna do my best to give as much and as good information as
I can.

Background:
I am using Debian unstable/SID. Because of some problems it
sometimes shutsdown uncleanly - after logiing out from GNOME 
computer just freezes. It is unstable, normally I am using
NVidia binary driver and VMware binary kernel modules so I
wasn't surprised by this.

But I also use ReiserFS on LVM (only root is outside LVM),
so I _was_ surprised when filesystem related problems came up.

It was so bad I had to use fsck.reiserfs --rebuild-tree on
unmounted partitions in single user mode.

Problem:
Today I was doing dist-upgrade - it froze my computer.
I *disabled loading all binary modules*, restarted my machine
and run the process again. Below You can see what it caused:

Configuring bison (1.31-2)...
vs-7050: new entry is found, new inode == 0
invalid operand: 0000
CPU:    0
EIP:    0010:[<d081c239>]             Not tainted
EFLAGS: 00010286
    eax: 0000002f  ebx: d082bea0  ecx: ffffe061  edx: c4aea000
    esi: sffe8000  edi: ffffffef  ebp: c4aebf0c  esp: c4aebcec
    ds: 0018  es: 0018  ss: 0018
Process update-alternat (pid: 542, stacpage = c4aeb000)
Stack: d082d79a d0831b20 d082bea0 c4aebd10 c4a129a0 caebdd8 d0812299
cffe8000
d082bea0 c4a12a1c c4a12a1c c4a129a0 c49ac060 00000000 00000000 00000000
00000000 00000000 00000000 00000000 d08301cf 00000000 00000039 00013850
Calltrace: [<d082d79a>] [<d0831b20>] [<d082bea0>] [<d0812299>]
[<d082bea0>]
  [<d08301cf>] [<d0828baf>] [<c013cd99>] [<c013cf96>] [<c0106f43>]

Code: 0f 0b 68 20 1b 83 d0 85 f6 74 0f 0f b7 46 08 50 e8 ba 4d 91
/var/lib/dpkg/info/bison.postinst: line 10: 542 Segmentation fault

the 10th line of the script is just "fi"

Other stuff:
I am also getting strange errors like denying access to some files
while doing ls on a directory content - as root of course.

System data:
kernel 2.4.18-pre3 with latest LVM patch and latest kernel preemtion
patch (as of 15.I.2002)

Own thoughts:
I think that's all. Just wanna say I a bit dissapointed with reiserfs.
When installing it (took me 2 days to do the transition from lilo, ext2
to grub, LVM and ReiserFS ;-) I thought it is meant to be immune against
system crashes and power failures.

Now gotta go into single user mode now and --rebuild-tree again on
every each partition... Maybe anyone has a better idea ?

I will be glad to see any responses, please Cc: them to me if You
please ( mailto:greg@sente.pl ) - or give me an address of any _live_
LKML news gateway.

Best regards
					Grzegorz Prokopski


