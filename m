Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbULaLb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbULaLb0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 06:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbULaLb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 06:31:26 -0500
Received: from [195.23.16.24] ([195.23.16.24]:60631 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261854AbULaLbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 06:31:24 -0500
Message-ID: <41D53876.9050704@grupopie.com>
Date: Fri, 31 Dec 2004 11:31:02 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: William Park <opengeometry@yahoo.ca>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: waiting 10s before mounting root filesystem?
References: <20041227195645.GA2282@node1.opengeometry.net> <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at> <20041229005922.GA2520@node1.opengeometry.net> <20041230152531.GB5058@logos.cnet> <Pine.LNX.4.61.0412310011400.3494@dragon.hygekrogen.localhost> <Pine.LNX.4.61.0412310234040.4725@dragon.hygekrogen.localhost> <20041231035834.GA2421@node1.opengeometry.net> <Pine.LNX.4.61.0412310537420.26032@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0412310537420.26032@dragon.hygekrogen.localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> [...]
>> #include <linux/nfs_fs.h>
>> #include <linux/nfs_fs_sb.h>
>>@@ -278,6 +279,7 @@
>> 	char *fs_names = __getname();
>> 	char *p;
>> 	char b[BDEVNAME_SIZE];
>>+	int tryagain = 20;
>> 
> 
> Ok, I'm nitpicking here, but why int and not short? are we likely to ever
> want to wait for more than 2 minutes? and if we want to wait ~3min, then
> unsigned short should do just fine (and unsigned would even be logical
> since negative retry value doesn't make any sense)....

Usually it is better to use int's instead of short's because memory 
accesses for CPU word size data are faster.

With some CPUs, decrementing a short will probably involve reading a int 
from memory, updating only the correct section of it, and then writing 
an int. It is only worth the save if you're trying to make a very used 
struct have a good 2^N size, or something like that.

Of course, things will get more complex with data caches, bus sizes, 
etc., but I think the premise that the CPU will be more confortable 
handling its native data size still holds.

-- 
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu

