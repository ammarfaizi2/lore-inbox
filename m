Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbUKOLXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbUKOLXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 06:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUKOLXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 06:23:51 -0500
Received: from hera.cwi.nl ([192.16.191.8]:47034 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261566AbUKOLXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 06:23:49 -0500
Date: Mon, 15 Nov 2004 12:23:23 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, Andries.Brouwer@cwi.nl
Subject: Re: 2.6.10-rc2 dm.c dm_init unresolved reference to _exits
Message-ID: <20041115112323.GI9939@apps.cwi.nl>
References: <27983.1100493381@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27983.1100493381@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 03:36:21PM +1100, Keith Owens wrote:

> ia64 build, gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-24)
> 
> drivers/md/dm.c dm_int refers to _exits which is defined as __exitdata.
> With CONFIG_HOTPLUG=n, __exitdata is discarded

Yes - thanks for reminding - thought of that yesterday night
but forgot again the next morning.

diff -uprN -X /linux/dontdiff a/drivers/md/dm.c b/drivers/md/dm.c
--- a/drivers/md/dm.c	2004-11-15 11:44:12.000000000 +0100
+++ b/drivers/md/dm.c	2004-11-15 11:46:35.000000000 +0100
@@ -146,7 +146,7 @@ int (*_inits[])(void) __initdata = {
 	dm_interface_init,
 };
 
-void (*_exits[])(void) __exitdata = {
+void (*_exits[])(void) = {
 	local_exit,
 	dm_target_exit,
 	dm_linear_exit,
