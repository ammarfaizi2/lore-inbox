Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWIJXYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWIJXYY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 19:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWIJXYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 19:24:24 -0400
Received: from thunk.org ([69.25.196.29]:18073 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964820AbWIJXYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 19:24:24 -0400
Date: Sun, 10 Sep 2006 19:24:12 -0400
From: Theodore Tso <tytso@mit.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060910232412.GE22892@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, Pavel Machek <pavel@ucw.cz>,
	David Madore <david.madore@ens.fr>,
	Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
References: <20060905212643.GA13613@clipper.ens.fr> <20060906002730.23586.qmail@web36609.mail.mud.yahoo.com> <20060906100610.GA16395@clipper.ens.fr> <20060906132623.GA15665@clipper.ens.fr> <20060909231805.GC24906@thunk.org> <20060910123631.GA4206@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910123631.GA4206@ucw.cz>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2006 at 12:36:31PM +0000, Pavel Machek wrote:
> > I agree it may be less convenient for a system administrator who is
> > used root, cd'ing to a colleagues source tree, su'ing to root, and who
> > then types "make" to compile a program, expecting it to work since
> > root privileges imply the ability to override filesystem discretionary
> > access control --- and then to be rudely surprised when this doesn't
> > work in a capabilities-enabled system.  However, I would claim this is
> > the correct behaviour!
> 
> But this is not how it behaves today, right? I do not think you could
> push 'break-make-as-root' as a bugfix to -stable ;-).

No, this would be an alternate model that if enabled would give us the
full Posix Capabilities draft compliance and which would hopefully
make us be mostly compatible with Trusted Solaris and Trusted Irix.
Like SELinux, it's something that would have to be explicitly enabled,
and yes, does break compatibility with standard root privileges ---
but then again, break apart root privs was the whole *point* of the
Posix capabilities design....

> > absence of an explicit capability record.  Both of these should be
> > overrideable by a mount option, but for convenience's sake it would be
> > convenient to be able to set these values in the superblock.
> 
> Would per-system default capability masks be enough? ... .... okay,
> probably not, because nosuid is per-mount, and this is similar.

Per system defaults would also be good, but I believe it would also be
a good idea for their to be per-filesystem defaults.  Yes, not all
filesystems would support per-filesystem defaults, since this requires
extensions in their superblock; for those, they would only have the
per-system defaults.

> > As far as negative capabilities, I feel rather strongly these should
> > not be separated into separate capability masks.  They can use the
> > same framework, sure, but I think the system will be much safer if
> > they use a different set of masks.  Otherwise, there can be a whole
> > class of mistakes caused by people and applications getting confused
> 
> Can we simply split them at kernel interface layer? Libc could do it,
> preventing confusion...

But that means libc would need to know which bit positions were
positive capabilities, and which were negative, and adding new
capabilities would require a matching change with libc.  Not a good
idea, I think....

					- Ted
