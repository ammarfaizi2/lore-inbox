Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267651AbTAXNcp>; Fri, 24 Jan 2003 08:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267652AbTAXNcp>; Fri, 24 Jan 2003 08:32:45 -0500
Received: from c24.159.193.39.roc.mn.charter.com ([24.159.193.39]:12960 "HELO
	rochester1.roc.mn.charter.com") by vger.kernel.org with SMTP
	id <S267651AbTAXNco>; Fri, 24 Jan 2003 08:32:44 -0500
Message-ID: <3E314224.3030405@charter.net>
Date: Fri, 24 Jan 2003 07:39:48 -0600
From: Brian King <brking@charter.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Stevenson <james@stev.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: OOPS in idescsi_end_request
References: <E18bxDI-000Ic3-00@f15.mail.ru> <00b601c2c387$ebc51c00$0cfea8c0@ezdsp.com>
In-Reply-To: <00b601c2c387$ebc51c00$0cfea8c0@ezdsp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Stevenson wrote:
> [LARGE SNIP]
> 
> 
>>Would you agree to test the patch (possibly next week).
> 
> 
> yeah sure.
> 


I would be happy to test it as well.

-Brian

> 
> 
>>cheers
>>
>>-andrey
>>
>>
>>>>If you can reliably reproduce the problem you could give it a try.
>>>>
>>>>Anybody sees yet another race condition here? :))
>>>>
>>>>-andrey
>>>>
>>>>
>>>>
>>>>>While burning a CD tonight I ended up taking an oops on my system. I
> 
> had
> 
>>>>>the lkcd patch applied to my 2.4.19 kernel, so I was able to look at
> 
> the
> 
>>>>> oops after my system rebooted. After digging into it a little and
>>>>>looking at the ide-scsi code I think I found the problem but am not
>>>>>sure. How can idescsi_reset simply return SCSI_RESET_SUCCESS to the
> 
> scsi
> 
>>>>>mid layer? I think what is happening is that a command times out,
>>>>>idescsi_abort is called, which returns SCSI_ABORT_SNOOZE. Later on
>>>>>idescsi_reset gets called, which returns SCSI_RESET_SUCCESS. At this
>>>>>point the scsi mid-layer owns the scsi_cmnd and returns the failure
> 
> back
> 
>>>>>up the chain. Later on, the command gets run through
>>>>>idescsi_end_request, which then tries to access the scsi_cmnd
> 
> structure
> 
>>>>>which is it no longer owns.
>>>>>
>>>>>Any help is appreciated. I have a complete lkcd dump of the failure if
>>>>>anyone would like more information...
>>>>>
> 
> 
> 
> 


-- 
Some days it's just not worth chewing through the restraints...

