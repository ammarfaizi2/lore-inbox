Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313484AbSC2R1k>; Fri, 29 Mar 2002 12:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313485AbSC2R13>; Fri, 29 Mar 2002 12:27:29 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:43575 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313484AbSC2R10>; Fri, 29 Mar 2002 12:27:26 -0500
Date: Fri, 29 Mar 2002 12:27:18 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200203291727.g2THRIM01125@devserv.devel.redhat.com>
To: Amol Kumar Lad <amolk@ishoni.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel notification to user space task
In-Reply-To: <mailman.1017422340.6661.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I want my driver running in kernel to send a notification to this task when
> it detects some event.
> 
> for example..if my driver detects that interface 'eth0' is coming up, it
> should send a indication to user task saying 'network interface eth0 is up'

I think it's kind of FAQ. Have a thread waiting in your driver
with add_wait_queue and schedule(). When awoken, the even thread
can signal the main worker thread or do the job itself.

But first, make sure you are not served better with an
event driven main thread (e.g. open a file descriptor
into your driver, then use select() on it together with
all other of your descriptors).

-- Pete
