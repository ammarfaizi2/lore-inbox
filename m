Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266409AbUFWMCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266409AbUFWMCu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266448AbUFWMCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:02:50 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:53668 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S266409AbUFWMCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:02:48 -0400
Date: Wed, 23 Jun 2004 20:59:06 +0900 (JST)
Message-Id: <20040623.205906.71913783.taka@valinux.co.jp>
To: haveblue@us.ibm.com
Cc: ashwin_s_rao@yahoo.com, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Atomic operation for physically moving a page (for memory
 defragmentation)
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <1087619137.4921.93.camel@nighthawk>
References: <20040619031536.61508.qmail@web10902.mail.yahoo.com>
	<1087619137.4921.93.camel@nighthawk>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > > However, if we're on an unlikely error path or
> > > similar and other options aren't suitable...
> > 
> > Maintaining atomicity in uniprocessor systems is easy
> > by preempt_enable and preempt_disable during the
> > operation. This implementation cannot be used for SMP
> > systems. 
> > Now during the time a page is copied/updatede if a
> > page is accessed the copied contents become invalid,
> > as updation is not done. Also during updation a
> > similar situation might arise.
> > The problem we are facing is to maintain the atomicity
> > of this operation on SMP boxes.
> 
> I think what you really want to do is keep anybody else from making a
> new pte to the page, once you've invalidated all of the existing ones,
> right?
> 
> Holding a lock_page() should do the trick.  Anybody that goes any pulls
> the page out of the page cache has to do a lock_page() and check
> page->mapping before they can establish a pte to it, so you can stop
> that.  Since you're invalidating page->mapping before you move the page
> (you *are* doing this, right?), it will end up working itself out.  

We should know that many part of kernel code will access the page
without holding a lock_page(). The lock_page() can't block them.

Thank you,
Hirokazu Takahashi.
