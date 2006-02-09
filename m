Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWBIUFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWBIUFS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 15:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWBIUFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 15:05:18 -0500
Received: from ns1.suse.de ([195.135.220.2]:42658 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750752AbWBIUFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 15:05:16 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: Terminate process that fails on a constrained allocation V3
Date: Thu, 9 Feb 2006 21:05:04 +0100
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, pj@sgi.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0602091152300.9941@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602091152300.9941@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602092105.04412.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 February 2006 20:53, Christoph Lameter wrote:
> Changes V2->V3:
> 
> - Do the killing of the current process following the execution
>   procedure already established by the OOM killer.
> 
> - Do not return NULL and therefore do not change the return values of
>   __alloc_pages.

Hmm, to make this work well i guess mmap() would need to be changed
to take the policy into account when doing the !MAP_NORESERVE checking
when the kernel runs in strict no overcommit mode.
Otherwise there is no fool proof way an application can prevent getting killed.
And mbind() would need to recompute it and fail if the new policy's possible
allocation are not guaranteed to work.

Doing this all properly would probably get quite messy.

-Andi
