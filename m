Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281558AbRKZKFV>; Mon, 26 Nov 2001 05:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281556AbRKZKFM>; Mon, 26 Nov 2001 05:05:12 -0500
Received: from david.siemens.de ([192.35.17.14]:64199 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id <S281554AbRKZKFF>;
	Mon, 26 Nov 2001 05:05:05 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: rgooch@ras.ucalgary.ca, paul@paulbristow.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-floppy.c vs devfs
Date: Mon, 26 Nov 2001 13:04:50 +0300
Message-ID: <000301c17661$c9ff6db0$21c9ca95@mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Try the devfs test version that I just uploaded to 
>> 
>> http://paulbristow.net/linux/idefloppy.html 
>> 
>> This is early days, and I'm not sure what the best approach is... 
>> 
>> Feedback is greatly appreaciated. 
>

On this page you mention that Mandrake includes this patch, but your
driver (link on the above patch) differs from Mandrake one. In patch I
sent to Mandrake I just fake drive capacity in case
CAPACITY_NO_CARTRIDGE is returned.

>
> I haven't had time to look at this closely, but I question why you're 
> trying to prevent grok_partitions() from doing it's thing. There's 
> supposed to be a flag set for removable media which ensures media 
> revalidation on scanning the parent directory or looking up an entry. 
> I'd rather see that mechanism fixed. 

Currently grok_partitions() silently ignores any media with size == 0,
irrespectively of whether removable is set or not. It means that *no*
entries for drive (either disc or part?) are created at all and there is
nothing that later on triggers revalidation.

I still believe grok_partitions() should create disc node for removables
even if current capacity == 0 (that for removable just means there is no
media inserted). Then it would work the way you describe and faking
drive capacity for empty drives could be removed (IIRC it happens for
other removables like SCSI disks as well).


-andrej
