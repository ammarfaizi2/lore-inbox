Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131476AbRCWWTG>; Fri, 23 Mar 2001 17:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131477AbRCWWS4>; Fri, 23 Mar 2001 17:18:56 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131476AbRCWWSo>; Fri, 23 Mar 2001 17:18:44 -0500
Subject: Re: [PATCH] Fix races in 2.4.2-ac22 SysV shared memory
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 23 Mar 2001 22:20:05 +0000 (GMT)
Cc: sct@redhat.com (Stephen C. Tweedie), linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, alan@lxorguk.ukuu.org.uk (Alan Cox),
        bcrl@redhat.com (Ben LaHaise), cr@sap.com (Christoph Rohland)
In-Reply-To: <Pine.LNX.4.31.0103231157200.766-100000@penguin.transmeta.com> from "Linus Torvalds" at Mar 23, 2001 11:58:50 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gZuj-0005YN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 23 Mar 2001, Stephen C. Tweedie wrote:
> >
> > The patch below is for two races in sysV shared memory.
> 
> 	+       spin_lock (&info->lock);
> 	+
> 	+       /* The shmem_swp_entry() call may have blocked, and
> 	+        * shmem_writepage may have been moving a page between the page
> 	+        * cache and swap cache.  We need to recheck the page cache
> 	+        * under the protection of the info->lock spinlock. */
> 	+
> 	+       page = find_lock_page(mapping, idx);
> 
> Ehh.. Sleeping with the spin-lock held? Sounds like a truly bad idea.

Umm find_lock_page doesnt sleep does it ?

Alan

