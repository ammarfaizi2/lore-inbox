Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTKIR2h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 12:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbTKIR2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 12:28:37 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:56452 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262709AbTKIR2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 12:28:36 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 9 Nov 2003 09:27:47 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Con Kolivas <kernel@kolivas.org>, Nick Piggin <piggin@cyberone.com.au>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Fix find busiest queue 2.6.0-test9
In-Reply-To: <124780000.1068396507@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0311090921090.12198-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Nov 2003, Martin J. Bligh wrote:

> +/* 
> + * macro to make the code more readable - this_rq->prev_cpu_load[i]
> + * is our local cached value of i's prev cpu_load. However, putting
> + * this_rq->prev_cpu_load into the code makes it read like it's the
> + * prev_cpu_load of this_cpu, which makes it confusing to read
> + */
> +#define prev_cpu_load_cache(cpu) (this_rq->prev_cpu_load[cpu])

Ouch, the implicit "this_rq" is really evil ;) Eventually:

#define prev_cpu_load_cache(rq, cpu) (rq->prev_cpu_load[cpu])



- Davide



