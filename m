Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWH1RmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWH1RmT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 13:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWH1RmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 13:42:18 -0400
Received: from [62.205.161.221] ([62.205.161.221]:50860 "EHLO kir.sacred.ru")
	by vger.kernel.org with ESMTP id S1751201AbWH1RmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 13:42:17 -0400
Message-ID: <44F32AC7.1090604@openvz.org>
Date: Mon, 28 Aug 2006 21:41:27 +0400
From: Kir Kolyshkin <kir@openvz.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060802)
MIME-Version: 1.0
To: rohitseth@google.com, devel@openvz.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>, Andi Kleen <ak@suse.de>,
       Chandra Seetharaman <sekharan@us.ibm.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [Devel] Re: BC: resource beancounters (v2)
References: <44EC31FB.2050002@sw.ru> <20060823100532.459da50a.akpm@osdl.org>	<44EEE3BB.10303@sw.ru> <20060825073003.e6b5ae16.akpm@osdl.org>	<20060825203026.A16221@castle.nmd.msu.ru>	<1156558552.24560.23.camel@galaxy.corp.google.com>	<1156610224.3007.284.camel@localhost.localdomain> <1156783721.8317.6.camel@galaxy.corp.google.com>
In-Reply-To: <1156783721.8317.6.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0.2 (kir.sacred.ru [62.205.161.221]); Mon, 28 Aug 2006 21:39:53 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:
> On Sat, 2006-08-26 at 17:37 +0100, Alan Cox wrote:
>   
>> Ar Gwe, 2006-08-25 am 19:15 -0700, ysgrifennodd Rohit Seth:
>>     
>>> Yes, sharing of pages across different containers/managers will be a
>>> problem.  Why not just disallow that scenario (that is what fake nodes
>>> proposal would also end up doing).
>>>       
>> Because it destroys the entire point of using containers instead of
>> something like Xen - which is sharing. Also at the point I am using
>> beancounters per user I don't want glibc per use, libX11 per use glib
>> per use gtk per user etc..
>>
>>
>>     
>
> I'm not saying per use glibc etc.  That will indeed be useless and bring
> it to virtualization world.  Just like fake node, one should be allowed
> to use pages that are already in  (for example) page cache- so that you
> don't end up duplicating all shared stuff.  But as far as charging is
> concerned, charge it to container who either got the page in page cache
> OR if FS based semantics exist then charge it to the container where the
> file belongs.  What I was suggesting is to not charge a page to
> different counters.
>   

Consider the following simple scenario: there are 50 containers 
(numbered, say, 1 to 50) all sharing a single installation of Fedora 
Core 5. They all run sshd, apache, syslogd, crond and some other stuff 
like that. This is actually quite a real scenario.

In the world that you propose the container which was unlucky to start 
first (probably the one with ID of either 1 or 50) will be charged for 
all the memory, and all the
others will have most of their memory for free. And in such a world 
per-container memory accounting or limiting is just not possible.
