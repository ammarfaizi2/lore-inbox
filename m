Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966280AbWKTRnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966280AbWKTRnE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966281AbWKTRnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:43:04 -0500
Received: from static.88-198-202-190.clients.your-server.de ([88.198.202.190]:27070
	"EHLO kleinhenz.com") by vger.kernel.org with ESMTP id S966280AbWKTRnB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:43:01 -0500
Message-ID: <4561E923.3080305@hogyros.de>
Date: Mon, 20 Nov 2006 18:42:59 +0100
From: Simon Richter <Simon.Richter@hogyros.de>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Mark Rustad <mrustad@mac.com>
Cc: Linux-Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: implement daemon() in the kernel
References: <4561ABB4.6090700@hogyros.de> <33832325-EF32-4C6D-B566-8B7CE179FF1C@mac.com>
In-Reply-To: <33832325-EF32-4C6D-B566-8B7CE179FF1C@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mark Rustad schrieb:

> There is a better way. Simply implement fork(). It can be done even 
> without an MMU. People think it is impossible, but that is only because 
> they don't consider the possibility of copying memory back and forth on 
> task switch. It sounds horrible, but in the vast majority of cases, 
> either the parent or child either exits or does an exec pretty quickly, 
> so in reality it doesn't cost much. The benefits are many: being able to 
> use real shells such as bash and thereby being able to use real shell 
> scripts.

This imposes quite a significant overhead for the common case (in which 
the application has specifically requested that the parent process be 
terminated after the child process is fork()ed off). Even if the cost of 
transferring memory contents was cheap (which it isn't), you'd annoy the 
memory management subsystem unless you did a lot of weird tricks to 
avoid allocating from a large block.

> You do have to look out for any applications that fork and do not either 
> exit or exec, but that is so much better than having to modify so many 
> things just to get them to run.

Well, in fact just having a libc that does not define a symbol for 
"fork" and then going to the places the linker mentions as having 
undefined references is a pretty easy way. Mind you, in 90% of cases you 
can replace them by a vfork() and be done.

    Simon
