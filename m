Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281748AbRK0RpF>; Tue, 27 Nov 2001 12:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282182AbRK0Ro6>; Tue, 27 Nov 2001 12:44:58 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:40226 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S281748AbRK0Roq>; Tue, 27 Nov 2001 12:44:46 -0500
Message-ID: <3C03D197.7050605@paulbristow.net>
Date: Tue, 27 Nov 2001 18:47:03 +0100
From: Paul Bristow <paul@paulbristow.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
CC: Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: ide-floppy.c vs devfs
In-Reply-To: <000601c1773f$d80d9ba0$21c9ca95@mow.siemens.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Borsenkow Andrej wrote:

>>This is made somewhat more complicated by the fact that ide-floppy
>>
> disks
> 
>>can use either the whole disk, with no partition table or, more
>>commonly, partition4.  So a user-friendly solution would be to create
>>
> a
> 
>>floppy node that pointed to the partition, if it existed, or the whole
>>disk if it didn't.  With appropriate code to handle that fact that
>>anyone can partition these disks in any way they like.
>>
>>
> 
> Where's the problem? Use .../disc for whole disc or .../part4 for
> "normal" access. (Or /dev/hdc and /dev/hdc4 if you prefer) It is nice if
> partition code can detect it but it is not ide-floppy driver problem.


Just wondering if we should be clever for the users here.  Maybe I 
should leave that to user-space tools?  Or is there anything in devfs 
that can take care of this?  The nice solution for end-users might be
a /dev/idefloppy that is a symlink to the relevant node in the 
/dev/ide... tree.


>>Note this doesn't take account of the nice ATAPI command that sets the
>>disk into "ignore track 0" mode, making a partition 4 look like an
>>entire floppy with 1 less track.
>>
>>
> 
> Why complicate things more than needed?

Because you can boot from a zip or ls-120 drive, with the BIOS setting 
it to this mode.  There are disks out there that are unreadable unless 
you ignore track zero, by formatting them in a PC like this.


>>Anyone up to telling me how this is handled in the SCSI layer?
>>
>>
> 
> When I boot without media in Jaz drive I get something like "no media
> inserted, assuming 1GB 512B per sector". Actually I modeled my patch
> from this - use some default values reported by drive when no media
> currently exists.


OK.  This makes the most sense here.  I'm happy to go with this.

I'll dig out your patch - discovered I was on holiday when you 
originally submitted it - and code and test something over the next day 
or so.  Thanks for the help


> -andrej


-- 

Paul

Email: 
paul@paulbristow.net
Web: 
http://paulbristow.net
ICQ: 
11965223

