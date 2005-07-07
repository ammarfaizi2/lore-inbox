Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVGGRwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVGGRwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVGGRtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:49:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:49579 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261363AbVGGRtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:49:14 -0400
Date: Thu, 7 Jul 2005 10:48:52 -0700
From: Greg KH <greg@kroah.com>
To: serge@hallyn.com
Cc: serue@us.ibm.com, James Morris <jmorris@redhat.com>,
       Tony Jones <tonyj@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] securityfs
Message-ID: <20050707174852.GA19609@kroah.com>
References: <20050703182505.GA29491@immunix.com> <Xine.LNX.4.44.0507031450540.30297-100000@thoron.boston.redhat.com> <20050703204423.GA17418@kroah.com> <20050706220835.GA32005@serge.austin.ibm.com> <20050706222237.GB6696@kroah.com> <20050707173035.GA10503@vino.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707173035.GA10503@vino.hallyn.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 12:30:35PM -0500, serge@hallyn.com wrote:
> Quoting Greg KH (greg@kroah.com):
> > On Wed, Jul 06, 2005 at 05:08:35PM -0500, serue@us.ibm.com wrote:
> > > Quoting Greg KH (greg@kroah.com):
> > > > think it could be made even smaller if you use the default read and
> > > > write file type functions in libfs (look at the debugfs wrappers of them
> > > > for u8, u16, etc, for examples of how to use them.)
> > > 
> > > The attached patch cleans up the securelevel code for the seclvl file.
> > > Is this a reasonable way to go about this?
> > 
> > No.
> > 
> > > Or is there a better way to do this?
> > 
> > Look at how debugfs uses the libfs code.  We should not need to add
> > these handlers to securityfs.
> 
> Unfortunately the simple_attr code from libfs really doesn't seem to be
> usable for int args.

Why not?  You want a negative number?  Just cast the u64 to a signed int
then.  Will that not work?  If not we can tweak the libfs interface to
work properly for you.

> However the below patch follows some of the
> examples in debugfs and comes out cleaner than my original patch.

That is nicer.  But I think you can get it smaller with the libfs stuff
:)

thanks,

greg k-h
