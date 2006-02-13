Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWBMP5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWBMP5n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWBMP5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:57:43 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:9235 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1750782AbWBMP5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:57:42 -0500
Message-ID: <43F0AC38.9090409@cfl.rr.com>
Date: Mon, 13 Feb 2006 10:56:40 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Nicolas George <nicolas.george@ens.fr>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem for mobile hard drive
References: <20060212150331.GA22442@clipper.ens.fr> <43EFD6E4.60601@cfl.rr.com> <20060213010701.GA8430@clipper.ens.fr> <43EFEE57.7070009@cfl.rr.com> <20060213103512.GA5157@clipper.ens.fr>
In-Reply-To: <20060213103512.GA5157@clipper.ens.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2006 15:58:29.0532 (UTC) FILETIME=[5506ADC0:01C630B6]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14265.000
X-TM-AS-Result: No--20.600000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas George wrote:
> I use the french word octet instead of byte, because it is less error prone
> (when you read "mb", does-it really mean megabit, or does it mean that the
> author is lazy about capitalization?) and a little bit more precise. Tough I
> actually am French, I did not start using a French word in English by
> myself. I copy a practice of the IETF: the RFCs use octet more than byte.
>   

Ahh, I see.  I've never seen anyone use it in conjunction with an si 
prefix.  I also think that they use it in RFCs because at the time they 
started writing them, bytes were not always 8 bits on all machines.  
Today it is a pretty safe assumption that a byte is 8 bits, so most 
people use the two terms interchangeably ;)

As for 1000 vs 1024 powers, I personally use the general rule that B = 
bytes and is in powers of 1024, and b = bits, and is in powers of 1000.  
For some reason the telecom industry likes to talk in terms of 1000 bits 
per second, but the rest of the sane world uses bytes in even powers of 
two.  Generally it's people trying to sell you something that use powers 
of 1000 so they can make it sound bigger.  I really hate that. 

> That is a very good point. If windows can read UDF on hard drives and not
> only DVD, UDF could probably supersede FAT completely.
>
> Thank you for pointing me that direction.
>
>   

I had that same thought a few weeks ago so I gave it a try.  I formatted 
a partition with UDF, put some files on it, then booted windows to see 
if it would take it.  It didn't :(

> I have a Solaris 9 near at hand, and I see a /lib/fs/udfs/fsck, and in the
> source tarball of OpenSolaris, I find a directory
> usr/src/cmd/fs.d/udfs/fsck/. It does not compile out of the box, but it may
> be possible to port it with limited effort.
>
>   

Hrm... interesting, I wonder how complete it is and what it's license 
is?  The fsck in the udftools package was never actually implemented 
unfortunately.

>> I agree.  I think the VFS layer should process the uid/gid options.  By 
>> default it should replace nobody with the specified id, and fat and ntfs 
>> should just report all files as owned by nobody.  Then a new option 
>> should be added to force the translation for all ids, not just nobody.
>>     
>
> I agree with that (except maybe for the NTFS part, which I do not know; let
> us just say "UID-less filesystems"). Maybe a full UID translation system
> similar th the one in NFS could be useful, or a generic hook for modules,
> but having basic UID overriding would be great.
>
> Unfortunately, the VFS subsystem is something too complex for me at this
> time.
>   

