Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbUJYE3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbUJYE3J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 00:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUJYE3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 00:29:09 -0400
Received: from ozlabs.org ([203.10.76.45]:4740 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261364AbUJYE3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 00:29:01 -0400
Subject: Re: [RFC/PATCH] Per-device parameter support (2/16)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tejun Heo <tj@home-tj.org>
Cc: mochel@osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041023042421.GC3456@home-tj.org>
References: <20041023042421.GC3456@home-tj.org>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 14:28:59 +1000
Message-Id: <1098678539.8098.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 13:24 +0900, Tejun Heo wrote:
>  dp_02_param_array_bug.diff
> 
>  This is the 2nd patch of 16 patches for devparam.
> 
>  This patches fixes param_array_set() to not use arr->max as nump
> argument of param_array.  If arr->max is used as nump and the
> configuration variable is exported writeable in the syfs, the size of
> the array will be limited by the smallest number of elements
> specified.  One side effect is that as the actual number of elements
> is not recorded anymore when nump is NULL, all elements should be
> printed when referencing the corresponding sysfs node.  I don't think
> that will cause any problem.

I thought of this, but I prefer to see this fixed by another element in
the struct kernel_param which is used as "num" if nump is NULL.
Although this creates some bloat, it doesn't truncate as mine does, or
allow overflows and printing unset values as yours does.

(Printing unset values is usually OK, since before the new parameter
stuff, there was no way of telling how many elements had been set.  This
lead authors to use a magic value for "unset".  They no longer need to
do this, so we might see them start to rely on that).

Cheers,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

