Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUDBXOP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 18:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUDBXOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 18:14:15 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:10232 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261296AbUDBXOO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 18:14:14 -0500
Message-ID: <406DF3B0.4030300@mvista.com>
Date: Fri, 02 Apr 2004 15:13:52 -0800
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@digitalimplant.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Device suspend/resume fixes
References: <20040402222838.GB2423@dhcp193.mvista.com> <Pine.LNX.4.50.0404021458150.20130-100000@monsoon.he.net>
In-Reply-To: <Pine.LNX.4.50.0404021458150.20130-100000@monsoon.he.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
>>(3) Flush signals between resume handlers in case a resume function
>>causes, for example, an ECHILD from modprobe or hotplug, so
>>interruptible APIs for the next handler aren't affected.
> 
> 
> Are there really cases in which you see this as an issue?

Ugh, I meant SIGCHILD, not ECHILD.  We have seen this in the past on a 
2.4 backport, although perhaps in a different environment than is 
normally used (this was on a PowerPC embedded platform that powers off 
the I/O ring during suspend).  For certain hotpluggable devices such as 
USB we've found it best to completely de-init and re-init the controller 
and re-sense plugged cards at suspend/resume time, which is when we saw 
troublesome signals (I2C setup then "timed out" before the controller 
was ready because a SIGCHILD was waiting).  I admit I don't know that 
much about the hotplug handlers, maybe I just didn't have things setup 
properly.  So if this seems bizarre then I'll withdraw it and try things 
again later when I have such hardware running in 2.6.  Thanks,

-- 
Todd Poynor
MontaVista Software
