Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264757AbSJ3So1>; Wed, 30 Oct 2002 13:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264765AbSJ3So0>; Wed, 30 Oct 2002 13:44:26 -0500
Received: from 24-216-100-96.charter.com ([24.216.100.96]:53450 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S264757AbSJ3SoZ>;
	Wed, 30 Oct 2002 13:44:25 -0500
Date: Wed, 30 Oct 2002 13:50:49 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Box dead on boot with panic
Message-ID: <20021030185049.GD3420@rdlg.net>
Mail-Followup-To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have a system: quad-xeon-550
		 16Gigs of ram
		 2x18Gig internal disk (Configured / non-raid, /usr raid0+1)
		 4x54Gig external disk (Configured raid5)
		 Gigabit fibre network
		 kernel 2.4.18
		 Debian 2.2

  This box is supposed to be a corp mail server but it's being finicky.
In the past there were memory errors which ended up having to be fixed
with append="mem=6000".  At the suggestion of the list I backed down to
2.4.18 and compiled fresh.  This seemed to fix the memory errors.  Now
though when I try to rsync from the existing mailserver to the new
server memory usage climbs to 15Gig + and the load hits 15+.  When I let
it sit the load will drop but the memory free as reported y "free" stays
around 15Gig.  One time though it crashed with an "ACIC" error and a cpu
listing.  It was scrolling too fast to read and scroll-lock, etc were
unresponsive.
  At the suggestion of management (technical) I put the "mem=6000" back
in and rebooted.  It never came up.  Putting the console on I saw a
kernel panic.  Rebooted(hard with power button, no sysrq) with 
"linux init=/bin/bash" and I got another panic, slightly different.


raid0: EQUAL
raid0:  looking at scsi/host2/bus0/target1/lun1/part1
raid0:  comparing scsi/host2/bus0/target1/lun1/part1 (53223232 with scsi/host3/bus0/target1/lun3/part1 (53223232)
raid0: EQUAL
raid0: Final -1 zones
invalad operand: 0000
CPU: 3
eip:  0010:[<c012cda2>]  Not tainted
EFLAGS:  00010256
eax: ffffff84   ebx: 00000000   ecx: 00000001   edx: f8822000
esi: 00000000   edi: 00000000   ebp: 00000001   esp: c4eb9e90
  ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c4eb9000)
Stack: 00000004 00000000 00000000 00000001 00000016 c0117698 c0490796 00000246
       c01175ae 00000004 00000000 00000000 c0288e29 ffffff84 000001f2 00000163
       00000008 f8822000 f7a982a0 00000163 00000004 f7a982a0 88822000 f7a5f4e0
Call Trace: [<c0117698>] [<c01175ae>] [<co288e29>] [<c028900e>] [<c029ec78>]
            [<c011734b>] [<c0117698>] [<c01175ae>] [<60293fe1>] [<c02941f2>] [<c0296d3c>]
            [<c0105281>] [<c01057a4>]
Code: 0f 0b 31 c0 e9 e9 01 00 00 90 8d 74 26 08 6a 02 53 e8 40 f3
<0> Kernel panic: attempted to kill init!


Can anyone point to a potential cause?  



:wq!
---------------------------------------------------------------------------
Robert L. Harris                
                               
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.
FYI:
 perl -e 'print $i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'

