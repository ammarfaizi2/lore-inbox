Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262805AbSJRCud>; Thu, 17 Oct 2002 22:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262815AbSJRCud>; Thu, 17 Oct 2002 22:50:33 -0400
Received: from dp.samba.org ([66.70.73.150]:41606 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262805AbSJRCuc>;
	Thu, 17 Oct 2002 22:50:32 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module loader preparation 
In-reply-to: Your message of "Thu, 17 Oct 2002 11:02:14 EST."
             <Pine.LNX.4.44.0210171057210.6301-100000@chaos.physics.uiowa.edu> 
Date: Fri, 18 Oct 2002 12:55:36 +1000
Message-Id: <20021018025632.009BE2C0BB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0210171057210.6301-100000@chaos.physics.uiowa.edu> yo
u write:
> Converting things to module_init() is certainly a good thing, but having 
> to provide fake init functions for modules which don't need them doesn't 
> look so nice.

Since there are only a couple, I didn't get exotic.

> Did you consider just generating the info you need unconditionally in 
> include/linux/module.h and then removing duplicates for multi-part modules 
> using ld's link-once (I didn't try that yet, but it seems doable and would 
> also remove duplicated .modinfo.kernel_version strings and the like)

Didn't think of it, to be honest, and I can't find any reference to
link-once glancing through the ld info page.

You'll still have problems with objects linked into two modules
(ip_conntrack_core being the typical one), but we could ban these and
just #include the .c file rather than linking.

Really, the number of modules which do this is so small, the code to
add init function to them is less than the change in the build system
to get tricky.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
