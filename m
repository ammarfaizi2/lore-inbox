Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265100AbUGMNZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbUGMNZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 09:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265133AbUGMNZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 09:25:29 -0400
Received: from dns.gardena.net ([213.21.177.18]:1412 "HELO dns.gardena.net")
	by vger.kernel.org with SMTP id S265100AbUGMNZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 09:25:04 -0400
Message-ID: <40F3E31D.9020504@gardena.net>
Date: Tue, 13 Jul 2004 15:26:53 +0200
From: Benno Senoner <sbenno@gardena.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>
CC: Andrew Morton <akpm@osdl.org>, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel	Preemption
 Patch
References: <20040709182638.GA11310@elte.hu>	<20040710222510.0593f4a4.akpm@osdl.org>	<1089673014.10777.42.camel@mindpipe>	<20040712163141.31ef1ad6.akpm@osdl.org> <1089677823.10777.64.camel@mindpipe>
In-Reply-To: <1089677823.10777.64.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Mon, 2004-07-12 at 19:31, Andrew Morton wrote:
>  
>
>>
>>OK, thanks.  The problem areas there are the timer-based route cache
>>flushing and reiserfs.
>>
>>We can probably fix the route caceh thing by rescheduling the timer after
>>having handled 1000 routes or whatever, although I do wonder if this is a
>>thing we really need to bother about - what else was that machine up to?
>>
>>    
>>
>
>Gnutella client.  Forgot about that.  I agree, it is not reasonable to
>expect low latency with this kind of network traffic happening.  I am
>impressed it worked as well as it did.
>  
>

Why not reasonable ? It is very important that networking and HD I/O 
both don't interfere with low latency audio.
Think about large audio setups where you use PC hardware to act as 
dedicated samplers, software synthesizers etc.
Such clusters might be diskless and communicate with a GBit ethernet 
with a high performance file server and
in some cases lots of network I/O might occur during audio playback. So 
having latency spikes during network I/O
would be a big showstopper for many apps in certain setups.
Even ardour if run on a diskless client would need low latency while 
doing network I/O because it does lots of disk I/O
which on the diskless client translate to lots of network I/O.
Typical use could be educational or research institutions where diskless 
clients drastically lower the cost of managing large number
of boxes and allow sharing of resources. See the LTSP project.

Other low latency while high network I/O uses are video conferencing 
applications, diskless settop boxes that stream
videos over IP etc.

Therefore low level network kernel develeopers think about us poor real 
time multimedia souls :)

cheers,
Benno
http://www.linuxsampler.org


