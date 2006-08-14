Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWHNV0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWHNV0b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWHNV0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:26:31 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:47297 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S964971AbWHNV0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:26:30 -0400
Message-ID: <44E0EA5E.30306@candelatech.com>
Date: Mon, 14 Aug 2006 14:25:50 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network compatibility and performance
References: <Pine.LNX.4.61.0608101131530.4239@chaos.analogic.com> <44DE2A44.5070006@candelatech.com> <Pine.LNX.4.61.0608140714170.20677@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0608140714170.20677@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:

> No it will return FAIL (-1) or an error and 0 (the bottom of the procedure)
> if the whole things went. It is mandatory that the whole thing goes
> so this procedure should handle any intermediate actions.

I see..I missed that part.

> Upon your advice, I may try to add select() although, on a write it
> seems to be putting in user-space something that used to be handled
> quite well in the kernel. I don't think the user should really care
> about the kernel internals, whether or not the kernel happens to have
> a buffer available.

Since you put it in non-blocking mode, you need the select() to throttle
unless you want to busy spin.  Whether you should have to actually put
in in non-blocking mode or not is a different question.

>>I have no idea why you need to add the MIN() logic..and that seems like
>>something that should not be required.
>>
> 
> It seems that some code 'thinks' that a large buffer of data is
> an error and won't even try to send some anymore.

I have seen a problem where I can repeatedly hang a TCP connection
when running at high speed.  The tx queue is full or mostly full, and
on the wire I only see 200kpps of duplicate acks.  Can't reproduce it
with anything other than my big complicated proprietary app, so it
remains unfixed.

I am not sure if this is related to what you see or not..but could you
check to see if there is lots of acks on the wire when this hang happens?

>>Even 112kbps sucks on a decent network.  What is the speed of your
>>network, what protocol are you using, if tcp, what is the latency
>>of your network?
>>
> 
> 
> The network is a single wire about 8 feet long, connecting Intel gigibit
> links on two identical computers (crossover cable). This link is TCP.
> For high-speed data, I use UDP and I get a higher throughput because
> there is no handshake. Thew latency is the latency of Linux. BTW, it's
> only a gigaBIT link, you can divide that by 8 for gigabytes. I don't
> know the actual bit-rate on the wires, if we assume 1GHz, the byte-rate
> is only 125,000 bytes per second. Being able to use 89.6 percent of
> that isn't bad at all.

You must be meaning to add a few more zeros to that number.  If you
are getting ~125,000,000 Bytes per second then you are doing OK.

Ben

