Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbVC2Gq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbVC2Gq6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 01:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVC2Gq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 01:46:58 -0500
Received: from ozlabs.org ([203.10.76.45]:20185 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262350AbVC2Gqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 01:46:54 -0500
Subject: Re: [PATCH] kernel/param.c: don't use .max when .num is NULL in
	param_array_set()
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bert Wesarg <wesarg@informatik.uni-halle.de>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.56.0503271455190.25037@turing>
References: <Pine.GSO.4.56.0503271455190.25037@turing>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 16:05:53 +1000
Message-Id: <1112076353.21459.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-27 at 14:57 +0200, Bert Wesarg wrote:
> Hello,
> 
> there seems to be a bug, at least for me, in kernel/param.c for arrays
> with .num == NULL. If .num == NULL, the function param_array_set() uses
> &.max for the call to param_array(), wich alters the .max value to the
> number of arguments. The result is, you can't set more array arguments as
> the last time you set the parameter.

Yes.  But this ignores the larger problem, in that the printing routines
need *some* way of telling how many to print.  We could add a new
element for this case, at the price of enlarging the structure a little
for every array parameter.  I think you'll find that with your patch,
the code does this:

	$ insmod example.ko array=1,2,3
	$ cat /sys/module/example/parameters/array
	1,2,3,0,0,0,0,0,0,0

Cheers,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

