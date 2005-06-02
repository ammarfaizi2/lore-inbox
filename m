Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVFBI1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVFBI1i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 04:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVFBI0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 04:26:08 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:35766 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261238AbVFBIZr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 04:25:47 -0400
Date: Thu, 2 Jun 2005 10:25:03 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com, rostedt@goodmis.org,
       inaky.perez-gonzalez@intel.com
Subject: Re: [PATCH] Abstracted Priority Inheritance for RT
In-Reply-To: <1117670317.7646.11.camel@dhcp153.mvista.com>
Message-Id: <Pine.OSF.4.05.10506021015200.28619-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Daniel Walker wrote:

> On Wed, 2005-06-01 at 16:07 +0200, Esben Nielsen wrote:
> 
> > 
> > Do you plan to use that callback for priority inheritance?
> > If so: It would lead to an recursive algorithm. That is not very nice in
> > the kernel with a limited call-stack. It is not so much a problem if the
> > mechanism is used in the kernel only, but if it is used for user-space
> > locking, which can have unlimited neesting, it is potential problem.
> 
> There is an API for for priority inheritance, the call by is strictly
> for the PI mechanism to signal when it changes a waiters priority , as
> the result of PI.
> 
> It's somewhat explained in linux/pi.h . Currently the rt_mutex uses this
> callback to move the waiter depending on it's new priority.
> 
> I'm not sure I see how this could become recursive, could you explain
> more?

Let us say you have task1 waiting on task2 waiting on task3 waiting on
task4 etc. When you try to boost the prorities you will set the priority
of each task using the hook, right? In the hook you will set the priority
of the next task using the hook, right? ....

Esben

> 
> Daniel 


