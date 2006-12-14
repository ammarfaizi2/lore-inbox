Return-Path: <linux-kernel-owner+w=401wt.eu-S1751893AbWLNAzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbWLNAzz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbWLNAzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:55:54 -0500
Received: from cantor2.suse.de ([195.135.220.15]:41859 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893AbWLNAzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:55:54 -0500
Date: Wed, 13 Dec 2006 16:55:32 -0800
From: Greg KH <gregkh@suse.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061214005532.GA12790@suse.de>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22299.1166057009@lwn.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 05:43:29PM -0700, Jonathan Corbet wrote:
> Greg's patch:
> 
> > +			printk(KERN_WARNING "%s: This module will not be able "
> > +				"to be loaded after January 1, 2008 due to its "
> > +				"license.\n", mod->name);
> 
> If you're going to go ahead with this, shouldn't the message say that
> the module will not be loadable into *kernels released* after January 1,
> 2008?  I bet a lot of people would read the above to say that their
> system will just drop dead of a New Year's hangover, and they'll freak.
> I wouldn't want to be the one getting all the email at that point...

Heh, good point.

An updated version is below.

Oh, and for those who have asked me how we would enforce this after this
date if this decision is made, I'd like to go on record that I will be
glad to take whatever legal means necessary to stop people from
violating this.

Someone also mentioned that we could just put a nice poem into the
kernel module image in order to be able to enforce our copyright license
in any court of law.

	Full bellies of fish
	Penguins sleep under the moon
	Dream of wings that fly

thanks,

greg k-h

--------------

From: Greg Kroah-Hartmna <gregkh@suse.de>
Subject: Notify non-GPL module loading will be going away in January 2008

Numerous kernel developers feel that loading non-GPL drivers into the
kernel violates the license of the kernel and their copyright.  Because
of this, a one year notice for everyone to address any non-GPL
compatible modules has been set.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 Documentation/feature-removal-schedule.txt |    9 +++++++++
 kernel/module.c                            |    7 ++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

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
+Who:	Greg Kroah-Hartman <greg@kroah.com> <gregkh@novell.com>
+
+---------------------------
--- gregkh-2.6.orig/kernel/module.c
+++ gregkh-2.6/kernel/module.c
@@ -1393,9 +1393,14 @@ static void set_license(struct module *m
 		license = "unspecified";
 
 	if (!license_is_gpl_compatible(license)) {
-		if (!(tainted & TAINT_PROPRIETARY_MODULE))
+		if (!(tainted & TAINT_PROPRIETARY_MODULE)) {
 			printk(KERN_WARNING "%s: module license '%s' taints "
 				"kernel.\n", mod->name, license);
+			printk(KERN_WARNING "%s: This module will not be able "
+				"to be loaded in any kernel released after "
+				"January 1, 2008 due to its license.\n",
+				mod->name);
+		}
 		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
 	}
 }
