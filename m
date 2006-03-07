Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWCGUGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWCGUGu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 15:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWCGUGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 15:06:50 -0500
Received: from ns2.suse.de ([195.135.220.15]:45035 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932072AbWCGUGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 15:06:49 -0500
To: Hugh Dickins <hugh@veritas.com>, hyu@ati.com
Cc: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] mm: data overlapping in page struct
References: <E6F1C74189C227449B7C7BC9F60926F901B4EC4C@torcaexmb2.atitech.com>
	<Pine.LNX.4.61.0603071933070.4158@goblin.wat.veritas.com>
From: Andi Kleen <ak@suse.de>
Date: 07 Mar 2006 21:06:37 +0100
In-Reply-To: <Pine.LNX.4.61.0603071933070.4158@goblin.wat.veritas.com>
Message-ID: <p73oe0if29e.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> writes:

> On Tue, 7 Mar 2006, Hui Yu wrote:
> 
> > This patch is to fix a data overlapping issue in struct page. The
> > problem was introduced a few months ago by "split page table lock"
> > change in which mapping is moved into the same union with ptl. Since
> > private has fixed length (size of unsigned long), depending on config
> > options, ptl may have larger size than private. In this case, ptl will
> > overlap to mapping and may overwrite the original data in mapping. 
> > The simplest way of fixing this is to move mapping out of the union, as
> > in this patch. There may be better approaches; I'll leave it to the
> > experts more familiar with this part of code.  
> 
> Nak.  We use ->mapping for page cache pages, or pages mapped into
> user address space.  We use ->ptl for page table pages of user
> address space.  Where is it that you expect a data page to be
> used as a page table page at the same time?

Hui, can you perhaps explain how you use the fields in your code?
Do you perhaps use the spinlocks when the page is mapped into 
an address space?

-Andi
