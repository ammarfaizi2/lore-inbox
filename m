Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbVAVANC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbVAVANC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbVAVALh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 19:11:37 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:49579 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262622AbVAVAHU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 19:07:20 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 21 Jan 2005 16:07:17 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Brandon Corey <bcorey@engr.sgi.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Pollable Semaphores
In-Reply-To: <20050121212212.GA453910@firefly.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0501211600520.5610@bigblue.dev.mdolabs.com>
References: <20050121212212.GA453910@firefly.engr.sgi.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2005, Brandon Corey wrote:

> I'm trying to find out if there is a pollable semaphore equivalent on Linux.
> 
> The main idea of a "pollable semaphore", is a semaphore with a related
> file descriptor.  The file descriptor can be used to select() when the
> semaphore is acquirable.  This provides a convenient way for users to
> implement code synchronization between threads, where multiple file
> descriptors are already being selected against.
> 
> We have a pollable semaphore implementation on IRIX that provides this
> functionality.  The API consists of a handful of calls for creation and
> destruction of pollable semaphores, as well as a means to attach them
> to a file descriptor.  Beyond that, from the users point of view, they're
> just treated as any other file descriptor.
> 
> These calls are routed through a library and then passed off to a kernel
> driver that handles the events.  If someone selects against a semaphore
> when it's unaquirable, the driver sleeps on a synchronization variable.
> When the semaphore is subsequently made aquirable, the driver will wake up
> any waiters.  Multiple pollable semaphores mixed with other file
> descriptors can be selected against, and a wakeup will occur when any of
> the semaphores become acquirable.
> 
> Is anyone aware of any equivalent functionality?

I used pipe-based semaphores when I need that functionality (call psem_down_fd()
to get the pollable fd):

http://www.xmailserver.org/pipe-sem.c
http://www.xmailserver.org/pipe-sem.h

They have the problem of the maximum pipe buffer size that affects the 
maximum count, but in my case it was fine. Or at least bugs did not come 
biting me at the time ;)



- Davide

