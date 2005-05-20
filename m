Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVETPXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVETPXU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 11:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVETPW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 11:22:59 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:37267 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261495AbVETPUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 11:20:19 -0400
Date: Fri, 20 May 2005 10:20:03 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Serge Hallyn <serue@us.ibm.com>, mhalcrow@us.ibm.com
Subject: [patch 8/7] BSD Secure Levels: unregister on sysfs failure
Message-ID: <20050520152002.GG5534@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050517152303.GA2814@halcrow.us> <20050519205525.GB16215@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050519205525.GB16215@halcrow.us>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a feeble ode to Douglas Adams, this is the 8th in a series of 7
patches.  It fixes the issue where the security ops were not being
released on sysfs registration failure.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

Index: linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c
===================================================================
--- linux-2.6.12-rc4-mm2-seclvl.orig/security/seclvl.c	2005-05-20 09:09:42.000000000 -0500
+++ linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c	2005-05-20 09:09:46.000000000 -0500
@@ -766,6 +766,7 @@
 	} /* if we registered ourselves with the security framework */
 	if ((rc = do_sysfs_registrations())) {
 		seclvl_printk(0, KERN_ERR, "Error registering with sysfs\n");
+		unregister_security(&seclvl_ops);
 		goto exit;
 	}
 	seclvl_printk(0, KERN_INFO, "seclvl: Successfully initialized.\n");
