Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVGFXxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVGFXxt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVGFXvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 19:51:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:33482 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262429AbVGFXuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 19:50:18 -0400
Date: Wed, 6 Jul 2005 16:50:08 -0700
From: Greg KH <greg@kroah.com>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-audit@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>,
       Mounir Bsaibes <mbsaibes@us.ibm.com>, Steve Grubb <sgrubb@redhat.com>,
       Serge Hallyn <serue@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Message-ID: <20050706235008.GA9985@kroah.com>
References: <1120668881.8328.1.camel@localhost> <200507061523.11468.tinytim@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507061523.11468.tinytim@us.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 03:23:10PM -0500, Timothy R. Chavez wrote:
> This is similar to Inotify in that the audit subsystem watches for file
> system activity and collects information about inodes its interested 
> in, but this is where the similarities stop.  Despite the fact that the
> Inotify requirements only dictate a subset of the activity the audit
> subsystem is interested in, there is a more fundamental divergence 
> between the two projects.  Like audit, Inotify takes paths and resolves 
> them to a single inode.  But, unlike audit, Inotify does not find the path 
> itself interesting.

Huh?  inotify users find that path interesting, as they use it to act
apon.

> Much like the (device,inode)-based system call filters 
> currently available in the audit subsystem, Inotify targets only individual 
> inodes.  Thus, if the underlying inode associated with the file /etc/shadow 
> was changed, and /etc/shadow was being "watched", we'd lose auditability 
> on /etc/shadow across transactions.

That's why you watch /etc/ instead, which catches that rename.  That
being said, why would not inotify also want this functionality if you
think it is important?

> More so, Inotify cannot watch inodes that do not yet exist (because
> the file does not yet exist).  To do this, the audit subsystem must
> hook deeper than Inotify (in fs/dcache.c) to adapt with the file
> system as it changes.  Where it makes sense, the small set of
> notification hooks in the VFS that Inotify and audit could share
> should be consolidated.

As inotify works off of open file descriptors, yes, this is true.  But,
again, if you think this is really important, then why not just work
with inotify to provide that kind of support to it?

I suggest you work together with the inotify developers to hash out your
differences, as it sounds like you are duplicating a lot of the same
functionality.

Also, inotify handles the namespace issues of processes by working off
of a file descriptor.  How do you handle this?

Do you have any documetation or example userspace code that shows how to
use this auditfs interface you have created?

thanks,

greg k-h
