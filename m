Return-Path: <linux-kernel-owner+w=401wt.eu-S1751608AbWLNAdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbWLNAdK (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbWLNAdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:33:10 -0500
Received: from cantor.suse.de ([195.135.220.2]:36137 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608AbWLNAdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:33:09 -0500
Date: Wed, 13 Dec 2006 16:32:46 -0800
From: Greg KH <gregkh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061214003246.GA12162@suse.de>
References: <20061213195226.GA6736@kroah.com> <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org> <f2b55d220612131238h6829f51ao96c17abbd1d0b71d@mail.gmail.com> <20061213210219.GA9410@suse.de> <45807182.1060408@mbligh.org> <20061213134721.d8ff8c11.akpm@osdl.org> <20061213220911.GA10677@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061213220911.GA10677@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 02:09:11PM -0800, Greg KH wrote:
> On Wed, Dec 13, 2006 at 01:47:21PM -0800, Andrew Morton wrote:
> > On Wed, 13 Dec 2006 13:32:50 -0800
> > Martin Bligh <mbligh@mbligh.org> wrote:
> > 
> > > So let's come out and ban binary modules, rather than pussyfooting
> > > around, if that's what we actually want to do.
> > 
> > Give people 12 months warning (time to work out what they're going to do,
> > talk with the legal dept, etc) then make the kernel load only GPL-tagged
> > modules.
> > 
> > I think I'd favour that.  It would aid those people who are trying to
> > obtain device specs, and who are persuading organisations to GPL their drivers.
> 
> Ok, I have no objection to that at all.  I'll whip up such a patch in a
> bit to spit out kernel log messages whenever such a module is loaded so
> that people have some warning.

Here you go.  The wording for the feature-removal-schedule.txt file
could probably be cleaned up.  Any suggestions would be welcome.

thanks,

greg k-h

-----------
From: Greg Kroah-Hartmna <gregkh@suse.de>
Subject: Notify non-GPL module loading will be going away in January 2008

Numerous kernel developers feel that loading non-GPL drivers into the
kernel violates the license of the kernel and their copyright.  Because
of this, a one year notice for everyone to address any non-GPL
compatible modules has been set.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 Documentation/feature-removal-schedule.txt |    9 +++++++++
 kernel/module.c                            |    6 +++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

--- gregkh-2.6.orig/Documentation/feature-removal-schedule.txt
+++ gregkh-2.6/Documentation/feature-removal-schedule.txt
@@ -281,3 +281,12 @@ Why:	Speedstep-centrino driver with ACPI
 Who:	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
 
 ---------------------------
+
+What:	non GPL licensed modules will able to be loaded successfully.
+When:	January 2008
+Why:	Numerous kernel developers feel that loading non-GPL drivers into the
+	kernel violates the license of the kernel and their copyright.
+
+Who:	Greg Kroah-Hartman <greg@kroah.com> or <gregkh@suse.de>
+
+---------------------------
--- gregkh-2.6.orig/kernel/module.c
+++ gregkh-2.6/kernel/module.c
@@ -1393,9 +1393,13 @@ static void set_license(struct module *m
 		license = "unspecified";
 
 	if (!license_is_gpl_compatible(license)) {
-		if (!(tainted & TAINT_PROPRIETARY_MODULE))
+		if (!(tainted & TAINT_PROPRIETARY_MODULE)) {
 			printk(KERN_WARNING "%s: module license '%s' taints "
 				"kernel.\n", mod->name, license);
+			printk(KERN_WARNING "%s: This module will not be able "
+				"to be loaded after January 1, 2008 due to its "
+				"license.\n", mod->name);
+		}
 		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
 	}
 }
