Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262430AbUK3XFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbUK3XFu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbUK3XFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:05:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:13473 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262430AbUK3XDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:03:53 -0500
Date: Tue, 30 Nov 2004 15:03:45 -0800
From: Chris Wright <chrisw@osdl.org>
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org, ttb@tentacle.dhs.org
Subject: Re: [patch] inotify: a replacement for dnotify
Message-ID: <20041130150345.K14339@build.pdx.osdl.net>
References: <1101854070.4493.52.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1101854070.4493.52.camel@betsy.boston.ximian.com>; from rml@novell.com on Tue, Nov 30, 2004 at 05:34:30PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Robert Love (rml@novell.com) wrote:
> +	user = find_user(current->user->uid);
> +	if (!user)
> +		return -ENOMEM;

Can just be:

	get_uid(current->user);

> +
> +	if (atomic_read(&user->inotify_devs) >= sysfs_attrib_max_user_devices)
> +		return -ENOSPC;
> +
> +	atomic_inc(&current->user->inotify_devs);
> +
> +	dev = kmalloc(sizeof(struct inotify_device), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;

Looks like these error conditions leak a refcount on the user_struct.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
