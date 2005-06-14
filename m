Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVFNT1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVFNT1i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 15:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVFNT1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 15:27:38 -0400
Received: from mail00hq.adic.com ([63.81.117.10]:40294 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S261205AbVFNT1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 15:27:34 -0400
Message-ID: <42AF2FA1.7080403@xfs.org>
Date: Tue, 14 Jun 2005 14:27:29 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Prarit Bhargava <prarit@sgi.com>
CC: "K.R. Foley" <kr@cybsft.com>, Andrew Morton <akpm@osdl.org>,
       pozsy@uhulinux.hu, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
References: <42A99D9D.7080900@xfs.org>	<20050610112515.691dcb6e.akpm@osdl.org>	<20050611082642.GB17639@ojjektum.uhulinux.hu>	<42AAE5C8.9060609@xfs.org>	<20050611150525.GI17639@ojjektum.uhulinux.hu>	<42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org> <42AEDCFB.8080002@xfs.org> <42AEF979.2000207@cybsft.com> <42AF080A.1000307@xfs.org> <42AF0FA2.2050407@cybsft.com> <42AF165E.1020702@xfs.org> <42AF2088.3090605@sgi.com>
In-Reply-To: <42AF2088.3090605@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jun 2005 19:27:31.0490 (UTC) FILETIME=[1BD29820:01C57117]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Prarit,

I updated mkinitrd from 4.1.18 to 4.2.15 and udev from 039 to 058.
This appears to have cured it on my work machine, I will try the
other box later.

Looking at Documentation/Changes, which appears to still be the
official repository for required tool versions, it seems somewhat
dated, and makes no mention of mkinitrd version requirements.

Steve

Prarit Bhargava wrote:
> Colleagues,
> 
> (Copied and edited from a post I made on linux-hotplug-devel last month.)
> 
> I've privately emailed Steve with a quick-and-dirty solution for the 
> problems he was experiencing with the system boot.  I wasn't sure if he 
> was having the same problems I've had with 2.6.12 and old packages but 
> it looks like he was.
> 
> I'm surprised we haven't had more people on this list wondering about 
> the strange behaviour of their initrd/initramfs :) .
> 
> When I looked at the original output Steve had posted I noticed that it 
> looked like drivers were attempting to load at the same time and because 
> of this he eventually hit an oops.  I (and an engineer from another 
> company working on another arch) have hit the same problem due to the 
> requirements of our current work.
> 
> (Unfortunately, I'm more familiar with RedHat/Fedora than I am with 
> other distro's -- please bear with me.)
> 
> The issue is that David Howells posted a patch that changed the 
> behaviour of kallsyms/insmod/rmmod sometime ago.  The patch *is correct* 
> in what it does, however, the patch requires that /sbin/sh must be aware 
> of pid returns by wait().
> 
>     http://lkml.org/lkml/2005/1/17/132
> 
> There are two fixes that I'm aware of, and depending on what you're 
> doing they are both "correct" (although in the case of developing in 
> 2.6.12, IMO, you
> _must_ do the latter).
> 
> The first fix is for the situation where you're developing for a 
> specific distribution.  If this is the case, then you should back out 
> the patch above and continue moving forward.
> 
> The second fix, and again you must do this if you're developing 2.6.12, 
> is to *update the mkinitrd package* which has a new version of /bin/sh.
> 
> P.
> 

