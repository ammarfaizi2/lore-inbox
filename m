Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWCWH4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWCWH4c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 02:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWCWH4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 02:56:32 -0500
Received: from alpha.polcom.net ([83.143.162.52]:23499 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1030188AbWCWH4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 02:56:31 -0500
Date: Thu, 23 Mar 2006 08:56:24 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ck] swap prefetching merge plans
In-Reply-To: <200603231804.36334.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.63.0603230837500.14361@alpha.polcom.net>
References: <20060322205305.0604f49b.akpm@osdl.org> <200603231804.36334.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2006, Con Kolivas wrote:
> On Thu, 23 Mar 2006 03:53 pm, Andrew Morton wrote:
>> A look at the -mm lineup for 2.6.17:
>
>> mm-implement-swap-prefetching.patch
>> mm-implement-swap-prefetching-fix.patch
>> mm-implement-swap-prefetching-tweaks.patch
>
>>   Still don't have a compelling argument for this, IMO.
>
> For those users who feel they do have a compelling argument for it, please
> speak now or I'll end up maintaining this in -ck only forever.

Well, it works for me rather good. After I close some memory demanding 
aplication (like game or qemu) that caused huge portion of the memory to 
be swapped out to disk, the time needed to swith back to firefox or 
eclipse is really really shorter. Also the GUI is more responsive (because 
there are nearly none disk accesses needed when I am entering some dialog 
box or menu).

Without the patch system is taking up to several seconds to come back and 
even after that is feels jerky because it still must get some page from 
disk while I do some work.

Also I would really be glad to see the second part of the idea: mirroring 
some pages from memory to disk while system is relatively idle. This could 
make swapout nearly a no-op and this could really help some workloads if 
you are short on RAM. And software engeneerers and programmers are really 
working hard to eat all your RAM even if you think that "now you have 
really much".

I have Athlon XP 3000+ system with 1GB of RAM and 4GB of swap. It works 
pretty well on that configuration. I have so much swap because I am 
compiling I my packages (Gentoo) on tmpfs. So during (or after) some big 
compilation (like qt, gcc or something) swap prefetching is really helpful 
in getting my desktop apps back. (Also Con's scheduler is helpfull 
in allowing me to compile things in the background without nearly any 
problems and bad interaction with eclipse, openoffice and firefox.
It does not work excelent in all cases but it usually works very well.)

So, not that I have any vote here, I would really glad to have it merged. 
More people will be able to read the code and maybe it will become even 
better.


Thanks for your work,

Grzegorz Kulewski

