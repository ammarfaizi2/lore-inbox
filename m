Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWDTFkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWDTFkk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 01:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWDTFkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 01:40:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:9449 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751262AbWDTFkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 01:40:39 -0400
Date: Wed, 19 Apr 2006 22:36:04 -0700
From: Tony Jones <tonyj@suse.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 10/11] security: AppArmor - Add flags to d_path
Message-ID: <20060420053604.GA15332@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419175026.29149.23661.sendpatchset@ermintrude.int.wirex.com> <20060419221248.GB26694@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419221248.GB26694@infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 11:12:48PM +0100, Christoph Hellwig wrote:
> On Wed, Apr 19, 2006 at 10:50:26AM -0700, Tony Jones wrote:
> > This patch adds a new function d_path_flags which takes an additional flags
> > parameter.   Adding a new function rather than ammending the existing d_path
> > was done to avoid impact on the current users.
> > 
> > It is not essential for inclusion with AppArmor (the apparmor_mediation.patch
> > can easily be revised to use plain d_path) but it enables cleaner code 
> > ["(delete)" handling] and closes a loophole with pathname generation for 
> > chrooted tasks. 
> > 
> > It currently adds two flags:
> > 
> > DPATH_SYSROOT:
> > 	d_path should generate a path from the system root rather than the
> > 	task's current root. 
> > 
> > 	For AppArmor this enables generation of absolute pathnames in all
> > 	cases.  Currently when a task is chrooted, file access is reported
> > 	relative to the chroot.  Because it is currently not possible to 
> > 	obtain the absolute path in an SMP safe way, without this patch 
> > 	AppArmor will have to report chroot-relative pathnames.
> 
> This is utter bullshit.  There is no such thing as a system root,
> and should not rely on pathes making any sense for anything but the
> process using at at this point of time.  This stuff will not get in either
> in d_path or whatever duplicate of it you'd try to submit.

You are correct on calling BS in that I was wrong to refer to it as the
"system root".  When a task chroots relative to it's current namespace, we
are interested in the path back to the root of that namespace, rather than
to the chroot.  I believe the patch as stands achieves this, albeit with
some changing of comments.

thanks!

Tony
