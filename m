Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbVAPW6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbVAPW6m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 17:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbVAPW6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 17:58:42 -0500
Received: from quark.didntduck.org ([69.55.226.66]:10691 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262638AbVAPW6j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 17:58:39 -0500
Message-ID: <41EAF198.1020501@didntduck.org>
Date: Sun, 16 Jan 2005 17:58:32 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
CC: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
       zippel@linux-m68k.org
Subject: Re: [PATCH] split UTS_RELEASE to a separate header.
References: <20050116152242.GA4537@mellanox.co.il> <20050116161622.GC3090@mars.ravnborg.org> <20050116200046.GB5276@mellanox.co.il>
In-Reply-To: <20050116200046.GB5276@mellanox.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael S. Tsirkin wrote:
> Hello!
> Quoting r. Sam Ravnborg (sam@ravnborg.org) "Re: changing local version requires full rebuild":
> 
>>On Sun, Jan 16, 2005 at 05:22:42PM +0200, Michael S. Tsirkin wrote:
>>
>>>Hi!
>>>Is it just me, or does changing the local version always require
>>>a full kernel rebuild?
>>>
>>>If so, I'd like to fix it, since I like copying
>>>my kernel source with --preserve and changing the
>>>local version, then going back to the old version in case of
>>>a crash.
>>>Its important to change the local version to force 
>>>make install and make modules_install to put things in a separate
>>>directory.
>>
>>Just tried it out here.
>>After cp -Ra only a limited part of the kernel rebuilds.
>>o oiu.c in ieee directory - because it dependson the shell script
>>o A number of drivers that include version.h
>>	- This should be changed so local version does not affect
>>	  the reast of version.h.
>>o Other stuff that is always build if kernel has changed
>>
>>Do you use "echo -mylocalver > localversion" to change the local version?
>>
>>	Sam
> 
> 
> Well, we have
> /usr/src/linux-2.6.10-gold # grep -l UTS_RELEASE -rI . | wc -l
> 29
> grep -l version.h -rI . | fgrep -v .cmd | fgrep -v '.mod' | fgrep -e '.c' -e '.h' | wc -l
> 354
> 
> This means that about 300 files are compiled each time localversion changes,
> which do not actually use the local version.
> 
> So, let us split UTS_RELEASE to a separate header: release.h
> The following patch over 2.6.10 does that, and fixed the in-tree files that
> really need to include it.
> Works for me, and helps me cut down compilation time. Comments?
> 

Most of the stuff using UTS_RELEASE can use system_utsname.release 
instead (except boot code).  Most cases in drivers/ can simply be removed.

--
				Brian Gerst
