Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVGAUid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVGAUid (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVGAUid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:38:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:35292 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262362AbVGAUfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:35:42 -0400
Date: Fri, 1 Jul 2005 13:35:26 -0700
From: Greg KH <greg@kroah.com>
To: serue@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gerrit@us.ibm.com>
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
Message-ID: <20050701203526.GA824@kroah.com>
References: <20050630194458.GA23439@serge.austin.ibm.com> <20050630195043.GE23538@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630195043.GE23538@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 02:50:43PM -0500, serue@us.ibm.com wrote:
> +/* variables to hold kobject/sysfs data */
> +static struct subsystem stacker_subsys;

Use decl_subsys please.

And yes, James is right, only value per sysfs file is allowed.

> +	result = subsystem_register(&stacker_subsys);

Why are you putting this at the root of sysfs.  It should go in
/sys/kernel/security/ right?  Please put it there.

> +	sysfs_create_file(&stacker_subsys.kset.kobj,
> +			&stacker_attr_lockdown.attr);
> +	sysfs_create_file(&stacker_subsys.kset.kobj,
> +			&stacker_attr_listmodules.attr);
> +	sysfs_create_file(&stacker_subsys.kset.kobj,
> +			&stacker_attr_stop_responding.attr);
> +	sysfs_create_file(&stacker_subsys.kset.kobj,
> +			&stacker_attr_unload.attr);

Hm, I think those functions return error values, you might want to check
them...

> +	sysfsfiles_registered = 1;

Why?  You know if this works or not, otherwise you would have failed
here.

> +	printk(KERN_NOTICE "LSM stacker registered as the primary "
> +			   "security module\n");

And everyone really wants to see this in their logs?

> +	if (unregister_security (&stacker_ops))
> +		printk(KERN_WARNING "Error unregistering LSM stacker.\n");
> +	else
> +		printk(KERN_WARNING "LSM stacker removed.\n");

Same here as above...

thanks,

greg k-h
