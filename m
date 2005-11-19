Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbVKSAVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbVKSAVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 19:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVKSAVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 19:21:39 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:19101 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750933AbVKSAVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 19:21:39 -0500
Date: Fri, 18 Nov 2005 16:21:12 -0800
From: Paul Jackson <pj@sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 2/8] Create emergency trigger
Message-Id: <20051118162112.7bf21df5.pj@sgi.com>
In-Reply-To: <437E2D57.9050304@us.ibm.com>
References: <437E2C69.4000708@us.ibm.com>
	<437E2D57.9050304@us.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -876,6 +879,16 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
>  	int can_try_harder;
>  	int did_some_progress;
>  
> +	if (is_emergency_alloc(gfp_mask)) {

Can this check for is_emergency_alloc be moved lower in __alloc_pages?

I don't see any reason why most __alloc_pages() calls, that succeed
easily in the first loop over the zonelist, have to make this check.
This would save one conditional test and jump on the most heavily
used code path in __alloc_pages().

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
