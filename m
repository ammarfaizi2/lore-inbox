Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTKAGfY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 01:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263728AbTKAGfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 01:35:24 -0500
Received: from pa-steclge-cmts2a-19.stcgpa.adelphia.net ([68.168.167.19]:35564
	"EHLO potassium.stop.dyndns.org") by vger.kernel.org with ESMTP
	id S261176AbTKAGfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 01:35:17 -0500
Message-ID: <3FA353E4.60906@nodivisions.com>
Date: Sat, 01 Nov 2003 01:34:12 -0500
From: Anthony DiSante <orders@nodivisions.com>
Reply-To: orders@nodivisions.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Audio skips when RAM is ~full
References: <3FA34523.30902@nodivisions.com> <20031101062050.GA13731@alpha.home.local>
In-Reply-To: <20031101062050.GA13731@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hello !
> 
> On Sat, Nov 01, 2003 at 12:31:15AM -0500, Anthony DiSante wrote:
> 
>>The kernel is buffering the contents of each directory (album) that it 
>>reads (and also, mpg321 copies each mp3 file into RAM before playing it?).  
>>I understand that the idea is to stuff as much into RAM as possible to 
>>reduce pagefile usage, and that the kernel will reclaim memory utilized by 
>>buffers if/when it needs to.  But apparently that isn't happening fast 
>>enough to allow a realtime process like music-playing to work skip-free on 
>>this system with this soundcard.  I think that if I could regularly 
>>forcibly dump the buffered stuff out of the RAM (dropping the used-RAM 
>>percentage down to, say, 10%, like at boot time) then this would make the 
>>skipping stop.
> 
> 
> 1) are you certain that none of your programs (including mpg321) leaks
>    memory ? As I understand it, it's really the cache which fills memory.

No, I'm not certain that mpg321 (or any other app, though there's 
next-to-nothing else running) is leak-free.

> 2) you can try to preload your file into the cache just before playing it :
>    cp $file /dev/null ; mpg321 $file

But wouldn't "cp $file /tmp/ramdisk0; mpg321 /tmp/ramdisk0/$file" accomplish 
the same thing?  (I've done that.)

>>So... do I have a correct understanding of the problem, and a correct 
>>analysis of the kernel/mem issues that are related to it?  Is it possible 
>>to clear some of the RAM; if so, would that help?
> 
> 
> Unless a leak happens somewhere in the kernel, sound driver, etc..., memory
> consumed by programs is restored when your programs exit. The only part which
> is not restored immediately is the cache.
> 
> BTW, there may be one other reason for your problem. Considering that you
> scan your disk to find random albums, I think that the system updates all
> directories access time after 5s, thus preventing your player from reading
> an uncached file fast enough. You might be interested in mounting it with
> the 'noatime,nodiratime' options in /etc/fstab.

Actually, I don't scan the disk to find random albums; I have a text file 
that contains a list of every album's full path, and I pick a random line 
from that file.  So only the selected album's directory gets scanned.  And 
the mp3 partition is mounted read-only (I should have mentioned that 
before), so the atimes shouldn't be getting written as it is.

> You might also want to try 2.4.23pre9 which includes VM changes compared to
> 2.4.22, and seems quite stable to me.

Maybe I will give that a try.

So I'm guessing that there isn't actually a way to manually move buffer-data 
out of RAM?

-Anthony
http://nodivisions.com/
