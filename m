Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbUJYEpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbUJYEpb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 00:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUJYEpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 00:45:31 -0400
Received: from ozlabs.org ([203.10.76.45]:13700 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261360AbUJYEpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 00:45:25 -0400
Subject: Re: [RFC/PATCH] Per-device parameter support (4/16)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tejun Heo <tj@home-tj.org>
Cc: mochel@osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041023042550.GE3456@home-tj.org>
References: <20041023042550.GE3456@home-tj.org>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 14:45:20 +1000
Message-Id: <1098679520.8098.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 13:25 +0900, Tejun Heo wrote:
>  dp_04_module_param_ranged.diff
> 
>  This is the 4th patch of 16 patches for devparam.
> 
>  This patch implements module_param_flag() and module_param_invflag().
> They appear as boolean parameter to the outside, and bitwise OR the
> specified flag to flags when the specified boolean value is 1 and 0
> respectively.

Comment is wrong, of course: this patch adds range to the kernel_param
structure.  But I'm not convinced that it's a great idea.  It could be
added using the same method (kp->arg) used to extend the others instead.

(Same logic applied to spinlocking param variants).

It comes down to usage: currently there are few range-needing users, but
maybe that's because MODULE_PARM didn't support it.  So I would drop
this or implement it as a wrapper, and later we can add it when it takes
over the world.  Although I'd probably just add args to
module_param_call: I like having it as the "base".

The other thing is the min=1 max=0 case: I'd prefer INT_MAX, INT_MIN
etc. instead I think so there's no special cases.

Thanks!
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

