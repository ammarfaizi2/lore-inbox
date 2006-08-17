Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWHQIg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWHQIg6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 04:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWHQIg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 04:36:58 -0400
Received: from news.cistron.nl ([62.216.30.38]:31165 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S932457AbWHQIg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 04:36:56 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Strange write starvation on 2.6.17 (and other) kernels
Date: Thu, 17 Aug 2006 08:36:55 +0000 (UTC)
Organization: Cistron
Message-ID: <ec19r7$uba$1@news.cistron.nl>
References: <44E0A69C.5030103@agh.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1155803815 31082 194.109.0.112 (17 Aug 2006 08:36:55 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@n2o.xs4all.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <44E0A69C.5030103@agh.edu.pl>,
Andrzej Szymanski  <szymans@agh.edu.pl> wrote:
>I've encountered a strange problem - if an application is sequentially 
>writing a large file on a busy machine, a single write() of 64KB may 
>take even 30 seconds. But if I do fsync() after each write() the maximum 
>time of write()+fsync() is about 0.5 second (the overall performance is, 
>of course, degraded).

I'm seeing something similar.

I upgraded one of our newsrouters from 2.6.14.2 to 2.6.17.8 because
I needed ethernet bonding with vlan support.

It performs quite a bit worse now that before. The nightly report
that the INN software writes, tells me that the average write()
time (of the single threaded innd process to news storage) went
up from min/avg/max  0.942/1.716/2.337 ms to min/avg/max
2.952/4.553/5.658 ms.

The innd process writes to a simple filesystem I wrote myself that
shows a blockdevice as a single large file. It's a bit more efficient
than using the blockdevice directly.

So I don't see large write delays, but the average write() time
has gone up significantly (bad in my case, since it starves the
innd process).

Since I've also had several unexplained hangs I'm going back
to 2.6.14.x for now, since this machine is too important .. as
soon as I've got some more redundancy I'll experiment some more.

Mike.

