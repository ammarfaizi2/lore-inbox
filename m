Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286959AbSATVZb>; Sun, 20 Jan 2002 16:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287177AbSATVZX>; Sun, 20 Jan 2002 16:25:23 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:33546 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S286959AbSATVZT>; Sun, 20 Jan 2002 16:25:19 -0500
Message-ID: <3C4B34D7.70202@namesys.com>
Date: Mon, 21 Jan 2002 00:21:27 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Shawn <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.40.0201200359520.503-100000@coredump.sh0n.net> <5.1.0.14.2.20020120154049.04d7fbc0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:

> At 11:31 20/01/02, Hans Reiser wrote:
>
>> In version 4 of reiserfs, our plan is to implement writepage such 
>> that it does not write the page but instead pressures the reiser4 
>> cache and marks the page as recently accessed.  This is Linus's 
>> preferred method of doing that.
>
>
> But why do you want to do your own cache? Any individual fs driver is 
> in no position to know the overall demands on the VMM of the currently 
> running kernel/user programs/etc. 


So the VM system should inform it.  The way to do that is to convey a 
sense of cache pressure that is in proportion to the size of cache used 
by that cache submanager, and then the cache submanager has to react 
proportionally.

If every write page is consider a pressure increment, and if the page is 
marked accessed, then proportional pressure is achieved.

> As such it is IMHO inefficient and I think it won't actually work due 
> to VMM requiring to free specific memory and hence calling writepage 
> on that specific memory so it can throw the pages away afterwards but 
> in your concept writepage won't result in the page being marked clean 
> and the vm has made no progress and you have just created a hole load 
> of headaches for the VMM which it can't solve...
>
> The VMM should be the ONLY thing in the kernel that has full control 
> of all caches in the system, and certainly all fs caches. Why you are 
> putting a second cache layer underneath the VMM is beyond me. It would 
> be much better to fix/expand the capabilities of the existing VMM 
> which would have the benefit that all fs could benefit not just ReiserFS.
>
I agree, except that using writepage is what Linus wants, and except for 
the DMA bug Rik mentions, it should work.  It would be nice if the VM 
maintainers were to comment writepage so that other filesystems could 
know how to use it (and fix the DMA bug Rik mentions).

Hans



