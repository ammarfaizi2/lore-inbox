Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbUAHBcL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 20:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUAHBcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 20:32:11 -0500
Received: from dp.samba.org ([66.70.73.150]:3224 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262765AbUAHBcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 20:32:09 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: mingo@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-reply-to: Your message of "Tue, 06 Jan 2004 23:25:33 -0800."
             <Pine.LNX.4.44.0401062314070.1030-100000@bigblue.dev.mdolabs.com> 
Date: Thu, 08 Jan 2004 11:33:43 +1100
Message-Id: <20040108013206.E76AE2C09A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0401062314070.1030-100000@bigblue.dev.mdolabs.com> you write:
> On Wed, 7 Jan 2004, Rusty Russell wrote:
> 
> > Latest version of patch, and code which uses it.  It's actually quite
> > neat now.  Changes since first version:
> 
> Yes, I like this better. Without any doubt, the removal of sync'd start 
> function simplified things a lot.

Yeah, I thought you would: makes our previous debates moot so we can
be friends again 8)

The reason I did the startfn thing originally is for the hotplug CPU
code: I wanted to make sure the thread gets onto the CPU while we're
in the notifier, so it doesn't go down again before the thread does
set_cpus_allowed().  Not a problem in practice, but it's nice to have
the BUG_ON(smp_processor_id() != cpu) in the code.

kthread_bind() solves this neatly, and we need it for migration_thread
anyway (which is the one thread where being on the right CPU effects
correctness, not just performance).

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
