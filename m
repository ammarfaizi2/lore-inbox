Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWBGSbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWBGSbY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 13:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWBGSbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 13:31:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:25998 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964849AbWBGSbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 13:31:23 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: OOM behavior in constrained memory situations
Date: Tue, 7 Feb 2006 19:31:09 +0100
User-Agent: KMail/1.8.2
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com> <200602071858.13002.ak@suse.de> <Pine.LNX.4.62.0602071018050.25222@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602071018050.25222@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071931.10230.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 19:19, Christoph Lameter wrote:

> @@ -1261,7 +1261,7 @@ struct page *alloc_pages_current(gfp_t g
>  		cpuset_update_task_memory_state();
>  	if (!pol || in_interrupt())
>  		pol = &default_policy;
> -	gfp |= pol->gfp_flags;
> +	gfp |= (pol->gfp_flags_high << 16);

Why don't you put it into zonelist_policy and pass a pointer to gfp
and then only do it for MPOL_BIND? The code should be similar because
it should be inline anyways (perhaps add a force_inline to be sure)

-Andi

