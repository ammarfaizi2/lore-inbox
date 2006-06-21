Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWFUBYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWFUBYh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWFUBYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:24:36 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:9653 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750768AbWFUBYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:24:36 -0400
Message-ID: <44989FD3.1040805@vmware.com>
Date: Tue, 20 Jun 2006 18:24:35 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       jeremy@xensource.com
Subject: Re: [PATCH 2.6.17] Clean up and refactor i386 sub-architecture setup
References: <44988803.5090305@goop.org> <44988E08.9070000@vmware.com> <449891B9.3060409@goop.org> <4498958B.504@vmware.com> <44989E25.3090402@goop.org>
In-Reply-To: <44989E25.3090402@goop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> Zachary Amsden wrote:
>> This is cleaner than the patches I sent in March, although we want to 
>> re-use parts of the mach-default code, not replace it entirely.  
>> Hence my interest in the multi-subarch generic kernel.  I'd be glad 
>> to look into it.
> In my current Xen patch, I split the mach-default/setup.c into setup.c 
> and setup-memory.c; Xen uses setup.c as-is, and then provides its own 
> setup-xen.c.  That solves my immediate problem, but I don't know if it 
> generalizes enough; certainly factoring default/setup.c into a cluster 
> of reusable setup-*.c pieces is a pretty lightweight way of reusing 
> those pieces.

I was thinking more of having mach-xen/built-in.o, 
mach-default/built-in.o, mach-es7000/built-in.o, mach-voyager/built-in.o 
all be linked specially so they can be compiled into the same kernel 
either as one giant batch, with weak linkage and a function table to 
indirect calls to them (thus the generic kernel can jettison the modules 
outside of the subarch it has chosen at boot time, potentially keeping 
the default kernel as well to allow subarches to fallback on the 
traditional indirections).  And if compiled as a specific kernel, those 
weak linkages get promoted to direct instead of indirect calls.

You may have to separate the namespaces at the identifier level as well, 
use some elven magic, but I haven't worked out all the details yet.

Zach
