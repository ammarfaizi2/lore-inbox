Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129819AbQLOSZi>; Fri, 15 Dec 2000 13:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130271AbQLOSZ2>; Fri, 15 Dec 2000 13:25:28 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5641 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130265AbQLOSZ0>; Fri, 15 Dec 2000 13:25:26 -0500
Subject: Re: [lkml]Re: VM problems still in 2.2.18
To: andrea@suse.de (Andrea Arcangeli)
Date: Fri, 15 Dec 2000 17:57:18 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jjs@toyota.com (J Sloan),
        linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <20001215152908.M11505@inspiron.random> from "Andrea Arcangeli" at Dec 15, 2000 03:29:08 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146z6f-0001ZD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The changes in semaphore semantics are necessary to fix the spurious out of
> memory with MAP_SHARED mappings and they came together with the removal of the
> always-asynchronous kpiod. While it's certainly possible to remove it I don't
> think removing the fix for MAP_SHARED stuff is a good idea.

How hard is it to seperate losing kpiod (optimisation) from the MAP_SHARED 
changes ? I am assuming they are two seperate issues, possibly wrongly

> Basically it's always safe to replace:
> 
> 	down(&inode->i_sem);
> 	/* critical section */
> 	up(&inode->isem);
> 
> with the new fs-semaphore:
> 
> 	fs_down(&inode->i_sem);
> 	/* critical section */
> 	fs_up(&inode->i_sem);

Providing no inode semaphore is upped from a different task , which seems
currently quite a valid legal thing to do (ditto doing the up on completion of
something in bh or irq context)

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
