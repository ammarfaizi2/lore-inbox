Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbUJZM1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbUJZM1H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 08:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbUJZM1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 08:27:07 -0400
Received: from mail.autoweb.net ([198.172.237.26]:3591 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262234AbUJZM1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 08:27:02 -0400
Date: Tue, 26 Oct 2004 08:26:33 -0400
From: Ryan Anderson <ryan@michonline.com>
To: David Vrabel <dvrabel@arcom.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Len Brown <len.brown@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Versioning of tree
Message-ID: <20041026122632.GH10638@michonline.com>
Mail-Followup-To: David Vrabel <dvrabel@arcom.com>,
	Linus Torvalds <torvalds@osdl.org>, Len Brown <len.brown@intel.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1098254970.3223.6.camel@gaston> <1098256951.26595.4296.camel@d845pe> <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org> <20041025234736.GF10638@michonline.com> <417E39AE.5020209@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417E39AE.5020209@arcom.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 12:49:02PM +0100, David Vrabel wrote:
> Ryan Anderson wrote:
> >
> >Well, here's a patch that adds -BKxxxxxxxx to LOCALVERSION when a
> >top-level BitKeeper tree is detected.
> >[...]
> > LOCALVERSION = $(subst $(space),, \
> > 	       $(shell cat /dev/null $(localversion-files)) \
> >+	       $(subst ",,$(localversion-bk)) \
> 
> Surely there's no need for this?  Can't the script spit out an 
> appropriate localversion* file instead?

It can, and yes, my first version used that method.

Except it never worked.  I was able to generate the file before
include/linux/version.h was rebuilt, but failed to get it picked up in
that.  I'm not really sure why.

For what it's worth, "make deb-pkg" picks up the version correctly using
this method:
	dpkg-deb: building package `linux-2.6.10-rc1-bkd581e3d1' in
	`../linux-2.6.10-rc1-bkd581e3d1_2.6.10-rc1-BKd581e3d1_i386.deb'.

> Tools like Debian's make-kpkg have to work out the kernel version (for 
> use in the package name etc.) and it would be preferable if the method 
> for generating the version didn't change too often.

Well, I didn't think make-kpkg was doing anything horribly unexpected,
so I didn't to test that.   I'll do a test run now to see what happens,
though.

-- 

Ryan Anderson
  sometimes Pug Majere
