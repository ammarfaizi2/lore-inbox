Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbUAVD31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 22:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUAVD31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 22:29:27 -0500
Received: from dp.samba.org ([66.70.73.150]:7148 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264366AbUAVD3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 22:29:25 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, vojtech@suse.cz
Subject: Re: mouse configuration in 2.6.1 
In-reply-to: Your message of "Wed, 21 Jan 2004 13:23:37 BST."
             <20040121132337.7f8d3c79.ak@suse.de> 
Date: Thu, 22 Jan 2004 12:14:55 +1100
Message-Id: <20040122032941.174152C06E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040121132337.7f8d3c79.ak@suse.de> you write:
> Unfortunately we have lots of non neat module names and many previous boot
> time arguments note their subsystem which adds even more redundancy.
> 
> And you're suggesting people to move to module_parm now in the stable
> series leads to renaming of module parameters, which breaks previously
> working configurations in often subtle ways. Maybe that's acceptable
> in a unstable development kernel, but I don't think it is in 2.6.

I think we're getting a little confused here.

I'm saying that people should start using module_param instead of
MODULE_PARM in new code, or code being reworked.  This adds a boot
param where there was none before.

I'm explicitly not advocating replacing __setup() for existing code.

> And 2.6.0 -> 2.6.1 silently changing to that without any
> documentation anywhere, silently breaking my mouse.

That's bad.  I would have left the old __setup under #ifdef
CONFIG_OBSOLETE_MODPARM (or something where it can eventually go
away).  And maybe a printk warning about using the old name.

> Sorry Rusty. You are probably the wrong target for the flame, but a
> combination of probably well intended changes including module_parm
> brought a total usability disaster here.

Perhaps I am the wrong target, but I'm glad you brought it up.

I thought that changing __setup to module_param() would have obvious
effects, and authors would make their own call on that.

FYI: __setup and module_param() *CAN* be freely mixed, unlike
MODULE_PARM and module_param().

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
