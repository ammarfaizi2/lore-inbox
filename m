Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTKLPgA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 10:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTKLPf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 10:35:59 -0500
Received: from web40905.mail.yahoo.com ([66.218.78.202]:54946 "HELO
	web40905.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262116AbTKLPf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 10:35:58 -0500
Message-ID: <20031112153556.96591.qmail@web40905.mail.yahoo.com>
Date: Wed, 12 Nov 2003 07:35:56 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Fwd: Re: Badness in atomic_dec_and_test in 2.6.0-test9-mm2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Morton,

--- Mike Anderson <andmike@us.ibm.com> wrote:
> 
> Greg posted a response the other day to a query from Alan Stern. Here is
> the link 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106835250124362&w=2
> 
> This should be the same problem that you are hitting.
> 
> A patch was checked into Linus's tree on 2003-11-07 by Greg that made a
> couple line change to class.c.
> 
> Here is the patch in case you need to stay on mm2.
> 
> -andmike
> --
> Michael Anderson
> andmike@us.ibm.com
> 
> --- 1.41/drivers/base/class.c	Fri Aug 29 14:18:26 2003
> +++ 1.42/drivers/base/class.c	Fri Nov  7 06:48:28 2003
> @@ -255,6 +255,7 @@
>  
>  void class_device_initialize(struct class_device *class_dev)
>  {
> +	kobj_set_kset_s(class_dev, class_obj_subsys);
>  	kobject_init(&class_dev->kobj);
>  	INIT_LIST_HEAD(&class_dev->node);
>  }
> @@ -277,7 +278,6 @@
>  
>  	/* first, register with generic layer. */
>  	kobject_set_name(&class_dev->kobj, class_dev->class_id);
> -	kobj_set_kset_s(class_dev, class_obj_subsys);
>  	if (parent)
>  		class_dev->kobj.parent = &parent->subsys.kset.kobj;
> 

This patch fixes the badness-on-unplug error that I reported to linux-kernel.

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
