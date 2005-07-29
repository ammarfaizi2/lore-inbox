Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVG2ESv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVG2ESv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 00:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVG2ESv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 00:18:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7151 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262251AbVG2ESu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 00:18:50 -0400
Message-ID: <42E9ADB8.1010501@mvista.com>
Date: Thu, 28 Jul 2005 21:16:56 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NMI watch dog notify patch
References: <4162.1122601822@kao2.melbourne.sgi.com>
In-Reply-To: <4162.1122601822@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Thu, 28 Jul 2005 13:31:58 -0700, 
> George Anzinger <george@mvista.com> wrote:
> 
>>I have been doing some work on kgdb to pull a few of it "fingers" out of 
>>various places in the kernel.  This is the final location where we have 
>>a kgdb intercept not covered by a notify.
> 
> 
> I like the idea, but the hook should be in die_nmi(), not in the
> watchdog, using the reason that is already passed into die_nmi.
> die_nmi() is also called for a real NMI.
> 
I had though that too, but it does not allow recovery (i.e. lets reset 
the watchdog and try again).

Hmm.. just looked at traps.c.  Seems die_nmi is NOT called from the nmi 
trap, only from the watchdog.  Also, there is a notify in the path to 
the other nmi stuff.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
