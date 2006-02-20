Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161086AbWBTRzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbWBTRzv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbWBTRzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:55:51 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:25738 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S1161086AbWBTRzu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:55:50 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc4-mm1
Date: Mon, 20 Feb 2006 18:54:00 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060220042615.5af1bddc.akpm@osdl.org>
In-Reply-To: <20060220042615.5af1bddc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602201854.01047.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 20. February 2006 13:26, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.
>6.16-rc4-mm1/

Doesn't compile on boxes without ccache -- patch below:

Don't depend on ccache, but use it if it's there

Signed-off-by: Bernhard Rosenkraenzer <bero@arklinux.org>

--- linux-2.6.15/Makefile.ark	2006-02-20 18:09:54.000000000 +0100
+++ linux-2.6.15/Makefile	2006-02-20 18:15:37.000000000 +0100
@@ -274,7 +274,7 @@
 
 AS		= $(CROSS_COMPILE)as
 LD		= $(CROSS_COMPILE)ld
-CC		= ccache $(CROSS_COMPILE)gcc
+CC		= $(shell ccache --version &>/dev/null && echo ccache) 
$(CROSS_COMPILE)gcc
 CPP		= $(CC) -E
 AR		= $(CROSS_COMPILE)ar
 NM		= $(CROSS_COMPILE)nm
