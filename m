Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbVK3F2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVK3F2d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 00:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbVK3F2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 00:28:33 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:29829 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1750999AbVK3F2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 00:28:33 -0500
Message-ID: <438D38B3.2050306@m1k.net>
Date: Wed, 30 Nov 2005 00:29:23 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org, Kirk Lapray <kirk.lapray@gmail.com>,
       video4linux-list@redhat.com, CityK <CityK@rogers.com>,
       Perry Gilfillan <perrye@linuxmail.org>, Don Koch <aardvark@krl.com>
Subject: Re: Gene's pcHDTV 3000 analog problem
References: <200511282205.jASM5YUI018061@p-chan.krl.com> <c35b44d70511291548lcb10361ifd3a4ea0f239662d@mail.gmail.com> <438CFFAD.7070803@m1k.net> <200511300007.56004.gene.heskett@verizon.net>
In-Reply-To: <200511300007.56004.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>On Tuesday 29 November 2005 20:26, Michael Krufky wrote:
>
>[...]
>
>>ll I can think of doing next is to have Gene, Don or Perry do a
>>bisection test on our cvs repo.... checking out different cvs revisions
>>until we can narrow it down to the day the problem patch was applied.
>>
>>::sigh::
>>    
>>
>A sigh?  More like an 'oh fudge' or whatever your fav expletive deleted
>is...
>
>>Who wants to do it?  I'll give you detailed instructions if you're
>>willing.
>>    
>>
>Can you farm it out, one set of patches to each of us?  Or do you want
>to setup a seperate cvs tree based on the v4l code in 2.6.14.3, and
>incrementally patch it as we each report its still ok, until it breaks
>again?  I think I'd prefer the latter so we are all near the same
>page even if it takes 3x longer to arrive at the answer.  How many
>actual patches in terms of dependency groups are there?  I know, I
>coulda went all week without asking that :(
>
Actually, cvs has a parameter that lets you specify cutoff dates...

This is what I am suggesting that you do... Base this on my previous cvs 
instructions....

reminder: http://linuxtv.org/v4lwiki/index.php/How_to_build_from_CVS

so....

1st:

cvs -d :pserver:anonymous@cvs.linuxtv.org:/cvs/video4linux login
cvs -d :pserver:anonymous@cvs.linuxtv.org:/cvs/video4linux co v4l-dvb
cd v4l-dvb
make clean
make
make install

test

(you already did this - you said doesnt work)

Now, try again, using last month's code:

cvs up -D 2005-11-01
make clean
make
make install

did it work?  yes?  ok, so try two weeks later:

cvs up -D 2005-11-15
make clean
make
make install

... or no it didnt?  then another month earlier:

cvs up -D 2005-10-01
make clean
make
make install

works now?  try two weeks later:

cvs up -D 2005-10-15
make clean
make
make install

doesnt work?  1 week earlier:

cvs up -D 2005-10-07
make clean
make
make install

doesnt work?  1 day earlier:

cvs up -D 2005-10-06
make clean
make
make install

it works?  hmm... problem patch must have been committed between 10-06 
and 10-07

At that point, just give me the date and it will probably be easy to 
narrow it down, or then again, you can use time of day in the -D 
parameter too... (see man cvs)

anyway, you get the picture...  This is an adaptation for cvs based on 
Linus' description of the git bisection testing, and I'm sure that there 
are more efficient ways of doing it, but this should work.

Cheers,

Mike
