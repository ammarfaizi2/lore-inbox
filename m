Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbUCDXGp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 18:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbUCDXGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 18:06:45 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:57329 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261874AbUCDXGn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 18:06:43 -0500
Message-ID: <4047B67A.4050609@mvista.com>
Date: Thu, 04 Mar 2004 15:06:34 -0800
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
References: <20040302213901.GF20227@smtp.west.cox.net> <200403031113.02822.amitkale@emsyssoft.com> <20040303151628.GQ20227@smtp.west.cox.net> <200403041011.39467.amitkale@emsyssoft.com> <20040304152729.GC26065@smtp.west.cox.net>
In-Reply-To: <20040304152729.GC26065@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Thu, Mar 04, 2004 at 10:11:39AM +0530, Amit S. Kale wrote:
> 
>>On Wednesday 03 Mar 2004 8:46 pm, Tom Rini wrote:
>>
>>>On Wed, Mar 03, 2004 at 11:13:02AM +0530, Amit S. Kale wrote:
> 
> [snip]
> 
>>>>kgdb_serial isn't ugly. It's just a function switch, similar to several
>>>>of them in the kernel. ppc is ugly, but that's anyway the case because of
>>>>so many varieties of ppc. If we are trying to make ppc code clean, it
>>>>makes more sense to move this weak function thing into ppc specific files
>>>>IMHO.
>>>
>>>I think you missed the point.  The problem isn't with providing weak
>>>functions, the problem is trying to set the function pointer.  PPC
>>>becomes quite clean since the next step is to kill off
>>>PPC_SIMPLE_SERIAL and just have kgdb_read/write_debug_char in the
>>>relevant serial drivers.
>>
>>We can still have one single hardcoded function pointer for ppc and manage
>>the rest in ppc specific files.
> 
> 
> I think you're still missing the point.
> 
> Regardless, the solution to this is what dwmw2 suggested on IRC I
> believe, as this should remove all of the #ifdef mess.

I am afraid I don't quite understand what he was saying other than early init 
stuff.  On of the problems with trying early init stuff, by the way, is that a 
lot of things depend on having alloc up and that happens rather late in the game.

But back to the method.  Is he/are you suggesting that the init code plug the 
array of functions into the kgdb table?  This could be done by providing a 
register function in kgdb to register an i/o method.  Pass it a pointer to a 
struc of entry points, keep the pointers in an array, etc.  All that is left is 
to define the default in some simple and clean way, a way that might be 
overridden at command line parse time and so on.

I haven't looked at the latest version of the kgdb serial code, but it could, 
rather easily, be set up to initiialize on first call (if it isn't now), so for 
it, and others that can do likewise we could register the method at compile time.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

