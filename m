Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVBRXda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVBRXda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 18:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVBRXda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 18:33:30 -0500
Received: from vena.lwn.net ([206.168.112.25]:16521 "HELO lwn.net")
	by vger.kernel.org with SMTP id S261556AbVBRXdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 18:33:04 -0500
Message-ID: <20050218233303.6336.qmail@lwn.net>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] rwsem removal from kobj_map 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Fri, 18 Feb 2005 13:28:38 PST."
             <20050218212838.GA21989@kroah.com> 
Date: Fri, 18 Feb 2005 16:33:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Since this is something I once looked at too...]

>  struct kobj_map *kobj_map_init(kobj_probe_t *base_probe,
> -		struct subsystem *s)
> +		struct subsystem *s, struct semaphore *sem)

The only reason kobj_map_init() needed the subsystem argument was for
the semaphore.  Since you're passing that separately now, I would think
that the subsystem argument could simply go away altogether.

Once that's done, you should be able to delete cdev_subsys as well; when
I cleaned that stuff up, I only left it there for kobj_map().

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
