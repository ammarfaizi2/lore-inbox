Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbVK1TNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVK1TNO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 14:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVK1TNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 14:13:14 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:37264 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932190AbVK1TNN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 14:13:13 -0500
Message-ID: <4384BE3A.6060505@tmr.com>
Date: Wed, 23 Nov 2005 14:08:42 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Ashutosh Naik <ashutosh.lkml@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Over-riding symbols in the Kernel causes Kernel Panic
References: <c216304e0511230610x2b983e59h42c10517acd59e63@mail.gmail.com>	 <4384AAED.3070804@tmr.com> <9a8748490511231004l36edcf57mf0fb63c4a9e17f49@mail.gmail.com>
In-Reply-To: <9a8748490511231004l36edcf57mf0fb63c4a9e17f49@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 11/23/05, Bill Davidsen <davidsen@tmr.com> wrote:
> 
>>Ashutosh Naik wrote:
>>
>>>Hi,
>>>
>>>I made e1000 ( or for that matter anything) a part of the 2.6.15-rc1
>>>kernel and booted the kernel. Next I compiled e1000 as a module (
>>>e1000.ko ), and tried to insmod it into the kernel( which already had
>>>e1000 a compiled as a part of the kernel). I observed that
>>>/proc/kallsyms contained two copies of all the symbols exported by
>>>e1000, and I also got a Kernel Panic on the way.
>>>
>>>Is this behaviour natural and desirable ?
>>
>>No, trying to insert a module into a kernel built with the functionality
>>compiled in is a vile perverted act, and probably illegal in Republican
>>states! ;-)
>>
>>The other day I mentioned that reiser4 will find bugs because people
>>will do bizarre things with it when it is more widely used. I think you
>>have hit a "no one would ever do that" bug in the module loader, and
>>demonstrated my point in the process.
>>
>>The panic isn't desirable, but I'm not sure what "correct behaviour"
>>would be, I can't imagine that this is intended to work. The issues of
>>removing such a module gracefully are significant.
> 
> 
> Wouldn't the desired behaviour be that when the kernel attempts to
> load a module it checks if it is already present build-in and if so
> simply refuse to load it at all?

It doesn't look to be quite as easy to check for built-in as to check 
for "already loaded" without some global state tracking, and handling 
the case where it just wasn't built at all, and may have other stuff 
missing. Add to this not breaking existing out of tree code and the 
implementation looks like a non-trivial exercise.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

