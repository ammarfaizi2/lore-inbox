Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTIHPKx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbTIHPKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:10:53 -0400
Received: from brazilnut.cc.columbia.edu ([128.59.59.203]:28563 "EHLO
	brazilnut.cc.columbia.edu") by vger.kernel.org with ESMTP
	id S262465AbTIHPKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:10:51 -0400
Message-ID: <3F5C9BD7.7000407@cs.columbia.edu>
Date: Mon, 08 Sep 2003 11:10:15 -0400
From: Haoqiang Zheng <hzheng@cs.columbia.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Pavel Machek <pavel@ucw.cz>, Nick Piggin <piggin@cyberone.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Mike Galbraith <efault@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] new scheduler policy
References: <3F4182FD.3040900@cyberone.com.au>	 <5.2.1.1.2.20030819113225.019dae48@pop.gmx.net>	 <20030820021351.GE4306@holomorphy.com> <3F4A1386.9090505@cs.columbia.edu>	 <3F4A172F.8080303@cyberone.com.au> <3F4A272F.8000602@cs.columbia.edu>	 <20030902142552.GG1358@openzaurus.ucw.cz>	 <1063028436.21084.30.camel@dhcp23.swansea.linux.org.uk>	 <3F5C9010.1080607@cs.columbia.edu> <1063031334.21050.44.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1063031334.21050.44.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-No-Spam-Score: Local
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>You have to know the dependancies for the entire system, its nearly
>impossible to do. Once you have the apps also waiting for each other and
>for direct communications (eg via a database or a shared service) life
>gets fun. 
>  
>
If we assume the priority of a remote process is the same as its local 
priority (local p->prio), I think something can still be done.
Let's make up an example first.  Assume we have two machines A and B. P1 
runs at machine A while P2,P3 run at machine B.  P2 is the database 
server.  In this case, I think the priority inversion problem can be 
solved iff:
1. P2 (the database server) handles requests according to the clients 
priority.
2. P2  inherits the priority of its current client (client with the 
highest priority).

>For local apps one thing that has been suggested and some microkernels
>have played with is a syscall that basically is "send this message and
>donate the rest of my timeslice to.."
>
>  
>
In the additional syscall based approach, the applications have to be 
re-written and the application developers have to know exactly where the 
timeslice should be denoted to. This is not usually feasible.  On the 
other hand, everything is done automatically and transparently in the 
approach I suggested.

