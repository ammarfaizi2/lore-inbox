Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291559AbSBMLMZ>; Wed, 13 Feb 2002 06:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291562AbSBMLMG>; Wed, 13 Feb 2002 06:12:06 -0500
Received: from [195.63.194.11] ([195.63.194.11]:38662 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291559AbSBMLMB>; Wed, 13 Feb 2002 06:12:01 -0500
Message-ID: <3C6A49F1.5000500@evision-ventures.com>
Date: Wed, 13 Feb 2002 12:11:45 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Andre Hedrick <andre@linuxdiskcert.org>, Vojtech Pavlik <vojtech@suse.cz>,
        Jens Axboe <axboe@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <3C6A418A.8040105@evision-ventures.com> <Pine.LNX.4.10.10202130228180.1479-100000@master.linux-ide.org> <20020213105625.GI32687@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>>>Well, after looking at yours code close engough I have one advice for 
>>>you as well: LEARN C.
>>>
>>I specialize in storage, and C is self taught.
>>
>
>Okay, few things to keep in mind:
>
>*) cut-copy-paste is bad. If you fix error in one copy, it is _very_
>easy not to fix it in other copies.
>
>*) void *'s and casts are bad. They hide real errors. If you have 
>
>struct foo {} bar;
>
>and want 
>
>bar * baz;
>
>later;
>
>You can write it as struct foo * baz. That will make type checks
>actually work and save you lot of casts. 
>
>*) hungarian notation is considered evil in kernel.
>
>struct bla_s {} bla_t;
>
>*is* evil -- why have two types when one is enough? In kernel land,
>right way is to do 
>
>struct bla {};
>
>and then use "struct bla" everywhere you'd use bla_t. It might be
>slightly longer, but it helps you with casts (above) and everyone can
>see what is going on.
>

Add the following:
Silly code like that:

      ide_add_setting(drive,  "bios_cyl",             
SETTING_RW,            
        ide_add_setting(drive,  "bios_sect",            
SETTING_RW,            
        ide_add_setting(drive,  "bswap",                
SETTING_READ,          
        ide_add_setting(drive,  "multcount",            id ? SETTING_RW 
: SETTIN

Can be replaced with somthing along:

struct resource_record {
} rr = {
  { asjdkasdh, asdjhasjkd, asdjhjaskd }
....
 { asdjaksd, adsjaksd, asdhjasdhasd }
}


....


for (i; i < nuofmemebers(rr); ++i )
{
    ide_add_setting(rr[i]);
}

to save you *a lot* of push stack call function and so on...




