Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVCJI0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVCJI0l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 03:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVCJI0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 03:26:39 -0500
Received: from cantor.suse.de ([195.135.220.2]:9156 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262446AbVCJI0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 03:26:01 -0500
Subject: Re: 2.6.Stable and EXTRAVERSION
From: Andreas Gruenbacher <agruen@suse.de>
To: "Justin M. Forbes" <jmforbes@linuxtx.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050309185331.GB19306@linuxtx.org>
References: <20050309185331.GB19306@linuxtx.org>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1110443153.25570.7.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 10 Mar 2005 09:25:54 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 19:53, Justin M. Forbes wrote:
> With the new stable series kernels, the .x versioning is being added to
> EXTRAVERSION.  This has traditionally been a space for local modification.
> I know several distributions are using EXTRAVERSION for build numbers,
> platform and assorted other information to differentiate their kernel
> releases.

It's no issue for us. We're using this patch to add in the RPM release
number:

Index: linux-2.6.10/Makefile
===================================================================
--- linux-2.6.10.orig/Makefile
+++ linux-2.6.10/Makefile
@@ -158,8 +158,11 @@ endif
 LOCALVERSION = $(subst $(space),, \
 	       $(shell cat /dev/null $(localversion-files:%~=)) \
 	       $(patsubst "%",%,$(CONFIG_LOCALVERSION)))
+ifneq ($(wildcard $(srctree)/rpm-release),)
+RPM_RELEASE := -$(shell cat $(srctree)/rpm-release)
+endif
 
-KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(LOCALVERSION)
+KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(RPM_RELEASE)$(LOCALVERSION)
 
 # SUBARCH tells the usermode build what the underlying arch is.  That is set
 # first, and if a usermode build is happening, the "ARCH=um" on the command


Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

