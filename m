Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267976AbUIBIg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267976AbUIBIg3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 04:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267869AbUIBIfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 04:35:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:43915 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267904AbUIBIei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 04:34:38 -0400
Date: Thu, 2 Sep 2004 10:34:08 +0200
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@ximian.com>
Cc: akpm@osdl.org, kay.sievers@vrfy.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040902083407.GC3191@kroah.com>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com> <20040831145643.08fdf612.akpm@osdl.org> <1093989513.4815.45.camel@betsy.boston.ximian.com> <20040831150645.4aa8fd27.akpm@osdl.org> <1093989924.4815.56.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093989924.4815.56.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 06:05:24PM -0400, Robert Love wrote:
> +int send_kevent(enum kevent type, struct kset *kset,
> +		struct kobject *kobj, const char *signal);

Why is the kset needed?  We can determine that from the kobject.

How about changing this to:
	int send_kevent(struct kobject *kobj, struct attribute *attr);
which just tells userspace that a specific attribute needs to be read,
as something "important" has changed.

Will passing the attribute name be able to successfully handle the 
"enum kevent" and "signal" combinations?

thanks,

greg k-h
