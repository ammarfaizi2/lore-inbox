Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313421AbSDYVDB>; Thu, 25 Apr 2002 17:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313448AbSDYVDA>; Thu, 25 Apr 2002 17:03:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54029 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313421AbSDYVDA>; Thu, 25 Apr 2002 17:03:00 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
Date: Thu, 25 Apr 2002 21:02:35 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aa9qtb$d8a$1@penguin.transmeta.com>
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC7E358.8050905@evision-ventures.com> <20020425172508.GK3542@suse.de> <20020425173439.GM3542@suse.de>
X-Trace: palladium.transmeta.com 1019768564 3217 127.0.0.1 (25 Apr 2002 21:02:44 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 25 Apr 2002 21:02:44 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020425173439.GM3542@suse.de>, Jens Axboe  <axboe@suse.de> wrote:
>On Thu, Apr 25 2002, Jens Axboe wrote:
>> - Make the ata_request the general means of passing down request in the
>>   IDE layer -- start by making hwgroup->rq into hwgroup->ar and _never_
>>   store ar in ->special (you don't have to, you will always just go from
>>   ar -> rq, which is of course ar->ar_rq). This is what I wanted to do.
>
>I'll do this on monday, I'm away friday and through the weekend. Lets
>get this fixed _properly_.

The only _proper_ fix is to not abuse "special" at all. Mid-level layers
simpyl should not use it.

Please don't use "special" for mid-level things that clash like this. 
There are real reasons why Linux tries hard to avoid stupidly overloaded
"void *" things, and if IDE is to be cleaned up (which I sure hope), it
should NOT use "special" at all.

And it should _definitely_ not use it for multiple different things,
depending on what kind of disk it is.  Checking whether the target is a
disk or a CD is _absolutely_ the wrong thing to do, and will just make
the code continue the current mistake of now being able to integrate the
packet command stuff between them. 

Jens, please don't make it worse. Add a new field if you have to, with a
proper type, don't overload crap.

		Linus
