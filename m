Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVD0PfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVD0PfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 11:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVD0PfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 11:35:17 -0400
Received: from vena.lwn.net ([206.168.112.25]:56977 "HELO lwn.net")
	by vger.kernel.org with SMTP id S261784AbVD0PfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 11:35:00 -0400
Message-ID: <20050427153458.20748.qmail@lwn.net>
To: k8 s <uint32@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Doubt Regarding Multithreading and Device Driver 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Wed, 27 Apr 2005 20:35:28 +0530."
             <699a19ea050427080545fb1676@mail.gmail.com> 
Date: Wed, 27 Apr 2005 09:34:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am storing something into struct file*filp->private_data.
> As this is not shared across processes I am not doing any locking
> stuff while accessing or putting anything into it.
> 
> Will There be a race condition in a multithreaded program in the ioctl
> call on smp kernel accessing filp->private_data.

If you are only accessing ->private_date in an ioctl() method, you have
lucked out: straight ioctl() remains protected by the big kernel lock,
and you will not have concurrent accesses.

That said, it's not that hard for you to add the proper locking yourself
and have code which will be robust in the future.  Why not do it right?
There's lots of information in LDD3 (http://lwn.net/Kernel/LDD3/) and
elsewhere on how to do that.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net

