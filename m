Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbTFYOKO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 10:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbTFYOKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 10:10:14 -0400
Received: from dm2-58.slc.aros.net ([66.219.220.58]:12460 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S264540AbTFYOKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 10:10:10 -0400
Message-ID: <3EF9B092.90906@aros.net>
Date: Wed, 25 Jun 2003 08:24:18 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [RFC][PATCH] nbd driver for 2.5+: fix locking issues with ioctl
 UI
References: <3EF94672.3030201@aros.net> <20030625001950.16bbb688.akpm@digeo.com>
In-Reply-To: <20030625001950.16bbb688.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Lou Langholtz <ldl@aros.net> wrote:
>  
>
>>That said, this seems like an opportunistic time to further break 
>> compatibility with the existing nbd-client user tool and  do away with 
>> the problematic components of the ioctl user interface.
>>    
>>
>
>Is a suitably modified userspace tool available?
>  
>
Seems like a pandora's box (and/or catch-22)... A modified userspace 
tool is not yet available that I know of. I have a hacked version that 
I've been using to test things with of course. But it's not in a very 
nice state to release. And then Pavel's distro of the tool is probably 
what most people use anyway. I have a seperate distro in part because I 
wanted to just play with things at first and thought sharing the sources 
might be useful to someone. Etc. Anyways, I wanted to get a feeling 
first from the kernel hacking community how important back compatibility 
was to them w.r.t. this driver. Since the original jumbo patch also got 
criticized against for supporting multiple linux version in the driver 
sources (via the LINUX_VERSION macros), seems like there's some split in 
what people may prefer. I wanted to generate comments on these specific 
changes to solidify what changes would really be needed in the user 
space tool before also distributing a changed nbd-client. It would also 
help to have something like a version ioctl or something that could be 
keyed on to provide the correct support. On the other hand, I'm not sure 
that Pavel even realized that the block layer changes impacted the 
semantics of the sizing ioctl (such that the user-space tool needs to 
re-open the file descriptor to get the proper size in). I didn't realize 
this myself even till only a few days ago but I had been wondering all 
along why sizing hadn't been working right. Sigh. Just to many other 
things to also do. The driver could also fix this sizing issue but 
coding the change their feels more like a hack than in the client tool. 
On the bright side, Pavel's nbd-client could probably be ifdef'd quite 
easily to work-around/fix the sizing issue and also this new proposed 
ioctl interface. Let me catch up w/ LKML mail and see what others have 
to say so far. I can probably produce a diff for Pavel easily enough 
(more easily than for my distro of the same) so that we won't have these 
issues anymore. But then full circle, it all depends on how the 
community would like to see these issues resolved (ie. maybe they want 
the sizing fixed in the driver instead and personally it's a close balance).

