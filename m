Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVBWWsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVBWWsQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 17:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVBWWrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 17:47:42 -0500
Received: from waste.org ([216.27.176.166]:50147 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261647AbVBWWpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:45:41 -0500
Date: Wed, 23 Feb 2005 14:45:30 -0800
From: Matt Mackall <mpm@selenic.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1 (VFS: Cannot open root device "301")
Message-ID: <20050223224530.GE3163@waste.org>
References: <20050223014233.6710fd73.akpm@osdl.org> <421CB161.7060900@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421CB161.7060900@mesatop.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 09:37:53AM -0700, Steven Cole wrote:
> I copied a working .config from an earlier kernel(-rc3), and ran make 
> oldconfig, answering most of the new questions 'n'.

Then you get into trouble with stuff under CONFIG_EMBEDDED. Answering
'n' turns off stock functionality. Though you really ought not have
CONFIG_EMBEDDED turned on anyway. I'm not sure how CONFIG_BASE_SMALL
is causing problems as the blockdev bit got dropped already. I'll poke
around..

Andrew, looks like turning on EMBEDDED causes a bunch of options to
spill onto the general setup menu in menuconfig because of the
placement of the bool piece:


Fix up bustedness in menuconfig

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: mm1/init/Kconfig
===================================================================
--- mm1.orig/init/Kconfig	2005-02-23 13:32:38.000000000 -0800
+++ mm1/init/Kconfig	2005-02-23 14:27:18.699676896 -0800
@@ -274,11 +274,6 @@ config BASE_FULL
 	  Disabling this option reduces the size of miscellaneous core
 	  kernel data structures.
 
-config BASE_SMALL
-	int
-	default 0 if BASE_FULL
-	default 1 if !BASE_FULL
-
 config FUTEX
 	bool "Enable futex support" if EMBEDDED
 	default y
@@ -360,6 +355,11 @@ config TINY_SHMEM
 	default !SHMEM
 	bool
 
+config BASE_SMALL
+	int
+	default 0 if BASE_FULL
+	default 1 if !BASE_FULL
+
 menu "Loadable module support"
 
 config MODULES

-- 
Mathematics is the supreme nostalgia of our time.
