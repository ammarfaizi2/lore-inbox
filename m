Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266148AbTLaHM1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 02:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbTLaHM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 02:12:27 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:3969 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266148AbTLaHM0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 02:12:26 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 30 Dec 2003 23:12:24 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create
In-Reply-To: <20031231120151.A22673@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0312302255080.1457-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Dec 2003, Srivatsa Vaddagiri wrote:

> On Tue, Dec 30, 2003 at 09:56:05PM -0800, Davide Libenzi wrote:
> > Also, what happens in the task woke up by a send does not reschedule 
> > before another CPU does another send? Wouldn't a message be lost?
> > 
> 
> The messages should not be lost because we take the cpucontrol
> semaphore in kthread_start or kthread_destroy before sending 
> a (start or destroy) message.

I see, ok. At that point though, having the message struct inside the task 
struct could save the *to pointer and (because of the big lock above), using 
barrier and proper order in setting *from and *info, the spin lock. OTOH 
the big lock above really make the global message structure private, so it 
does not make much difference.



- Davide







