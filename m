Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313313AbSDLM5z>; Fri, 12 Apr 2002 08:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313566AbSDLM5y>; Fri, 12 Apr 2002 08:57:54 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25349 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313313AbSDLM5w>; Fri, 12 Apr 2002 08:57:52 -0400
Message-ID: <3CB6CB47.8090409@evision-ventures.com>
Date: Fri, 12 Apr 2002 13:55:51 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][CFT] IDE TCQ #3 for 2.5.8-pre3
In-Reply-To: <20020412114745.GE5285@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Hi,
> 
> The third version is ready, lots of changes since last version.
> 
> General IDE changes (not directly related to TCQ)
> 
> - ata_request_t -> struct ata_request (was actually done before Martin
>   posted his first merge, better conform to current ide style)

Well I don't do much things for no reasons. So please allow me to
write down my reasoning. My general coding style guidiance is the following:

1. First and for most: NO INVENTION FOR THE SAKE OF IT.

typedef on a struct is  most of the time just adding syntactical shugar,
and  *deleting* the information that we deal with a struct in case of it's
usage.

This is the kind of code obfuscation which I *hate* even more in C++ or Java.

Many programming language "designers" out there think that making data types
look opaque in usage is a nice thing and a sign of good taste/style. Trust me
they are misguided (read: *idiots*). It is taking valuable information
away (well actually hiding it elswere) for the person looking at the
functional code. I mean the preson looking at the fsck-ing procedural
code which actually *does something*...

2. typedefs for function signature capturing are fine, since there is no other
way to express them sanely.

This is what they where inventid for - just as back doors for things
which couldn't be expressed otherwise. But avoid them where possible,
due to the same reasons as above.

3. typedefs for variable integral entities, which serve a dedicated
puspose are fine, since they:

- Acutally add information to the code where they are used.

- Don't obfuscate the structure of the object in question if you follow rules
1. and 2.

- Allow for differentiation where there are portability issues. size_t is one 
example of justified proper usage in this context.

