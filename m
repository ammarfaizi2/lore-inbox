Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUIAAYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUIAAYL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269205AbUHaWAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:00:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:50854 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268310AbUHaV4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:56:48 -0400
Date: Tue, 31 Aug 2004 15:00:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Love <rml@ximian.com>
Cc: greg@kroah.com, kay.sievers@vrfy.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-Id: <20040831150015.2e0e0906.akpm@osdl.org>
In-Reply-To: <1093988576.4815.43.camel@betsy.boston.ximian.com>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@ximian.com> wrote:
>
> +int send_kevent(enum kevent type, struct kset *kset,
> +		struct kobject *kobj, const char *signal)
> +{
> +	const char *path;
> +	int ret;
> +
> +	path = kobject_get_path(kset, kobj, GFP_KERNEL);
> +	if (!path)
> +		return -ENOMEM;
> +
> +	ret =  do_send_kevent(type, GFP_KERNEL, path, signal);
> +	kfree(path);
> +
> +	return ret;
> +}
> +
> +EXPORT_SYMBOL_GPL(send_kevent);
> +
> +int send_kevent_atomic(enum kevent type, struct kset *kset,
> +		       struct kobject *kobj, const char *signal)
> +{
> +	const char *path;
> +	int ret;
> +
> +	path = kobject_get_path(kset, kobj, GFP_ATOMIC);
> +	if (!path)
> +		return -ENOMEM;
> +
> +	ret =  do_send_kevent(type, GFP_ATOMIC, path, signal);
> +	kfree(path);
> +
> +	return ret;
> +}

Why not share the implementation here?
