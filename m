Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVBKTTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVBKTTh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 14:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVBKTQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 14:16:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:1714 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262300AbVBKTLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 14:11:52 -0500
Date: Fri, 11 Feb 2005 11:11:12 -0800
From: Greg KH <greg@kroah.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Jay Lan <jlan@engr.sgi.com>
Subject: Re: [RFC][PATCH 2.6.11-rc3-mm2] Relay Fork Module
Message-ID: <20050211191112.GB19139@kroah.com>
References: <1107786245.9582.27.camel@frecb000711.frec.bull.fr> <20050207154623.33333cda.akpm@osdl.org> <1108109504.30559.43.camel@frecb000711.frec.bull.fr> <20050211005446.081aa075.akpm@osdl.org> <1108134520.14068.66.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108134520.14068.66.camel@frecb000711.frec.bull.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 04:08:40PM +0100, Guillaume Thouvenin wrote:
> +void kobject_fork(struct kobject *kobj, pid_t parent, pid_t child)
> +{
> +#ifdef CONFIG_KOBJECT_UEVENT

No, provide two different functions.  In a header file make it a static
inline function that does nothing if this option is not selected, so as
to make the code just go away, and the call is never made.


> +	char *kobj_path = NULL;
> +	char *action_string = NULL;
> +	char **envp = NULL;
> +	char ppid_string[FORK_BUFFER_SIZE];
> +	char cpid_string[FORK_BUFFER_SIZE];
> +
> +	if (!uevent_sock)
> +		return;
> +	
> +	action_string = action_to_string(KOBJ_FORK);
> +	if (!action_string)
> +		return;
> +	
> +	kobj_path = kobject_get_path(kobj, GFP_KERNEL);
> +	if (!kobj_path)
> +		return;

How is there a path for a kobject that is never registered with sysfs?

I agree with Andrew, why are you using a kobject for this?  Have you
looked at the "connector" code that is in the -mm tree?  That might be a
better solution for this, and it will be going into the kernel tree
after 2.6.11 is released.

> +EXPORT_SYMBOL(kobject_fork);

EXPORT_SYMBOL_GPL() for something like this please.

thanks,

greg k-h
