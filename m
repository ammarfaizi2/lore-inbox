Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUG0HZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUG0HZm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 03:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUG0HZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 03:25:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:12440 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263626AbUG0HZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 03:25:40 -0400
Date: Tue, 27 Jul 2004 00:24:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Limit number of concurrent hotplug processes
Message-Id: <20040727002409.68d49d7c.akpm@osdl.org>
In-Reply-To: <4105FE68.7040506@suse.de>
References: <40FD23A8.6090409@suse.de>
	<20040725182006.6c6a36df.akpm@osdl.org>
	<4104E421.8080700@suse.de>
	<20040726131807.47816576.akpm@osdl.org>
	<4105FE68.7040506@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes Reinecke <hare@suse.de> wrote:
>
>  The problem (from my point of view) with semaphores is that we don't 
>  have an direct counter of the number of processes waiting on that 
>  semaphore to become free. We do have a counter for the number of 
>  processes which are allowed to use the semaphore concurrently (namely 
>  ->count), but the number of waiting processes must be gathered 
>  indirectly by the number of entries in the waitqueue.

Well one could add the number of sleepers to the semaphore, or write some
function which counts the number of entries on the waitqueue or something. 
But the result of this query would be out-of-date as soon as the caller
obtained it and massaging all architectures would be needed.

I don't see why the "number of waiters" needs to be known for this problem.

>  Given enough processes in the waitqueue, the number of currently running 
>  processes effectively determines the number of processes to be started.
>  And as those processes are already running, I don't see an effective 
>  procedure how we could _reduce_ the number of processes to be started.

By reducing the number of processes which can concurrently take the
semaphore?  Confused.

