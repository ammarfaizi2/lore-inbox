Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVEIUKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVEIUKA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 16:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVEIUJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 16:09:33 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:45554 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261503AbVEIUJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 16:09:21 -0400
Message-ID: <427FC366.1000506@nortel.com>
Date: Mon, 09 May 2005 14:09:10 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org, Jim Nance <jlnance@sdf.lonestar.org>,
       Dave Jones <davej@redhat.com>, Willy Tarreau <willy@w.ods.org>,
       Andrew Morton <akpm@osdl.org>, Ricky Beam <jfbeam@bluetronic.net>,
       nico-kernel@schottelius.org
Subject: Re: /proc/cpuinfo format - arch dependent!
References: <20050507172005.GB26088@redhat.com><20050507172005.GB26088@redhat.com> <20050508012521.GA24268@SDF.LONESTAR.ORG> <427FA876.7000401@tmr.com>
In-Reply-To: <427FA876.7000401@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> Might I suggest that if you like the "we know best just trust us" 
> approach, there is another OS to use. Making information available to 
> good applications will improve system performance, or at least allow 
> better limitation of requests for resources

What will you do with the information?  The kernel is doing all the 
resource allocation and scheduling.

 From a higher-level, the application wants the best performance. 
Doesn't it make more sense to have an API that lets you query things 
like: how many cores do I have, how many separate memory interfaces do I 
have, how many cores handle interrupts, etc.

Based on that information you tell the system: "I've got 4 processes, 
please put them all on cores with separate memory connectivity since 
they're all memory-intensive. Now please put these other two threads on 
the same cpu since they share memory but serialize each other by design."

The app shouldn't care about the details of architecture, but it should 
be able to work with the system to give the best performance.

Chris
