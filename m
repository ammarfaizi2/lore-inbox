Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUCKVeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 16:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUCKVeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 16:34:13 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:50677 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261752AbUCKVdr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 16:33:47 -0500
Message-ID: <4050DB34.8060704@mvista.com>
Date: Thu, 11 Mar 2004 13:33:40 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: "Amit S. Kale" <amitkale@emsyssoft.com>, Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
References: <20040302213901.GF20227@smtp.west.cox.net> <200403031113.02822.amitkale@emsyssoft.com> <20040303151628.GQ20227@smtp.west.cox.net> <200403041011.39467.amitkale@emsyssoft.com> <20040304152729.GC26065@smtp.west.cox.net> <4047B67A.4050609@mvista.com> <20040304231737.GJ26065@smtp.west.cox.net>
In-Reply-To: <20040304231737.GJ26065@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
~

>>I am afraid I don't quite understand what he was saying other than early 
>>init stuff.  On of the problems with trying early init stuff, by the way, 
>>is that a lot of things depend on having alloc up and that happens rather 
>>late in the game.
> 
> 
> I assume you aren't talking about kgdb stuff here (or what would be the
> point of going so early) but I believe he was talking about allowing for
> stuff that could be done early, to be done early.

One of the issues with the UART set up is registering the interrupt handler with 
the kernel.  It will fail if alloc is not up.  The -mm patch does two things 
with this.  a) It tries every getchar to register the interrupt handler, and b) 
it has a module init entry to register it.  This last will happen late in the 
bring up and is safe.  a) is there to get it ASAP if you are actually using kgdb 
during the bring up.
> 
> 
~

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

