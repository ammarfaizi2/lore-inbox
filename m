Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264485AbTEJTyM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 15:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264487AbTEJTyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 15:54:12 -0400
Received: from corky.net ([212.150.53.130]:45184 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S264485AbTEJTyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 15:54:11 -0400
Date: Sat, 10 May 2003 23:06:41 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: arjanv@redhat.com, <masud@googgun.com>, <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <20030510195320.GG1053@actcom.co.il>
Message-ID: <Pine.LNX.4.44.0305102301160.16611-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This approach, while it would solve this particular problem, has a
> grave flow. Consider the case where the first copy in the
> original_syscall is to copy a user space structure, which has embedded
> user space pointers... The set_fs() will cause future
> copy_from_user/copy_to_user in original_syscall() calls to succeed
> even if the user  supplied pointer is in kernel space.

You're right, which is why I wouldn't offer it as a general mechanism.  I
was merely offering a method to solve the current issue and fix Masud's
problem.  This solution is good in many cases but dangerous in others.  It
can be used as long as you inspect the original syscall to make sure its
param is just a simple string/int.  True in most cases though.

Note that this method is used, often by common LSM modules, for opening
and handling files from kernel space.  (think persistent labeling on a
generic filesystem).

>
> > Removing this symbol will not really get in the way for the bad guys
> > because it'll always be possible to find and intercept it anyway (see my
> > previous post in this thread), but it'll increase the learning curve for
> > kernel newbies.  Do we really want that ?
>
> Hear hear.

;-)

	Yoav Weiss

