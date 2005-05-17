Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVEQJxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVEQJxP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 05:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVEQJxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 05:53:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14809 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261348AbVEQJxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 05:53:03 -0400
Date: Tue, 17 May 2005 17:57:04 +0800
From: David Teigland <teigland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 0/8] dlm: overview
Message-ID: <20050517095704.GA12081@redhat.com>
References: <20050516071949.GE7094@redhat.com> <20050517001133.64d50d8c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517001133.64d50d8c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 12:11:33AM -0700, Andrew Morton wrote:

> The usual fallback is to identify all the stakeholders and get them to say
> "yes Andrew, this code is cool and we can use it", but I don't think the
> clustering teams have sufficent act-togetherness to be able to do that.
> 
> Am I correct in believing that this DLM is designed to be used by multiple
> clustering products?  If so, which ones, and how far along are they?

Correct.  Red Hat has multiple clustering products that do and will use
this.  GFS and CLVM are two notable ones that do now.  GFS kernel patches
that use this will be sent in the near future; CLVM uses the dlm from user
space.

Here are my impressions of where other clustering groups are at:

OpenSSI: this project is interested in integrating an existing dlm into
their system.  They don't have any effort under way to develop a dlm
themselves.  They are also interested in using gfs which is indirectly an
interest in the dlm.

Linux-HA: seem to be in a similar situation as OpenSSI

Lustre: this project includes a locking system called "dlm".  The api is
similar, but the implementation is not distributed in the style of a
traditional dlm; what they have is largely Lustre-specific [1].

OCFS2: this project includes a dlm intended for OCFS2, but there have been
some steps to make it more generic.  I believe their goal is still to
develop their dlm primarily for ocfs2's needs, not to develop an entirely
general purpose dlm such as this one.  So again, what's there is limited
and largely OCFS2-specific [1].

It would be very good to hear from any others who are interested in using
a dlm, too.

[1] Application-specific lock managers such as Lustre's and OCFS2's can be
good ideas, and I'm not criticising them.  It allows you to make
specializations and simplifications to suit your particular needs.  So,
while I'm sure it's possible for them to use this general-purpose dlm,
some may still want to do their own specialized thing.  We'll try to add
features and options to the general-purpose dlm to meet specialized needs,
but there's a limit to that.


> Looking at Ted's latest Kernel Summit agenda I see
> 
>  Clustering
> 
>  	We need to make progress on the kernel integration of things
>  	like message passing, membership, DLM etc.
> 
>  	We seem to have at least two comparable kernel-side offerings
>  	(OpenSSI and RHAT's), as well as a need to hash out how user-space
>  	plays into this.
> 
>  	(There is now a plan for a Clustering Summit prior to KS - need
>  	to validate if this will be useful, still)
> 
> So right now I'm inclined to duck any decision making and see what happens
> in July.  Does that sounds sane?  Is that Clustering Summit going to happen?

To some extent I'm sure the different clustering meetings will happen,
although I won't be at any of them.  I'm forging ahead trying to work
things out rather than waiting.  (Frankly, I don't think waiting for a
cluster summit will matter much.)

It's worth noting that most of the clustering discussions are now about
user space stuff.  Since the dlm is agnostic about what's in user space,
the dlm discussion and other clustering topics are largely independent.


> In the meanwhile I can pop this code into -mm so it gets a bit more
> compile testing, review and exposure, but that wouldn't signify anything
> further.

Sure, more feedback is what we're after.

Dave

