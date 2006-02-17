Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWBQPZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWBQPZl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWBQPZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:25:41 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:16614 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1751457AbWBQPZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:25:40 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] show "SN Devices" menu only if CONFIG_SGI_SN
References: <20060217132245.GG4422@stusta.de>
From: Jes Sorensen <jes@sgi.com>
Date: 17 Feb 2006 10:25:39 -0500
In-Reply-To: <20060217132245.GG4422@stusta.de>
Message-ID: <yq08xsaxb0s.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Adrian" == Adrian Bunk <bunk@stusta.de> writes:

Adrian> On architectures like i386, the "Multimedia Capabilities Port
Adrian> drivers" menu is visible, but it can't be visited since it
Adrian> contains nothing usable for CONFIG_SGI_SN=n.

Thats only a third of the patch, if you want to do that, you should
remove the redundant SGI_SN checks below.

Like this.

Jes

 drivers/sn/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/sn/Kconfig
===================================================================
--- linux-2.6.orig/drivers/sn/Kconfig
+++ linux-2.6/drivers/sn/Kconfig
@@ -3,10 +3,11 @@
 #
 
 menu "SN Devices"
+	depends on SGI_SN
 
 config SGI_IOC4
 	tristate "SGI IOC4 Base IO support"
-	depends on (IA64_GENERIC || IA64_SGI_SN2) && MMTIMER
+	depends on MMTIMER
 	default m
 	---help---
 	This option enables basic support for the SGI IOC4-based Base IO
@@ -19,7 +20,6 @@
 
 config SGI_IOC3
 	tristate "SGI IOC3 Base IO support"
-	depends on (IA64_GENERIC || IA64_SGI_SN2)
 	default m
 	---help---
 	This option enables basic support for the SGI IOC3-based Base IO
