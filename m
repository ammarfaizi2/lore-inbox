Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSFWUDq>; Sun, 23 Jun 2002 16:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317101AbSFWUDp>; Sun, 23 Jun 2002 16:03:45 -0400
Received: from pD9E7E5FA.dip.t-dialin.net ([217.231.229.250]:5249 "EHLO
	bonzo.nirvana") by vger.kernel.org with ESMTP id <S317096AbSFWUDn>;
	Sun, 23 Jun 2002 16:03:43 -0400
Date: Sun, 23 Jun 2002 22:02:08 +0200
From: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>
To: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sander van Malssen <svm@kozmix.cistron.nl>
Subject: 1000000000 as irq count init (was: Procinfo behaving strange under 2.4.19-pre10)
Message-ID: <20020623220208.A5272@bonzo.nirvana>
References: <Pine.LNX.4.44.0206210849450.678-100000@grignard.amagerkollegiet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0206210849450.678-100000@grignard.amagerkollegiet.dk>; from moffe@amagerkollegiet.dk on Fri, Jun 21, 2002 at 08:57:25AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 21, 2002 at 08:57:25AM +0200, Rasmus Bøg Hansen wrote:
> I upgraded a short time ago from kernel 2.4.18 to 2.4.19-pre10, but now
> procinfo reports interrupts in a strange way.
> 
> 2.4.19-pre10:
> 
> # procinfo
> [...]
> irq  0:1000207681 timer                 irq  8:1000000003
> irq  1:1000004868 keyboard              irq  9:1000000000 acpi
> irq  2:1000000000 cascade [4]           irq 10:1000007854 eth0
> irq  3:1000000000                       irq 11:1000114199 nvidia
> irq  4:1000000000                       irq 12:1000026199 PS/2 Mouse
> irq  5:1000003195 es1370                irq 13:1000000000
> irq  6:1000000000                       irq 14:1000016806 ide0
> irq  7:1000000000                       irq 15:1000000000
> [...]

I can second this (while I switched from 2.4.19-pre6 to 2.4.18 with RedHat/SGI
patches, but obviously the same patch hit me also).

procinfo reads that info from /proc/stat, which is giving away that bogus (?) 
interrupt counts. It also causes xosview a horrible cpu 100% hang. :(

[root@bonzo root]# uname -a
Linux bonzo.nirvana 2.4.18-4SGI_XFS_1.1-bonzo #1 Sun Jun 23 17:49:32 CEST 2002
i686 unknown
[root@bonzo root]# cat /proc/stat 
cpu  204580 0 5397 181674
cpu0 204580 0 5397 181674
page 193512 228084
swap 1 0
intr 668955 1000391651 1000008974 1000000000 1000000007 1000000008 1000000002
1000000008 1000000002 1000000001 1000212403 1000000000 1000000002 1000027284
1000000000 [...] 1000000000 1000000000 1000000000 1000000000 1000000000
1000000000 1000000000 1000000000 1000000000
disk_io: (3,0):(28638,17974,387024,10664,456168) 
ctxt 1276299
btime 1024858081
processes 5380
-- 
Axel.Thimm@physik.fu-berlin.de
