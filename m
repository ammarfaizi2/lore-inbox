Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267685AbUH0IM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267685AbUH0IM4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 04:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268164AbUH0IMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 04:12:51 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:11221 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267685AbUH0IIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:08:40 -0400
Message-ID: <412EEC07.30707@namesys.com>
Date: Fri, 27 Aug 2004 01:08:39 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Will Dyson <will_dyson@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de>	<412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com> <412E10A2.1020801@pobox.com>
In-Reply-To: <412E10A2.1020801@pobox.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will Dyson wrote:

>
>
> In the original BeOS, they solved the problem by having the filesystem 
> driver itself take a text query string and parse it, returning a list 
> of inodes that match. The whole business of parsing a query string in 
> the kernel (let alone in the filesystem driver) has always seemed ugly 
> to me. 

Why?

> However, the best alternative I've come up with is to simply export 
> the index data as a special file (perhaps in sysfs?) and have 
> userspace responsible for searching the index.

That is the best implementation suggestion I've heard for splitting the 
filesystem into two parts, one in user space and one in kernel, but I 
still don't trust it to work well.

> That would probably work, but it wouldn't help other filesystems that 
> implement even a different index format, much less a different form of 
> extra searchability.
>
After reiser6 is implemented, we'll have a better idea of what parts 
need what from what other parts.  Until we get there, it needs to be 
kept together.  Frankly, I suspect that naming is not going to split so 
easily, but when it is done we'll be able to know.  The problems of 
putting too much functionality into the kernel are less than those of 
partitioning the filesystem code, and defining an inflexible API between 
the two parts.  Kernel interfaces are fairly inflexible because there 
will always be some moron who sidesteps the fs library to program 
directly to the kernel interface, gets screwed when the interface 
changes, has the nerve to complain about it, and works for some powerful 
distro.

Hans
