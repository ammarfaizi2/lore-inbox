Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271194AbTG1XOY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 19:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271191AbTG1XNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 19:13:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:29399 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271163AbTG1XMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 19:12:53 -0400
Date: Mon, 28 Jul 2003 16:01:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org
Subject: Re: as / scheduler question
Message-Id: <20030728160117.3f679f01.akpm@osdl.org>
In-Reply-To: <200307290908.09065.kernel@kolivas.org>
References: <200307290908.09065.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Nick
> 
> With the sheduler work Ingo and I have been doing I was wondering if there was 
> possibly a problem with requeuing kernel threads at certain intervals? Ingo's 
> current version requeues all threads at 25ms and I just wondered if this 
> number might be a multiple or factor of a magic number in the AS workings, as 
> we're seeing a few changes in behaviour with AS only. I'm planning on leaving 
> kernel threads out of this requeuing, but I thought I could also pick your 
> brain.
> 

What does "requeues all threads at 25ms" mean?

The only dependency we should have there is that kblockd should be scheduled
promptly after it is woken.  It is reniced by -10 so it should be OK. 
Renicing it further or making it SCHED_RR/FIFO would be interesting.

