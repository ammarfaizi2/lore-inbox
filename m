Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbUJZRJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbUJZRJG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbUJZRIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:08:10 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:31112 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261352AbUJZRHv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:07:51 -0400
Date: Tue, 26 Oct 2004 21:08:15 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: David Vrabel <dvrabel@arcom.com>, Linus Torvalds <torvalds@osdl.org>,
       Len Brown <len.brown@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Versioning of tree
Message-ID: <20041026190815.GA8338@mars.ravnborg.org>
Mail-Followup-To: David Vrabel <dvrabel@arcom.com>,
	Linus Torvalds <torvalds@osdl.org>, Len Brown <len.brown@intel.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1098254970.3223.6.camel@gaston> <1098256951.26595.4296.camel@d845pe> <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org> <20041025234736.GF10638@michonline.com> <417E39AE.5020209@arcom.com> <20041026122632.GH10638@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026122632.GH10638@michonline.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 08:26:33AM -0400, Ryan Anderson wrote:
> On Tue, Oct 26, 2004 at 12:49:02PM +0100, David Vrabel wrote:
> > Ryan Anderson wrote:
> > >
> > >Well, here's a patch that adds -BKxxxxxxxx to LOCALVERSION when a
> > >top-level BitKeeper tree is detected.
> > >[...]
> > > LOCALVERSION = $(subst $(space),, \
> > > 	       $(shell cat /dev/null $(localversion-files)) \
> > >+	       $(subst ",,$(localversion-bk)) \
> > 
> > Surely there's no need for this?  Can't the script spit out an 
> > appropriate localversion* file instead?
> 
> It can, and yes, my first version used that method.
> 
> Except it never worked.  I was able to generate the file before
> include/linux/version.h was rebuilt, but failed to get it picked up in
> that.  I'm not really sure why.

The $(wildcard ...) function was executed before you created the file.
If we shall retreive the version from a SCM then as you already do
must hide it in a script.
I want the script only to be executed when we actually ask kbuild to
build a kernel - so it has to be part of the prepare rule set.
Furthermore I like to avoid a dependency on perl for a basic kernel.

Can you retreive the version from bk using a simple shell script?

	Sam
