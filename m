Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUATIWl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 03:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbUATIWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 03:22:40 -0500
Received: from dp.samba.org ([66.70.73.150]:12204 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265230AbUATIWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 03:22:37 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tim Hockin <thockin@hockin.org>
Cc: vatsa@in.ibm.com, lhcs-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR 
In-reply-to: Your message of "Mon, 19 Jan 2004 22:33:16 -0800."
             <20040120063316.GA9736@hockin.org> 
Date: Tue, 20 Jan 2004 18:45:41 +1100
Message-Id: <20040120082232.ED1282C2ED@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040120063316.GA9736@hockin.org> you write:
> I added a new TASK_UNRUNNABLE state for these tasks, too.  By adding the
> task's current (or most recent) CPU and the task's cpus_allowed and
> cpus_allowed_mask to /proc/pid/status, we gave simple tools for finding
> these unrunnable tasks.
> 
> I think the sanest thing for a CPU removal is to migrate everything off the
> processor in question, move unrunnable tasks into TASK_UNRUNNABLE state,
> then notify /sbin/hotplug.  The hotplug script can then find and handle the
> unrunnable tasks.  No SIGPWR grossness needed.

Interesting.

The downside is that you now need some script needs to know what to do
with the tasks (unless you have something like DBUS, but that's a ways
off).  There are no correctness concerns AFAICT with userspace not
being on a particular CPU, just performance.

The SIGPWR solution lets a random process deal appropriately without
having to interface with /sbin/hotplug, if it wants to.  And it's a
lot less invasive.

I'll take a look though.
Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
