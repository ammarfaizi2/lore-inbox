Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbTJNHE3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 03:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTJNHE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 03:04:29 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:46261 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262106AbTJNHEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 03:04:25 -0400
Message-ID: <3F8BA037.9000705@sbcglobal.net>
Date: Tue, 14 Oct 2003 02:05:27 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.5) Gecko/20031008
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: Norman Diamond <ndiamond@wta.att.ne.jp>, John Bradford <john@grabjohn.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Why are bad disk sectors numbered strangely, and what happens
 to them?
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl>
In-Reply-To: <20031014064925.GA12342@bitwizard.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rogier Wolff wrote:

>On Mon, Oct 13, 2003 at 07:24:00PM +0900, Norman Diamond wrote:
>  
>
>>John Bradford replied to me:
>>
>>    
>>
>>>>How can I tell Linux to read every sector in the partition?  Oh, I might
>>>>know this one,
>>>>  dd if=/dev/hda8 of=/dev/null
>>>>I want to make sure that the drive is now using a non-defective
>>>>replacement sector.
>>>>        
>>>>
>>>A read won't necessarily do that.  You might have to write to a
>>>defective sector to force re-allocation.
>>>      
>>>
>>I agree, we are not sure if a read will do that.  That is the reason why two
>>of my preceding questions were:
>>    
>>
>
>I've seen a disk (which now failed and will be replaced 3 hours from now)
>remap defective sectors without reporting any errors to the OS. 
>The SMART "remapped sector count" just went up, but no errors in the
>logs. So apparently, the disk noticed something and remapped teh sector
>without anybody noticing. 
>  
>
Can't you pretty much get the drive to check itself using smartctl, such 
as running:
     smartctl -o on -s on -S on /dev/hde &> /dev/null
in an init script?  Also, I think if you just happen to write to a bad 
sector the drive will remap it without a warning (unless it doesn't have 
any remapping sectors left), but if you read from it then to get the 
drive to "notice" it, you have to write back to that sector.  Or run the 
drive test which should find it and correct it.

>  
>
>>   How can I find out which file contains the bad sector?  I would like to
>>   try to recreate the file from a source of good data.
>>    
>>
>
>Try: 
>	tar cf - / | dd of=/dev/null
>
>(note some people will try to abbreviate that to 
>	tar cf /dev/null / 
>but that won't work: Tar will recognise that it's writing to /dev/null
>and skip reading the files! That's a bug in tar in my book. )
>
>  
>
>>   How can I tell Linux to mark the sector as bad, knowing the LBA sector
>>   number?
>>    
>>
>
>man tune2fs .
>
>You have to do the math on the LBA sector numbers (subtract the
>partition start, divide by two). 
>
>Also, you can use the "badblocks" program. 
>  
>
I think he's using reiserfs on the partition, which ASFAIK doesn't 
support marking bad sectors without some work.  I tend to agree with 
namesys when they suggest just getting a new drive if it has used up all 
of its extra sectors.  In my experience (admittedly limited), any drive 
which runs out of extra sectors starts to go bad in a hurry.

-Wes-

>			Roger. 
>  
>

