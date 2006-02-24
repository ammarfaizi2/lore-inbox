Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWBXBO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWBXBO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWBXBOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:14:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50831 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932367AbWBXBOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:14:54 -0500
Date: Thu, 23 Feb 2006 17:13:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: suparna@in.ibm.com, sct@redhat.com, mason@suse.com,
       linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org,
       sonny@burdell.org
Subject: Re: [RFC][WIP] DIO simplification and AIO-DIO stability
Message-Id: <20060223171336.7b412efc.akpm@osdl.org>
In-Reply-To: <1140741566.22756.170.camel@dyn9047017100.beaverton.ibm.com>
References: <20060223072955.GA14244@in.ibm.com>
	<1140741566.22756.170.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> I am still trying to understand the whole proposal to give you better
>  feedback. But, my gut feeling is - its not going to be any more simpler
>  than what we have today :(
> 

Yes, that's my general reaction as well.  That code's solving a complex and
messy problem, so it got complex and messy.

Of course, a reimplementation might certainly end up faster, cleaner,
better.  A throw-away-and-reimplement exercise often has that result, but
mainly because on the second time the reimplementors understand the full
scope of the problem at the outset rather than at the end.  So this time
around, as you imply, we'd need to get a full problem description and set
of testcases collected.

That code does a _lot_ of stuff.  Fortunately, It's basically all in
direct-io.c and that file exports a single function.  So it's possible that
a reimplmentation could tick along alongside the existing implementation and
ideally, it's just a matter of changing one entry in each filesystem's a_ops.

