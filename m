Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279865AbRKRQhq>; Sun, 18 Nov 2001 11:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279891AbRKRQhg>; Sun, 18 Nov 2001 11:37:36 -0500
Received: from maile.telia.com ([194.22.190.16]:59377 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S279865AbRKRQh0>;
	Sun, 18 Nov 2001 11:37:26 -0500
Message-ID: <3BF7E352.5090700@peope.net>
Date: Sun, 18 Nov 2001 17:35:30 +0100
From: Per-Olof Pettersson <lkml.lists@peope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jamie Lokier <lfs@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Introducing FUSE: Filesystem in USErspace
In-Reply-To: <200111121128.MAA15119@duna207.danubius> <20011117175253.A5003@kushida.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

> Miklos Szeredi wrote:
> 
>>    - Thin layer in kernel. Minimal caching, predictable behavior.
>>
> 
> Minimal caching?  I would hope for maximal caching, for when userspace
> is able to say "yes the page you have is still valid".  Preferably
> without a round trip to userspace for every page.

Caching userspace filesystems is dependant of the implimentation. You 
would need to send some info to the kernel-part saying "Yes this part 
can be cached this long without a signal to userspace".

This would be equal to the caching-mechanism in a Web-server.

Most often the userspace-part would not know what parts will not change 
in a certain amount of time.. But then again.. Some implementations could.

Another way could be an explicit call to the kernel by the Userspace 
File System saying "Now this caching is no longer valid".

One implementation with static data could be a fs that is tied to a prog 
retrieving statistical data eg. Perhaps it is supposed to be run each 
hour. Then you would know "good enough" that the data has not been 
changed until next update. But suppose you manually restart the update 
of data, you would need to tell the kernel that caching of old data is 
not valid anymore.

Thing is you need the kernel-part to be told what can be cached, what 
cannot and how long it can be cached.

Then you would need a mechanism for the Userspace-part to make a caching 
invalid.

There is probably more into this than just these fundamentals.. And a 
simple working (not buggy) FS is preferred than a complicated (possibly 
buggy) FS that will never be released and is difficult to write 
userspace code for IMHO.

Best regards
Per-Olof Pettersson

