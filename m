Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVDBLo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVDBLo6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 06:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVDBLo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 06:44:58 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:46268 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261338AbVDBLo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 06:44:56 -0500
Date: Sat, 2 Apr 2005 03:43:13 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: blosure@sgi.com, mochel@digitalimplant.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: new SGI TIOCX driver in *-mm driver model locking broken
Message-Id: <20050402034313.4aa994f5.pj@engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like the new SGI TIOCX driver that Bruce Losure added to *-mm via
the patch "bk-ia64.patch" includes an instance of the old style driver
locking, that Patrick Mochel was changed to a new locking model.

If I try to compile 2.6.12-rc1-mm4 for SN2 with the config option

  CONFIG_SGI_TIOCX=y

the build fails with a bunch of errors on line 527 of tiocx.c, starting
with:

arch/ia64/sn/kernel/tiocx.c: In function `tiocx_exit':
arch/ia64/sn/kernel/tiocx.c:527: error: structure has no member named `bus_list'

The code in question includes the lines:

> static void __exit tiocx_exit(void)
> {
>         struct device *dev;
>         struct device *tdev;
> 
>         ...
>         list_for_each_entry_safe(dev, tdev, &tiocx_bus_type.devices.list,
>                                  bus_list) {

Someone, perhaps Patrick, needs to work the new locking model magic
on this piece of code.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
