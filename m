Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbUCJFfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 00:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbUCJFf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 00:35:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:24550 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262254AbUCJFfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 00:35:21 -0500
Date: Tue, 9 Mar 2004 21:35:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: blk_congestion_wait racy?
Message-Id: <20040309213518.44adb33d.akpm@osdl.org>
In-Reply-To: <404EA645.8010900@cyberone.com.au>
References: <OFAAC6B1AC.5886C5F2-ONC1256E52.0061A30B-C1256E52.0062656E@de.ibm.com>
	<404EA645.8010900@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> But I'm guessing that you have no requests in flight by the time
>  blk_congestion_wait gets called, so nothing ever gets kicked.

That's why blk_congestion_wait() in -mm propagates the schedule_timeout()
return value.   You can do:

	if (blk_congestion_wait(...))
		printk("ouch\n");

If your kernel says ouch much, we have a problem.
