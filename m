Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135698AbRDXQYf>; Tue, 24 Apr 2001 12:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135699AbRDXQYZ>; Tue, 24 Apr 2001 12:24:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3085 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135698AbRDXQYN>; Tue, 24 Apr 2001 12:24:13 -0400
Subject: Re: BUG: Global FPU corruption in 2.2
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 24 Apr 2001 17:25:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9c48gv$fbk$1@penguin.transmeta.com> from "Linus Torvalds" at Apr 24, 2001 09:10:07 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14s5cx-0002PI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >1.) If I'm not mistaken switch_to changes current->flags without
> >atomic operations and without any locks and sys_ptrace changes
> >child->flags only protected by the big kernel lock.
> 
> ptrace only operates on processes that are stopped. So there are no
> locking issues - we've synchronized on a much higher level than a
> spinlock or semaphore.

In the 2.2 case the ptrace flags themselves are in the same flag set as
the PF_ flags. In 2.4 that was fixed. That means there are some bizarre cases
where current->flags might not be handled perfectly.

