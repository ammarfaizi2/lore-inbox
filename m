Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268079AbUI1XDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268079AbUI1XDf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 19:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268088AbUI1XDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 19:03:35 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:17156 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268079AbUI1XDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 19:03:31 -0400
Date: Wed, 29 Sep 2004 00:03:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: get_user_pages() still broken in 2.6
Message-ID: <20040929000325.A6758@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Timur Tabi <timur.tabi@ammasso.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
References: <4159E85A.6080806@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4159E85A.6080806@ammasso.com>; from timur.tabi@ammasso.com on Tue, Sep 28, 2004 at 05:40:26PM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 05:40:26PM -0500, Timur Tabi wrote:
> I was hoping that this bug would be fixed in the 2.6 kernels, but 
> apparently it hasn't been.
> 
> Function get_user_pages() is supposed to lock user memory.  However, 
> under extreme memory constraints, the kernel will swap out the "locked" 
> memory.
> 
> I have a test app which does this:
> 
> 1) Calls our driver, which issues a get_user_pages() call for one page.
> 2) Calls our driver again to get the physical address of that page (the 
> driver uses pgd/pmd/pte_offset).
> 3) Tries allocate 1GB of memory (this system has 1GB of physical RAM).
> 4) Tries to get the physical address again.
> 
> In step 4, the physical address is usually zero, which means either 
> pgd_offset or pmd_offset failed.  This indicates the page was swapped out.
> 
> I don't understand how this bug can continue to exist after all this 
> time.  get_user_pages() is supposed to lock the memory, because drivers 
> use it for DMA'ing directly into user memory.

get_user_pages locks the page in memory.  It doesn't do anything about ptes.

