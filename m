Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbUJYE5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbUJYE5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 00:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUJYE5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 00:57:38 -0400
Received: from ozlabs.org ([203.10.76.45]:22916 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261371AbUJYE5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 00:57:31 -0400
Subject: Re: [RFC/PATCH] Per-device parameter support (11/16)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tejun Heo <tj@home-tj.org>
Cc: mochel@osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041023043040.GL3456@home-tj.org>
References: <20041023043040.GL3456@home-tj.org>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 14:57:29 +1000
Message-Id: <1098680249.8098.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 13:30 +0900, Tejun Heo wrote:
>  dp_11_module_param_arr.diff
> 
>  This is the 11st patch of 16 patches for devparam.
> 
>  The unsigned int * @nump of module_param_array is changed back to
> unsigned int @num, and new sets of macros named module_param_arr*()
> are added.  These new macros don't take the num argument.  This change
> is made for two reasons
> 
>  1. To be consistent with devparam macros.  In devparam, we'll be
>     using field name of struct elements, so we won't be able to use
>     pointer argument.
>  2. It's more consistent with other moduleparam macros.
> 
>  This patch only modifies moduleparam.h and doesn't modify the users
> of the modified macros.  The next patch takes care of that.  This and
> the next patch (dp_12_module_param_arr_apply.diff) are optional.

It's finely balanced, but the module_param macro only skips the "&"
because it turns it into a name.  module_param_named() should probably
be changed to take a ptr too.  But you'll get a warning if you use the
interface wrong, so it's not a huge issue.

The balance is tipped here I think because the massive number of
functions we're starting to sprout into.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

