Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbUK2WZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbUK2WZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbUK2WZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:25:46 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:7591 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261835AbUK2WXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:23:32 -0500
Date: Mon, 29 Nov 2004 14:23:23 -0800
From: Greg KH <greg@kroah.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH] CKRM: 5/10 CKRM:  Task based management for CPU, memory and Disk I/O.
Message-ID: <20041129222323.GE19892@kroah.com>
References: <E1CYqaE-00058c-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CYqaE-00058c-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 10:49:09AM -0800, Gerrit Huizenga wrote:
> +#define TC_DEBUG(fmt, args...) do { \
> +/* printk("%s: " fmt, __FUNCTION__ , ## args); */ } while (0)

Again with the new debug macro :(

> +static struct ckrm_task_class taskclass_dflt_class = {
> +};

Empty structure?  Why?

> +// Hubertus .. following functions should move to ckrm_rc.h

Why haven't they moved :)

> +static inline void ckrm_task_lock(struct task_struct *tsk)
> +{
> +	spin_lock(&tsk->ckrm_tsklock);
> +}

Just lock (or unlock) the lock, don't wrap a lock in a function.

> +DECLARE_MUTEX(async_serializer);	// serialize all async functions

Should this really be global?  The code says otherwise :)

> +	printk("...... Initializing ClassType<%s> ........\n",
> +	       CT_taskclass.name);

What a pretty log message.  Unfortunately it's wrong (me hears the
growing mumblings of the kernel janitor mob...)

> +#if 0
> +
> +/******************************************************************************
> + * Debugging Task Classes:  Utility functions
> + ******************************************************************************/

Then remove the code, if it's not needed.

> +EXPORT_SYMBOL(tcp_v4_lookup_listener);

Not EXPORT_SYMBOL_GPL()?

thanks,

greg k-h
