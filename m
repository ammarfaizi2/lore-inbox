Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbTJPL3W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 07:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbTJPL3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 07:29:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4743 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262854AbTJPL3V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 07:29:21 -0400
Message-ID: <3F8E8101.70009@pobox.com>
Date: Thu, 16 Oct 2003 07:29:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eli Billauer <eli_billauer@users.sf.net>
CC: linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [RFC] frandom - fast random generator module
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net>
In-Reply-To: <3F8E70E0.7070000@users.sf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Billauer wrote:
> I suppose you're asking why having a /dev/frandom device at all. Why not 
> let everyone write their own little random generator (based upon 
> well-known C functions) whenever random data is needed.
> 
> There are plenty of handy things in the kernel, that could be done in 
> userspace. /dev/zero is my favourite example, but I'm sure there are 
> other cases where things were put in the kernel simply because people 
> found them handy. Which is a good reason, if you ask me.
> 
> Besides, it's quite easy to do something wrong with random numbers. By 
> having a good source of random data, I suppose we can spare a lot of 
> people the headache of getting their own user-space application right 
> for the one-off thing they want to do.

This is completely bogus logic.  I can use this (incorrect) argument to 
similar push for applications doing bsearch(3) or qsort(3) via a system 
call.

When the _implementation_ requires that a piece of code be in-kernel 
(for performance or security, usually), it is.

In this case, there is no such requirement.  More below.


> But it's really a matter of taste. That's why I bring up the subject here.


Processors are trending towards putting RNG on the CPU.  VIA won't be 
the last, I predict.  When generating random bits is a single 
instruction, "xstore", userspace applications _should_ be directly using 
this.  It should not be in-kernel.  And similarly, if there is no 
requirement that the kernel's entropy pool is used, the userspace 
application _should_ be where the implementation lives.

So, given that trend and also given the existing /dev/[u]random, I 
disagree completely:  /dev/frandom is the perfect example of something 
that should _not_ be in the kernel.  If you want /dev/urandom faster, 
then solve _that_ problem.  Don't try to solve a /dev/urandom problem by 
creating something totally new.

	Jeff


