Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVC2KIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVC2KIO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVC2KIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:08:14 -0500
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:54214 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S262314AbVC2KIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:08:01 -0500
Date: Tue, 29 Mar 2005 12:07:52 +0200 (MEST)
From: Bert Wesarg <wesarg@informatik.uni-halle.de>
Subject: Re: [PATCH] kernel/param.c: don't use .max when .num is NULL in
 param_array_set()
In-reply-to: <1112076353.21459.34.camel@localhost.localdomain>
X-X-Sender: wesarg@turing
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <Pine.GSO.4.56.0503291206050.5367@turing>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.GSO.4.56.0503271455190.25037@turing>
 <1112076353.21459.34.camel@localhost.localdomain>
X-Scan-Signature: b201ac420b9ec321412dc753cd35eaf2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Mar 2005, Rusty Russell wrote:

> On Sun, 2005-03-27 at 14:57 +0200, Bert Wesarg wrote:
> > Hello,
> >
> > there seems to be a bug, at least for me, in kernel/param.c for arrays
> > with .num == NULL. If .num == NULL, the function param_array_set() uses
> > &.max for the call to param_array(), wich alters the .max value to the
> > number of arguments. The result is, you can't set more array arguments as
> > the last time you set the parameter.
>
> Yes.  But this ignores the larger problem, in that the printing routines
> need *some* way of telling how many to print.  We could add a new
> element for this case, at the price of enlarging the structure a little
> for every array parameter.  I think you'll find that with your patch,
> the code does this:
>
> 	$ insmod example.ko array=1,2,3
> 	$ cat /sys/module/example/parameters/array
> 	1,2,3,0,0,0,0,0,0,0

Yes, but in this case you can/will past a num pointer to
module_param_array(), when it is important to know how many arguments are
specified.

greetings,
bert

>
> Cheers,
> Rusty.
> --
> A bad analogy is like a leaky screwdriver -- Richard Braakman
>
