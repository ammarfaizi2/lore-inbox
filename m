Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVEWUA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVEWUA6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 16:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVEWUA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 16:00:57 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:11190 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261899AbVEWUAr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 16:00:47 -0400
Date: Mon, 23 May 2005 22:02:21 +0200
From: DervishD <lkml@dervishd.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] Hard disk LBA sector count is not always the same
Message-ID: <20050523200221.GE57@DervishD>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050523121424.GB339@DervishD> <42922175.8090005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42922175.8090005@pobox.com>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Jeff :)

    Thanks for your answer, Jeff :))

 * Jeff Garzik <jgarzik@pobox.com> dixit:
> DervishD wrote:
> >    current capacity is 156299375
> >    native capacity is 156301488
> Hard drives have a feature that can reserve a certain amount of space 
> away from the user.

    Yes, I know, but the problem is that 2.4 kernels *does* reserve
that space but 2.6 certainly not, and if I boot into 2.6 and then
reboot into 2.4, then 2.4 *does NOT* reserve that space.

    By the way, the 'current capacity' is reported as the above only
if I boot into 2.4 from power off. As soon as I boot into 2.6, the
drive seems to be reporting the second number as the current
capacity (capacity_2). I've check the code in 2.4.29 and the
difference between the setmax capacity and the capacity_2 only
happens in that case, when cold booting into 2.4. Anytime 2.6 is
involved, the drive reports the same capacity in both calls
(idedisk_read_native_max_address_ext() and the one that gives
lba_capacity_2 its value).
 
> Linux IDE often does 'set max' to make 100% of the hard drive
> visible to the OS.

    See the paragraph above: if I partition the disk under 2.6 the
partition will have a bigger address than the one that will be
available under 2.4, and that can give errors while accessing that
extra sectors. What can I do? For technical limitations in my box, I
have to use 2.6 for repartitioning that disk (and I will be doing
that in less than a month) and this will lead to unaccesible sectors
when I boot back into my usual 2.4 kernel :(

    Moreover, I've googled a bit and my disk doesn't seem to have
this problem, so I'm worried about a disk failure :(

    Thanks again for your help, Jeff.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
