Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264733AbTFYRYn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264756AbTFYRYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:24:43 -0400
Received: from dm2-58.slc.aros.net ([66.219.220.58]:37813 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S264733AbTFYRYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:24:35 -0400
Message-ID: <3EF9DE23.2080806@aros.net>
Date: Wed, 25 Jun 2003 11:38:43 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [RFC][PATCH] nbd driver for 2.5+: fix locking issues with ioctl
 UI
References: <3EF94672.3030201@aros.net> <20030625001950.16bbb688.akpm@digeo.com> <3EF9C192.7000206@aros.net> <20030625165513.A20328@infradead.org>
In-Reply-To: <20030625165513.A20328@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Wed, Jun 25, 2003 at 09:36:50AM -0600, Lou Langholtz wrote:
>  
>
>>I have also attached a patch to Pavel's nbd-2.0 release nbd tools that 
>>updates the nbd-client to work with linux 2.5 as well as 2.5.74 
>>(assuming the aforementioned patch 6.1 made it into 2.5.74). Handling is 
>>switched at compile time however and uses <linux/version.h> to do the 
>>switching. This will have problems of course if the builder doesn't pay 
>>close attention to where there header file are coming from or tries to 
>>run the same binary on a different kernel release. Etc.
>>    
>>
>
>That's broken.  You must make sure that a binary works with different
>kernels or at least make it fail gracefully.  Using <linux/version.h>
>from userspace is absolutely not acceptable, just don't use kernel headers
>at all but a local copy of <linux/nbd.h>.
>  
>
Yes. To be fair though, the binary (and the driver too) was broken on 
linux 2.5 kernels long before I even proposed any changes to the nbd 
driver. I'm trying to fix that. But it's a puzzle that has to have 
pieces moved out of the way first. With constraints like making one 
patch per fundemental change, it's more of a challenge trying to keep 
things in sync with user space. I'd like to see binary (runtime) 
compatibility too, but it's a bigger step to implement that. In the 
meantime, the hack/patch I submitted to nbd-client seems like a step 
forward. At least it works its way around several of the 
incompatibilities and lets people find out what other problem may lie 
ahead. I just found another problem for example with the disconnect 
function in nbd-client that will need to be fixed in order to be able to 
unload the module. A future step will be to change the compile time 
switching to a runtime switch, but I'm not sold on any one way to 
implement this yet. If you have something in mind for this, let me know. 
For example, should the ioctls be used to somehow notify the user 
process of the differing implementation. Like returning EINVAL for 
NBD_SET_SOCK. That'd tell nbd-tool that the nbd driver thinks something 
about the ioctl was invalid but not what. I wanted to return EDEPRECATED 
instead but I haven't found that errno yet. I could overload an errno 
but that seems ugly too. Or the driver could have a NBD_GET_VERSION 
ioctl. Is there precedence for that? I haven't come accross it yet.

How would you propose these issues be solved? Keep in touch!! Thanks!!

