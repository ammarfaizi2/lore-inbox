Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbUL0Ni5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbUL0Ni5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 08:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbUL0Ni4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 08:38:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57254 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261180AbUL0Niy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 08:38:54 -0500
Date: Mon, 27 Dec 2004 08:38:41 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: VM fixes [4/4]
In-Reply-To: <20041224174156.GE13747@dualathlon.random>
Message-ID: <Pine.LNX.4.61.0412270837001.19240@chimarrao.boston.redhat.com>
References: <20041224174156.GE13747@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2004, Andrea Arcangeli wrote:

> --- x/mm/oom_kill.c.orig	2004-12-24 17:53:50.807536152 +0100
> +++ x/mm/oom_kill.c	2004-12-24 18:01:19.903263224 +0100
> @@ -45,18 +45,30 @@
> unsigned long badness(struct task_struct *p, unsigned long uptime)
> {

> 	/*
> +	 * Processes which fork a lot of child processes are likely
> +	 * a good choice. We add the vmsize of the childs if they
> +	 * have an own mm. This prevents forking servers to flood the
> +	 * machine with an endless amount of childs
> +	 */

I'm not sure about this one.  You'll end up killing the
parent httpd and sshd, instead of letting them hang around
so the system can recover by itself after the memory use
spike is over.

I guess it all depends on whether your OOM situation is a
spike or a deliberately caused problem...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
