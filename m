Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTEAEuQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 00:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbTEAEuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 00:50:16 -0400
Received: from dp.samba.org ([66.70.73.150]:31379 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262328AbTEAEuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 00:50:13 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Loading a module multtiple times 
In-reply-to: Your message of "Wed, 30 Apr 2003 14:05:57 MST."
             <20030430140557.12e13f1a.rddunlap@osdl.org> 
Date: Thu, 01 May 2003 12:12:12 +1000
Message-Id: <20030501050235.045232C051@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030430140557.12e13f1a.rddunlap@osdl.org> you write:
> 
> Hi Rusty-
> 
> I was looking into a bug in /proc/net/dev truncated output.
> /proc/net/dev lists {if (!buggy)} all loaded network interfaces.
> 
> To get a large number of network interfaces, Christian (below)
> told me to copy driver/net/dummy.o to several different file names
> and then insmod them.  It seems to have worked for him, and it works
> that way in 2.4.recent, but it's not working for me.  See error
> messages below.
> 
> Which way is expected behavior?
> What should be the expected behavior?
> or am I just seeing bugs (failures) that noone else sees?

No, it's a 2.5 thing: modules know their own name.  This is because
(1) the names are used to set new-style boot parameters, (2) needing
to insert two modules is usually wrong, since how would that work if
the module was built-in?

It also opens us up to the possibility of a list of built-in modules,
if we wanted to.

However, the -o option to modprobe replaces the module name (by
hacking the elf object, yes), because programmers are basically lazy,
and multiple modules are useful for testing.

So, you want:
	for i in `seq 1 100`; do modprobe -o dummy$i dummy; done

This works on 2.4 as well.  Note that insmod doesn't support -o, being
a trivial program by design.

> It seems like not supporting this is likely to cause some problems.

Yes.  Removing any feature causes problems 8(.  But adding every
feature is usually worse.

Hope this clarifies?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
