Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264466AbTIIVTZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTIIVTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:19:25 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:48775 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264466AbTIIVSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:18:51 -0400
Subject: Re: Efficient IPC mechanism on Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <00f201c376f8$231d5e00$beae7450@wssupremo>
References: <00f201c376f8$231d5e00$beae7450@wssupremo>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063142262.30981.17.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Tue, 09 Sep 2003 22:17:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-09 at 18:30, Luca Veraldi wrote:
> Hi all.
> At the web page
> http://web.tiscali.it/lucavera/www/root/ecbm/index.htm
> You can find the results of my attempt in modifing the linux kernel sources
> to implement a new Inter Process Communication mechanism.
> 
> It is called ECBM for Efficient Capability-Based Messaging.
> 
> In the reading You can also find the comparison of ECBM 
> against some other commonly-used Linux IPC primitives 
> (such as read/write on pipes or SYS V tools).

The text is a little hard to follow for an English speaker. I can follow
a fair bit and there are a few things I'd take issue with (forgive me if
I'm misunderstanding your material)


1. Almost all IPC is < 512 bytes long. There are exceptions including
X11 image passing which is an important performance one

2. One of the constraints that a message system has is that if it uses
shared memory it must protect the memory queues from abuse. For example
if previous/next pointers are kept in the shared memory one app may be
able to trick another into modifying the wrong thing. Sometimes this
matters.

3. An interesting question exists as to how whether you can create the
same effect with current 2.6 kernel primitives. We have posix shared
memory objects, we have read only mappings and we have extremely fast
task switch and also locks (futex locks)

Also from the benching point of view it is always instructive to run a
set of benchmarks that involve the sender writing all the data bytes,
sending it and the receiver reading them all. Without this zero copy
mechanisms (especially mmu based ones) look artificially good. 


