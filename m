Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932750AbWEXNzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750AbWEXNzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 09:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932753AbWEXNzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 09:55:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56721 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932750AbWEXNzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 09:55:52 -0400
Date: Wed, 24 May 2006 09:55:33 -0400
From: Dave Jones <davej@redhat.com>
To: Theodore Tso <tytso@mit.edu>, Greg KH <greg@kroah.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add user taint flag
Message-ID: <20060524135533.GD28702@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Theodore Tso <tytso@mit.edu>, Greg KH <greg@kroah.com>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <E1FhwyO-0001YQ-O1@candygram.thunk.org> <20060523184506.GA29044@kroah.com> <20060524133916.GC16705@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524133916.GC16705@thunk.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 09:39:16AM -0400, Theodore Tso wrote:
 > On Tue, May 23, 2006 at 11:45:06AM -0700, Greg KH wrote:
 > > On Sun, May 21, 2006 at 07:04:32PM -0400, Theodore Ts'o wrote:
 > > > --- linux-2.6.orig/kernel/panic.c	2006-04-28 21:16:55.000000000 -0400
 > > > +++ linux-2.6/kernel/panic.c	2006-05-21 19:00:15.000000000 -0400
 > > > @@ -150,6 +150,7 @@
 > > >   *  'R' - User forced a module unload.
 > > >   *  'M' - Machine had a machine check experience.
 > > >   *  'B' - System has hit bad_page.
 > > > + *  'U' - Userspace-defined naughtiness.
 > > 
 > > Just a note, some other distros already use the 'U' flag in taint
 > > messages to show an "unsupported" module has been loaded.  I know it's
 > > out-of-the-tree and will never go into mainline, just FYI if you happen
 > > to see some 'U' flags in the wild today...
 > > 
 > > Oh, and I like this feature, makes sense to me to have this.
 > 
 > Should we worry about collisions with what distributions are using?
 > That could cause confusion in the future....

We use it in Fedora/RHEL if a module is loaded that hasn't been gpg signed.
It's been handy to spot things like 3rd parties replacing jbd.ko with
their own variant in bug-reports.

The signed modules stuff went over like a lead balloon when that was posted
last time.  Pushing the bit of the patch that describes the taint flag
may make sense though to make sure there aren't collisions like this.
I agree there is scope for confusion here, and imo kernel.org should be
the canonical place where these flags are defined, even if the kernel.org
tree doesn't actually use them all.

		Dave

-- 
http://www.codemonkey.org.uk
