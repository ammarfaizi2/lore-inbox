Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbWEBWsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWEBWsX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 18:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWEBWsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 18:48:23 -0400
Received: from waste.org ([64.81.244.121]:6295 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S965026AbWEBWsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 18:48:23 -0400
Date: Tue, 2 May 2006 17:44:11 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] clean-up initcall warning for netconsole
Message-ID: <20060502224411.GG15445@waste.org>
References: <200604281406.34217.ak@suse.de> <20060428105403.250eb2d6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060428105403.250eb2d6.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 10:54:03AM -0700, Andrew Morton wrote:
> Yeah.  I think netconsole is just being wrong here.  If it wasn't enabled
> there's no error.

Here's a fix:

Index: 2.6/drivers/net/netconsole.c
===================================================================
--- 2.6.orig/drivers/net/netconsole.c	2006-05-02 17:28:43.000000000 -0500
+++ 2.6/drivers/net/netconsole.c	2006-05-02 17:43:37.000000000 -0500
@@ -107,7 +107,7 @@ static int init_netconsole(void)
 
 	if(!configured) {
 		printk("netconsole: not configured, aborting\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	if(netpoll_setup(&np))


-- 
Mathematics is the supreme nostalgia of our time.
