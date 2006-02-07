Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWBGJka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWBGJka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWBGJka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:40:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:63387 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932459AbWBGJk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:40:29 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: OOM behavior in constrained memory situations
Date: Tue, 7 Feb 2006 10:23:38 +0100
User-Agent: KMail/1.8.2
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com> <20060206145922.3eb3c404.pj@sgi.com> <Pine.LNX.4.62.0602061745480.20189@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602061745480.20189@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071023.39222.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 02:55, Christoph Lameter wrote:
> I just tried to oom a process that has restricted its mem allocation to 
> node 0 using a memory policy. Instead of an OOM the system began to swap 
> on node zero. The swapping is restricted to the zones passed to 
> __alloc_pages. It was thus swapping node zero alone.

Thanks for doing that work. It's needed imho and was on my todo list.


>  	switch (pol->policy) {
>  	case MPOL_DEFAULT:
>  		break;
> Index: linux-2.6.16-rc2/include/linux/mempolicy.h
> ===================================================================
> --- linux-2.6.16-rc2.orig/include/linux/mempolicy.h	2006-02-02 22:03:08.000000000 -0800
> +++ linux-2.6.16-rc2/include/linux/mempolicy.h	2006-02-06 17:07:41.000000000 -0800
> @@ -62,6 +62,7 @@ struct vm_area_struct;
>  struct mempolicy {
>  	atomic_t refcnt;
>  	short policy; 	/* See MPOL_* above */
> +	gfp_t gfp_flags;	/* flags ORed into gfp_flags for each allocation */

I don't think it's a good idea to add it to the struct mempolicy. I've tried to
make it as memory efficient as possibile and it would be a waste to add such
a mostly unused field. Better to pass that information around in some other way.

(in the worst case it could be a upper bit in policy, but I would prefer
function arguments I think) 

The rest looks good.

-Andi

