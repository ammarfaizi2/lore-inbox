Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266182AbUALNKU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 08:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUALNKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 08:10:19 -0500
Received: from [212.239.225.130] ([212.239.225.130]:39553 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S266182AbUALNKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 08:10:11 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Kiko Piris <kernel@pirispons.net>
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
Date: Mon, 12 Jan 2004 14:09:44 +0100
User-Agent: KMail/1.5.4
Cc: Bart Samwel <bart@samwel.tk>, linux-kernel@vger.kernel.org,
       Dax Kelson <dax@gurulabs.com>, Bartek Kania <mrbk@gnarf.org>,
       Simon Mackinlay <smackinlay@mail.com>
References: <3FFFD61C.7070706@samwel.tk> <200401121212.44902.lkml@kcore.org> <20040112121956.GA8226@portsdebalears.com>
In-Reply-To: <20040112121956.GA8226@portsdebalears.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401121409.44187.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 January 2004 13:19, Kiko Piris wrote:
> On 12/01/2004 at 12:12, Jan De Luyck wrote:
> > Patch applied, kernel built, laptop_mode activated, but my disk just
> > doesn't want to spin down...
>
> [...]
>
> > But the disk never spins down. Not that I can tell, hdparm -C /dev/hda
> > always tells me active/idle, and the sdsl tool also reports 100% disk
> > spinning...
> >
> > anything else I have to activate/check?
>
> As you don't say if you have checked it, here goes my suggestion:
>
> First of all, you should assure there's no process doing reads [*] that
> cause a cache miss (eg. daemons like postfix that check the queue every
> few seconds). You can tell this running vmstat 1 and see that bi and bo
> [**] stay at 0.

vmstat 1:

 0  0      0  88748  37628 216216    0    0     0     0 1514  1130  7  4 89  0
 0  0      0  88756  37628 216216    0    0     0     0 1495  1123  6  1 93  0
 0  0      0  88748  37628 216216    0    0     0     0 1504  1114  8  4 88  0
 1  0      0  88748  37628 216216    0    0     0     0 1499  1058  6  2 92  0
 0  0      0  88748  37628 216216    0    0     0     0 1488  1062  7  4 89  0
 0  0      0  88748  37628 216216    0    0     0     0 1480  1007  7  6 87  0
 0  0      0  88876  37628 216216    0    0     0     0 1524  1122  7  6 87  0
 0  0      0  88748  37628 216216    0    0     0     0 1506  1078 11  6 83  0
 0  0      0  88748  37628 216216    0    0     0     0 1500  1057 11  5 84  0
 0  0      0  88748  37628 216216    0    0     0     0 1514  1040 16  3 81  0
 0  1      0  88748  37660 216216    0    0     0    28 1523  1041 19  4 64 13
 0  1      0  88748  37660 216216    0    0     0     0 1500   994 23  2  0 75
 0  0      0  88748  37660 216216    0    0     0    32 1540  1064 25  1 53 21
 0  0      0  88748  37660 216216    0    0     0     0 1501  1064 24  0 76  0
 0  0      0  88748  37660 216216    0    0     0     0 1514  1071 24  1 75  0
 2  0      0  88812  37660 216216    0    0     0     0 1518  1086 24  1 75  0
 0  0      0  88804  37660 216216    0    0     0     0 1504  1066 24  2 74  0
 0  0      0  88740  37660 216216    0    0     0     0 1482  1015 25  1 74  0

At the presence of bo it spins up the disk.

Jan
-- 
Only fools are quoted.
		-- Anonymous

