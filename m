Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265169AbUAGHZh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 02:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265193AbUAGHZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 02:25:36 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:58762 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265169AbUAGHZf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 02:25:35 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 6 Jan 2004 23:25:33 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: mingo@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-Reply-To: <20040107070617.33CE92C107@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0401062314070.1030-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jan 2004, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0401042243510.16042-100000@bigblue.dev.mdolabs.com> you write:
> > On Mon, 5 Jan 2004, Rusty Russell wrote:
> > > Nope.  That's EXACTLY the kind of burden on the caller I wanted to
> > > avoid if at all possible.
> > 
> > Which burden? The kthread is a resource and a "struct kthread" is an 
> > handle to the resource. You create the resource (kthread_create()), you 
> > control the resource (kthread_start()) and you free the resource 
> > (kthread_stop()). To me it's simple and clean and does not require hacks 
> > like taking owerships of tasks and using SIGCLD/waitpid to communicate. 
> > Anyway, that's your baby and you'll take your choice.
> 
> Thinking more about this issue lead me to rewrite the code to be
> simpler to use.  Main benefit is that the transition from existing
> code is minimal.
> 
> Latest version of patch, and code which uses it.  It's actually quite
> neat now.  Changes since first version:
> 
> 1) kthread_start() deleted in favor of wake_up_process() directly.
> 2) New kthread_bind() for just-created threads, to replace original
>    migration thread open-coded version.
> 3) Slight simplification: thread named only if spawned OK.

Yes, I like this better. Without any doubt, the removal of sync'd start 
function simplified things a lot.



- Davide




