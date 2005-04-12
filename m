Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVDLAbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVDLAbR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 20:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVDLAbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 20:31:17 -0400
Received: from ciistr1.ist.utl.pt ([193.136.128.1]:65260 "EHLO
	ciistr1.ist.utl.pt") by vger.kernel.org with ESMTP id S261811AbVDLAbB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 20:31:01 -0400
From: Claudio Martins <ctpm@ist.utl.pt>
To: Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Processes stuck on D state on Dual Opteron
Date: Tue, 12 Apr 2005 01:30:29 +0100
User-Agent: KMail/1.7.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <200504050316.20644.ctpm@rnl.ist.utl.pt> <425A7173.802@yahoo.com.au> <16987.3162.71365.242198@cse.unsw.edu.au>
In-Reply-To: <16987.3162.71365.242198@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504120130.29895.ctpm@ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday 12 April 2005 00:46, Neil Brown wrote:
> On Monday April 11, nickpiggin@yahoo.com.au wrote:
> > Neil, have you had a look at the traces? Do they mean much to you?
>
> Just looked.
> bio_alloc_bioset seems implicated, as does sync_page_io.
>
> sync_page_io used to use a 'struct bio' on the stack, but Jens Axboe
> change it to use bio_alloc (don't know why..) and I should have
> checked the change better.
>
> sync_page_io can be called on the write out path, so it should use
> GFP_NOIO rather than GFP_KERNEL.
>
> See if this helps.... Actually this patch is against 2.6.12-rc2-mm1
> which uses md_super_write instead of sync_page_io (which is now only
> used for read).  So if you are using a non-mm kernel (which seems to
> be the case) you'll need to apply the patch by hand.
>

   Hi Neil,

  I'll test this patch, but I'm wondering if I have to apply all the 
md-related patches from broken out directory of 2.6.12-rc2-mm1 or only some 
specific ones?
   Anyway I'm happy to test all those md updates, if you think they might 
help.

 Thanks 

Claudio

