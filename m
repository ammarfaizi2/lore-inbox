Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbUKJTck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbUKJTck (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 14:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbUKJTck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 14:32:40 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:59606 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262107AbUKJTcb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 14:32:31 -0500
Date: Wed, 10 Nov 2004 13:32:29 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [RFC] [PATCH] [2/6] LSM Stacking: Add stacker LSM
Message-ID: <20041110193229.GA3480@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <1099609681.2096.16.camel@serge.austin.ibm.com> <20041110174358.32392.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041110174358.32392.qmail@lwn.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unless I've missed it, you never check num_stacked_modules against
> CONFIG_NUM_LSMS.  If somebody loads too many modules, they risk
> overflowing all of those void * security arrays you've added to so many
> kernel data structures, and thus corrupting those structures.  That, in
> technical terms, would be a bummer.
> 
> In stacker_unregister(), you do:
> 
> > +	num_stacked_modules--;
> 
> What happens if you unload anything other than the last module, then
> load something else?  When you return num_stacked_modules-1 to the new
> module, you'll point it to a slot in those security arrays which is
> already used by another module.  The result seems unlikely to improve
> security.
> 
> Unless I'm simply confused?  It's happened before...

No, you're not.  While I sent out all the patches to make the first
patch useful, the stacker patch was the same one I've been using with
several other approaches to sharing the void * security arrays.  If
the first patch turned out to be acceptable, the stacker patch would
have been tweaked quite a bit.  As Chris Wright pointed out, the list
of stacked modules would no longer need to be a linked list, and so
the semaphore guarding that list could be dropped.  And of course
your points are valid.

I am working on a new implementation, which I will send first to the
lsm list and lsm and selinux maintainers.  Lmbench numbers from this
morning show that with this approach, a kernel with selinux +
capabilities shows no performance degradation.

thanks,
-serge
