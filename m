Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbTJNIy0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 04:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbTJNIy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 04:54:26 -0400
Received: from smtp800.mail.ukl.yahoo.com ([217.12.12.142]:37976 "HELO
	smtp800.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262275AbTJNIyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 04:54:06 -0400
Message-ID: <3F8BB9ED.5010504@sbcglobal.net>
Date: Tue, 14 Oct 2003 03:55:09 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.5) Gecko/20031008
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: Why are bad disk sectors numbered strangely, and what happens
 to them?
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net> <200310140721.h9E7LmNE000682@81-2-122-30.bradfords.org.uk> <20031014074020.GC13117@bitwizard.nl> <200310140800.h9E80BT9000815@81-2-122-30.bradfords.org.uk> <20031014081110.GA14418@bitwizard.nl>
In-Reply-To: <20031014081110.GA14418@bitwizard.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rogier Wolff wrote:

>On Tue, Oct 14, 2003 at 09:00:11AM +0100, John Bradford wrote:
>  
>
>>Besides, a read error might not mean the data is lost, maybe the drive
>>marked it bad because the amount of error correction needed to
>>retrieve the data was just 'on the edge' of what was possible.
>>    
>>
>
>No. A read error means the data was lost. 
>
>The drive may reallocate it wehn it was "on the edge". 
>
>  
>
>>Again, I'm not sure what you are implying.  I don't use ReiserFS
>>personally, but I think it's a _good_ thing if it doesn't implement
>>    
>>
>
>Good Keep it that way. 
>
>  
>
>>bad sector mapping because I don't see any use for it.  If somebody
>>wants to use ReiserFS on an ST-506 disk, the block layer should handle
>>re-allocations, and present an always good block device to the
>>filesystem.
>>    
>>
>
>We don't have that block layer. 
>
>  
>
>>>You create a file called something like ".badblocks" in the root
>>>directory. If as a filesystem you get to know of a bad block, just
>>>allocate it towards that file. Next it pays to make the file invisble
>>>from userspace. (otherwise "tar backups" would try to read it!). 
>>>      
>>>
>>>This is usually done by just allocating an inodenumber for it, and
>>>telling  fsck about it, to prevent it being linked into lost+found 
>>>on the first fsck.... 
>>>
>>>      
>>>
>>>>The drive may well have been developing faults regularly through it's
>>>>entire lifetime, and you haven't noticed.  Now you have noticed and
>>>>want to work around the problem, but why wouldn't the drive continue
>>>>it's 'natural decay', and assuming it does, why would it be able to
>>>>re-map future bad blocks, but not this one?
>>>>        
>>>>
>>>On the other hand, I once bumped my knee against the bottom of the table
>>>that my computer was on. That was the exact moment that one of my
>>>sectors went bad. So now I know the cause, and want to remap the sector. 
>>>No gradual decay. 
>>>      
>>>
>>Why didn't the drive firmware remap that bad sector then?
>>    
>>
>
>Because it was an MFM drive.
>
>Point is that if you KNOW the cause of the bad block, it might be
>worth the trouble not to use it anymore. 
>
>  
>
>>If it actually refused to, my point stands - bad sectors not getting
>>remapped.  You would be relying on no future sector going bad.  Good
>>luck.
>>    
>>
>
>Even if the remap works, you might have a performance penalty. 
>If you skip the 4k block in the future, your 40Mb per second drive
>will be "idle" for 100 microseconds, dropping your performance
>from 40,000,000 bytes to 39,996,000 bytes in that second. But if
>a seek to the remapped sector is involved, you're losing several
>milliseconds of your disk's performance!
>
>And the real-time performance of the drive becomes unreliable. 
>Worst case, in a 1Mbyte block 1 million sectors are remapped,
>requiring a seek of 10ms. While normally reading that block of
>data would consume 1/40th of a second, you are now looking at
>about 3 hours. 
>
Well, aren't we talking about hardware sectors?  The hardware sectors 
are probably at least 1 MB in size to start with.  My old 16GB Maxtor 
that had remapped its way out of sectors only had 16 to remap (the last 
unit I had fail due to this problem).  I doubt the hardware sectors were 
anywhere near 1 byte in size.  The bad sectors also seemed to occur at 
an exponential rate, which is supported by the 5 drives I've seen go bad 
in this manner.  Supposedly that has to do with debries spreading across 
the platter and taking out adjacent sectors.  The one drive I didn't 
send back or replace immediately after the first error (i.e. no more 
sectors can be remapped) had lost nearly 50MB of space to bad sectors in 
a week, and 200MB by the time the replacement arrived 4 days later.  I 
imagine that this only gets worse as more data is packed into a smaller 
space.

>If you are streaming a video off this drive, 
>that doesn't sound like an option. (say requiring only 4Mb per
>second of throughput, i.e. having a factor of 10 of performance
>margin!)
>  
>

Is there even a way to disable sector remapping on an ATA drive anyway?  
To avoid these "disadvantages of hardware remapping" you'd need some way 
to ensure that the drive didn't remap any sectors.  As someone noted, 
their drive remapped a sector without anything showing up in the log. 

I start more closely watching any drive that remaps more than half its 
available sectors, if it gets close to the limit I replace it (if it's 
out of warranty, otherwise I help it along with some badblock runs).  
It's just not worth the hassle of losing data.  At least if the drive 
detects the error, chances are it recovers the data and copies it to a 
good sector (at least I've never lost any data from a drive remapping).  
I can't say the same for the filesystem trying to recover the data, 
which usually seems to result in a corrupted file.  IMHO, the data 
integrity of hardware remapping outweighs any performance disadvantage 
as compared to a filesystem-only based solution.

Now if only the drive would catch the problem without requiring a write 
to the offending sector first. ;-)  Maybe that's already fixed on the 
newer drives, none of my newer ones have remapped sectors yet.

-Wes-

>			Roger. 
>
>
>  
>

