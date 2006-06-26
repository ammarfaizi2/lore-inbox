Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWFZERJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWFZERJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 00:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWFZERJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 00:17:09 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:18384 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932288AbWFZERI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 00:17:08 -0400
Date: Sun, 25 Jun 2006 21:17:00 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Ravikiran G Thirumalai <kiran@scalex86.org>, linux-kernel@vger.kernel.org
Subject: Re: remove __read_mostly?
In-Reply-To: <20060625115736.d90e1241.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606252112080.27464@schroedinger.engr.sgi.com>
References: <20060625115736.d90e1241.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006, Andrew Morton wrote:

> I'm thinking we should remove __read_mostly.
> 
> Because if we use this everywhere where it's supposed to be used, we end up
> with .bss and .data 100% populated with write-often variables, packed
> closely together.  The cachelines will really flying around.

What we really want is a write-often variable in a cacheline combined with 
infrequently read and write data. However, data that is frequently read 
(that is __read_mostly) would still need to be in a separate section.

> IOW: __read_mostly optimises read-mostly variables and pessimises
> write-often variables.
> 
> We want something which optimises both read-mostly and write-often storage.
>  We do that by marking the write-often variables with
> __cacheline_aligned_in_smp.
> 
> OK?

I think we would want to group write-often variables with infrequently 
used variable. But how does one convince the linker to doing that?

I agree that there is a problem with shift frequently written variables 
together which may in itself cause ill effects. So __read_mostly should 
only be used when we have identified real cacheline sharing problems and 
real cache hot variables may have to be put in a separate cacheline for 
itself. I think we already do that and that is at least the way I have 
handled it. Too many __read_mostly kill the whole point of the exercise.
