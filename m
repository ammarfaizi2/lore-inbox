Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281954AbRKZRmb>; Mon, 26 Nov 2001 12:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281951AbRKZRmN>; Mon, 26 Nov 2001 12:42:13 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:33574 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S281955AbRKZRmJ>; Mon, 26 Nov 2001 12:42:09 -0500
Message-ID: <3C027F7A.1070406@paulbristow.net>
Date: Mon, 26 Nov 2001 18:44:26 +0100
From: Paul Bristow <paul@paulbristow.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
CC: rgooch@ras.ucalgary.ca, linux-kernel@vger.kernel.org
Subject: Re: ide-floppy.c vs devfs
In-Reply-To: <000301c17661$c9ff6db0$21c9ca95@mow.siemens.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is one of making it user-comprehensible.

If I just use grok_partitions I get no disc nodes created in devfs.  If 
I do my thing I get a floppy node created, regardless of wether a disk 
is inserted at load time.  This gives something for you to attempt to 
mount after inserting a disk, that causes a revalidate, and gets the 
correct disk nodes created.

This is made somewhat more complicated by the fact that ide-floppy disks 
can use either the whole disk, with no partition table or, more 
commonly, partition4.  So a user-friendly solution would be to create a 
floppy node that pointed to the partition, if it existed, or the whole 
disk if it didn't.  With appropriate code to handle that fact that 
anyone can partition these disks in any way they like.

Note this doesn't take account of the nice ATAPI command that sets the 
disk into "ignore track 0" mode, making a partition 4 look like an 
entire floppy with 1 less track.

Anyone up to telling me how this is handled in the SCSI layer?

Borsenkow Andrej wrote:

>>>Try the devfs test version that I just uploaded to 
>>>
>>>http://paulbristow.net/linux/idefloppy.html 
>>>
>>>This is early days, and I'm not sure what the best approach is... 
>>>
>>>Feedback is greatly appreaciated. 
>>>
> 
> On this page you mention that Mandrake includes this patch, but your
> driver (link on the above patch) differs from Mandrake one. In patch I
> sent to Mandrake I just fake drive capacity in case
> CAPACITY_NO_CARTRIDGE is returned.


Sorry, not trying to detract from anyone's work.  That line refers to 

mandrake having the clik support way before it was included in the stock 

kernel.  I'll clarify the web page.
 
>>I haven't had time to look at this closely, but I question why you're 
>>trying to prevent grok_partitions() from doing it's thing. There's 
>>supposed to be a flag set for removable media which ensures media 
>>revalidation on scanning the parent directory or looking up an entry. 
>>I'd rather see that mechanism fixed. 
>>
> 
> Currently grok_partitions() silently ignores any media with size == 0,
> irrespectively of whether removable is set or not. It means that *no*
> entries for drive (either disc or part?) are created at all and there is
> nothing that later on triggers revalidation.
> 
> I still believe grok_partitions() should create disc node for removables
> even if current capacity == 0 (that for removable just means there is no
> media inserted). Then it would work the way you describe and faking
> drive capacity for empty drives could be removed (IIRC it happens for
> other removables like SCSI disks as well).
> 



-- 

Paul

Email: 
paul@paulbristow.net
Web: 
http://paulbristow.net
ICQ: 
11965223

