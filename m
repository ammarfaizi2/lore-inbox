Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbWJRN7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWJRN7i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 09:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbWJRN7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 09:59:38 -0400
Received: from vstglbx99.vestmark.com ([208.50.5.99]:14344 "EHLO
	texas.hq.viviport.com") by vger.kernel.org with ESMTP
	id S1161022AbWJRN7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 09:59:37 -0400
Message-ID: <45363348.1060503@vestmark.com>
Date: Wed, 18 Oct 2006 09:59:36 -0400
From: Nathan Meyers <nmeyers@vestmark.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Catalin Marinas <catalin.marinas@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Major slab mem leak with 2.6.17 / GCC 4.1.1
References: <20061013004918.GA8551@viviport.com> <84144f020610122256p7f615f93lc6d8dcce7be39284@mail.gmail.com> <b0943d9e0610130459w22e6b9a1g57ee67a2c2b97f81@mail.gmail.com> <1160899154.5935.19.camel@Homer.simpson.net> <20061015141437.GA29712@viviport.com> <1160935198.6007.14.camel@Homer.simpson.net>
In-Reply-To: <1160935198.6007.14.camel@Homer.simpson.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Oct 2006 13:59:36.0678 (UTC) FILETIME=[A58BC860:01C6F2BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Sun, 2006-10-15 at 10:14 -0400, nmeyers@vestmark.com wrote:
>> On Sun, Oct 15, 2006 at 07:59:14AM +0000, Mike Galbraith wrote:
>>> On Fri, 2006-10-13 at 12:59 +0100, Catalin Marinas wrote:
>>>> On 13/10/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>>>>> On 10/13/06, nmeyers@vestmark.com <nmeyers@vestmark.com> wrote:
>>>>>> If anyone has a version of kmemleak that I can build with 4.1.1, or
>>>>>> any other suggestions for instrumentation, I'd be happy to gather more
>>>>>> data - the problem is very easy for me to reproduce.
>>> 2.6.19-rc1 + patch-2.6.19-rc1-kmemleak-0.11 compiles fine now (unless
>>> CONFIG_DEBUG_KEEP_INIT is set), boots and runs too.. but axle grease
>>> runs a lot faster ;-)  I'll try a stripped down config sometime.
>>>
>>> 	-Mike
>> Thanks for digging that up - I'm building gcc now and will let you
>> know if any useful info emerges.
> 
> Buyer beware of course ;-)
> 
> 	-Mike
> 
> 

So, after all this, what I have to report is: Nothing. Building the same
kernel with which I saw the problem (Gentoo's 2.6.17-r8 ebuild) with the
patched gcc 4.1.1 and the kmemleak patches failed to reproduce the
problem. Either those changes perturbed the kernel enough to "fix" the
problem, or my earlier kernel build was some sort of unrepeatable
miscompile.

I noticed one oddness with the 2.6.17 kmemleak patches when built with
the patched gcc. When I had earlier built with gcc-3.4.6
(CONFIG_DEBUG_MEMLEAK_TRACE_LENGTH=4 and CONFIG_FRAME_POINTER=y),
kmemleak reported good information: every entry included four levels of
stack that clearly mapped to addresses described in System.map. That was
not the case when I built with the patched 4.1.1: every entry included
just one level of stack, with an apparently bogus address that didn't
map into the range of addresses in System.map.

So, in the end, a frustrated experiment. I'll be back if I find anything
interesting. Until then, I'm leaving the list, so please include my
address in any followup conversation. Thanks!

Nathan Meyers
nmeyers@vestmark.com
