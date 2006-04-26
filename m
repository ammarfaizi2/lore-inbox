Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWDZQD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWDZQD2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 12:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWDZQD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 12:03:28 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:63250 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S964815AbWDZQD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 12:03:27 -0400
Date: Wed, 26 Apr 2006 18:03:23 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060426160323.GA29492@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Stephen Smalley <sds@tycho.nsa.gov>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com> <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu> <20060424082424.GH440@marowsky-bree.de> <1145882551.29648.23.camel@localhost.localdomain> <20060424124556.GA92027@dspnet.fr.eu.org> <1145883251.3116.27.camel@laptopd505.fenrus.org> <20060424140831.GA94722@dspnet.fr.eu.org> <1145982566.21399.40.camel@moss-spartans.epoch.ncsc.mil> <20060425222642.GA4921@dspnet.fr.eu.org> <1146053671.28745.48.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146053671.28745.48.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 08:14:31AM -0400, Stephen Smalley wrote:
> On Wed, 2006-04-26 at 00:26 +0200, Olivier Galibert wrote:
> > On Tue, Apr 25, 2006 at 12:29:26PM -0400, Stephen Smalley wrote:
> > > This generally indicates a problem in policy or the application that
> > > needs to be fixed.  It doesn't mean that object labeling is itself
> > > problematic, anymore than the existing owner and mode information in the
> > > inode is inherently problematic.
> > 
> > Default owner and mode are handled by the kernel because otherwise it
> > would indeed be inherently problematic.  Don't expect normal
> > applications, editors or xml libraries to change from the normal
> > open(fname, O_RDWR|O_CREAT|O_TRUNC, 0666).  SELinux is not, and will
> > not, ever, be their problem.
> 
> First, default labeling is also handled by the kernel, as with default
> owner and mode.  Files will be labeled in accordance with the policy
> based on the label of the creating process, the label of a related
> object (parent directory, to support inheritance properties when
> appropriate), and policy rules.  But this is not always sufficient, any
> more than default owner and mode is always sufficient for file creation.

And how do you plan to get correct default label without taking
paths/names into account but only the parent directory, for these
files created by the exact same text editor:
- $HOME/.slrnrc
- $HOME/.fetchmailrc
- $HOME/.procmailrc
- $HOME/todo.txt


> Second, the entire point of SELinux is to get MAC into the mainstream,
> and it is enabled by default in Fedora.  Unless that changes, it should
> gradually affect a change in the applications to adapt to the presence
> of SELinux, just as they have gradually adapted to other changes in the
> kernel.  Such change is always painful, but MAC is necessary as a
> fundamental building block if we are going to ever have improved
> security.  And not all applications have to change; many can just use
> the default behaviors.

Something will have to tell the system that certain file names/paths
are a-priori special, whether they exist or not.  And I *mean* file
names, not objects.  And that won't happen reliably in userspace.



> Um, perhaps you could be more concrete?  Difficult to have a rational
> discussion otherwise.  This division of "protecting application
> behavior" vs. "protecting files" is arbitrary and meaningless.   

Well, take the example of .procmailrc.  It is a file that is taken
into account if it exists, but doesn't have to exist.  It is a file
which can be used to copy all the mail of one user to somewhere else,
so it is very data-security sensitive.  So this is a file that may or
may not exist, which should not be created by anybody else than the
user itself (after all, you're into protecting from root too), and
needs to be able to be created by a mac-unaware, user-preferred text
editor and just work.  How do you expect to handle that reliably
without path-based mechanisms in the kernel?

You need path-based mechanisms to at least:
- prevent/allow some specific names from being created in specific
  conditions. 

- give correct default labels to new files

Object labelling won't help here simply because all of that happens on
file creation.  And you need path-based mechanisms if you want to have
any kind of decent problem tolerance.  Because at that point, SELinux
having prevented me twice to log into my own system on the console
with two different distributions for similar causes (labels lost), I
won't trust it for any system I want to be able to access remotely
with a decent chance of success in case of problems.

  OG.

