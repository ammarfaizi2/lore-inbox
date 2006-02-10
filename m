Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWBJVP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWBJVP4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWBJVP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:15:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1714 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932188AbWBJVPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:15:55 -0500
Date: Fri, 10 Feb 2006 13:15:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: oliver@neukum.org, nickpiggin@yahoo.com.au, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
In-Reply-To: <20060210121130.57db39bc.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0602101315100.19172@g5.osdl.org>
References: <20060209071832.10500.qmail@science.horizon.com>
 <43ECDD9B.7090709@yahoo.com.au> <Pine.LNX.4.64.0602101056130.19172@g5.osdl.org>
 <200602102034.07531.oliver@neukum.org> <Pine.LNX.4.64.0602101152150.19172@g5.osdl.org>
 <20060210121130.57db39bc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Feb 2006, Andrew Morton wrote:
> 
> Yes, it would make sense to run balance_dirty_pages_ratelimited() inside
> msync_pte_range().  So pdflush will get poked if we hit
> background_dirty_ratio threshold, or we go into caller-initiated writeout
> if we hit dirty_ratio.
> 
> But it's not completely trivial, because I don't think we want to be doing
> blocking writeback with mmap_sem held.

Why not just do it once, at the end? 

		Linus
