Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVAMQoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVAMQoY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVAMQnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:43:25 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:26852 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261221AbVAMQkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:40:55 -0500
Subject: Re: [PATCH] do_brk() needs mmap_sem write-locked
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501120800500.2373@ppc970.osdl.org>
References: <20050112002117.GA27653@logos.cnet>
	 <Pine.LNX.4.58.0501120800500.2373@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105626859.4624.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 15:36:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-01-12 at 16:03, Linus Torvalds wrote:
> if that warning ever triggers, mmap_sem will now be locked, and that will 
> cause problems. So I suspect it's better to do
> 
> 	if (down_read_trylock(&mm->mmap_sem)) {
> 		WARN_ON(1);
> 		up_read(&mm->mmap_sem);

Better to leave the lock held and remember the error then drop it at the
end - anything else means the WARN_ON case is a security hole.

