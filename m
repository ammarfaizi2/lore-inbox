Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274151AbRIXS4o>; Mon, 24 Sep 2001 14:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274155AbRIXS4d>; Mon, 24 Sep 2001 14:56:33 -0400
Received: from zeus.kernel.org ([204.152.189.113]:65438 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S274156AbRIXS4R>;
	Mon, 24 Sep 2001 14:56:17 -0400
Envelope-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Message-Id: <a05100301b7d52f49f7b6@[192.168.239.101]>
In-Reply-To: <20010924182948Z16175-2757+1593@humbolt.nl.linux.org>
In-Reply-To: <20010916204528.6fd48f5b.skraw@ithnet.com>
 <20010922105332Z16449-2757+1233@humbolt.nl.linux.org>
 <6514162334.20010924123631@port.imtp.ilyichevsk.odessa.ua>
 <20010924182948Z16175-2757+1593@humbolt.nl.linux.org>
Date: Mon, 24 Sep 2001 19:46:38 +0100
To: Daniel Phillips <phillips@bonn-fries.net>,
        VDA <VDA@port.imtp.ilyichevsk.odessa.ua>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Linux VM design
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > DP> The arguments in support of aging over LRU that I'm aware of are:
>>
>>  DP>   - incrementing an age is more efficient than resetting several LRU
>>  DP>     list links
>>  DP>   - also captures some frequency-of-use information
>>
>>  Of what use this info can be? If one page is accessed 100 times/second
>>  and other one once in 10 seconds, they both have to stay in RAM.
>>  VM should take 'time since last access' into account whan deciding
>>  which page to swap out, not how often it was referenced.
>
>You might want to have a look at this:
>
>    http://archi.snu.ac.kr/jhkim/seminar/96-004.ps
>    (lrfu algorithm)
>
>To tell the truth, I don't really see why the frequency information is all
>that useful either.  Rik suggested it's good for streaming IO but we already
>have effective means of dealing with that that don't rely on any frequency
>information.
>
>So the list of reasons why aging is good is looking really short.

It's not really frequency information.  If a page is accessed 1000 
times during a single schedule cycle, that will count as a single 
increment in the age come the time.  However, *macro* frequency 
information of this type *is* useful in the case where thrashing is 
taking place.  You want to swap out the page that is accessed only 
once every other schedule cycle, before the one accessed every cycle. 
This is of course moot if one process is being suspended (as it 
probably should), but the criteria for suspension might include this 
access information.

-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.
