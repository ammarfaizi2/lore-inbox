Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVC2OQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVC2OQy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 09:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVC2OQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 09:16:54 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:43916 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262294AbVC2OQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 09:16:45 -0500
Message-ID: <42496241.5010509@nortel.com>
Date: Tue, 29 Mar 2005 08:12:17 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: akpm@osdl.org, Adrian Bunk <bunk@stusta.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Do not misuse Coverity please (Was: sound/oss/cs46xx.c: fix a
 check after use)
References: <xyDqcv4K.1112093182.7253990.khali@localhost>
In-Reply-To: <xyDqcv4K.1112093182.7253990.khali@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:

> Wow. Great point. I completely missed that possibility. In fact I didn't
> know that the compiler could possibly alter the order of the
> instructions. For one thing, I thought it was simply not allowed to. For
> another, I didn't know that it had been made so aware that it could
> actually figure out how to do this kind of things. What a mess. Let's
> just hope that the gcc folks know their business :)
> 
> I'll try to remember this next time I debug something. Do not assume
> that instructions are run in the order seen in the source. Irk.

It gets better, in that the cpus themselves can reorder instructions. 
This becomes interesting when dealing with memory being shared between 
multiple cpus on SMP machines.  Either you need to use existing locking 
primitives which enforce ordering or else you need to use explicit 
cpu-level ordering instructions to ensure that data gets written/read in 
the expected order.  (See "mb" and friends in the kernel code.)

Then you get into potential caching issues with memory mapped at 
different addresses on cpus with VIVT caches, and that introduces more 
issues.

Computers are perfectly predictable, as long as you understand exactly 
what you've told them to do...

Chris
