Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbTJMK7F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 06:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTJMK7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 06:59:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:54433 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261667AbTJMK7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 06:59:02 -0400
Date: Mon, 13 Oct 2003 04:02:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Kernel thread signal handling.
Message-Id: <20031013040219.6ad71a57.akpm@osdl.org>
In-Reply-To: <1066041096.24015.431.camel@hades.cambridge.redhat.com>
References: <1066041096.24015.431.camel@hades.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
>  1. We need disallow_signal() to complement allow_signal().
> 
>  2. We need a function which does dequeue_signal() _with_ locking.
> 
>  3. We might need a better name for #2. Change if you care.
> 
>  4. We need allow_signal() to actually allow signals other than
>     SIGKILL. Currently they get either converted to SIGKILL or
>     silently dropped, according to whether your kernel thread
>     happens to have sa_handler set for the signal in question.
> 
>     It would be nicer to fix this in the signal delivery code
>     itself if (!tsk->mm) rather than by faking a handler in
>     allow_signal(). I'm not touching the signal delivery code
>     with a bargepole though. Hopefully the proposed change to
>     allow_signal() will provoke someone else into doing so.

Sigh.  Using signals to communicate with kernel threads is evil.  It keeps
on breaking and each site does it differently and we've had plenty of bugs
due to this practice.

Signals are for userspace and the signal developers shouldn't have to worry
about weird in-kernel abuse and we have other simpler, more reliable
mechanisms available in-kernel and even more such ranting you get the
point.

Is there no way in which jffs2 can be weaned off this obnoxious habit?


