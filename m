Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265476AbUFWP6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265476AbUFWP6T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 11:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265930AbUFWP6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 11:58:18 -0400
Received: from imap.gmx.net ([213.165.64.20]:57514 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265476AbUFWP55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 11:57:57 -0400
X-Authenticated: #21910825
Message-ID: <40D9A857.5040901@gmx.net>
Date: Wed, 23 Jun 2004 17:57:11 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: Kalin KOZHUHAROV <kalin@ThinRope.net>
CC: Mikael Bouillot <xaajimri@corbac.com>, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>,
       Brian Lazara <blazara@nvidia.com>
Subject: Re: Forcedeth driver bug
References: <20040623142936.GA10440@mail.nute.net> <40D99A08.90707@ThinRope.net>
In-Reply-To: <40D99A08.90707@ThinRope.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalin KOZHUHAROV wrote:
> Mikael Bouillot wrote:
> 
>>   Hi all,
>>
>>   I'm having trouble with the forcedeth driver in kernel version 2.6.7.
>>
>>> From what I can see, it seems that incoming packets sometime get stuck
>>
>> on their way in.
>>
>>   What happens is this: some packet enters the NIC, and for some reason,
>> it doesn't come out of the driver. As soon as another incoming packet
>> gets in, both packets are handed down by the driver.
>>
>>   It is usually invisible during normal TCP operation, as there are
>> several packets in flight and the stuck packet gets pushed down by the
>> one following it very soon. But for lockstep protocols like SMB, it very
>> annoying as it means you get "blanks" of 2 to 5 seconds during the
>> transfer.
>>
>>   I can reproduce this very easily with a modified version of ping. I
>> do a flood ping from another machine to the one with the nvnet NIC, but
>> I modified ping to send a new packet if one gets "lost" only 10 seconds
>> later instead of after 10 ms. The result is that after a couple hundred
>> ping-pong at full speed, one ping gets stuck. After 10 seconds, another
>> ping is sent and both pong come back.

Are you sure both come back? If so, what does dmesg say during this time?
Is the system in question under heavy load?

Can you confirm that the ping packet got stuck in the receive path or
could the associated pong reply have gotten stuck in the send path?


>>   This didn't happen with the proprietary nvnet driver on kernel 2.4.24.
>> My hardware is a nForce 2 mobo (in a shuttle SN45G barebones).
>>
>>   Is this a know bug? If someone working on it already or should I
>> investigate the matter further? Please CC any reply to me as I'm not on
>> the list.

It could be a weird interaction with interrupt mitigation, but I doubt it.
Nobody has ever mailed me about such problems with the driver.


> Search http://groups.google.com/ or somewhere else in LKML for "new
> device support for forcedeth.c"
> 
> Try the latest patch ( forcedeth_gigabit_try17.txt was the one I tested
> last) and report back.
> The driver has undergone quite a lot of patching lately.
> AFAIR, while testing it, similar effect was observed, but the it was way
> broken anyway.

forcedeth_gigabit_try19.txt is the most recent one.
Changes against try17:
- fix compilation warnings and rename the Kconfig entry

Get it at
http://www.hailfinger.org/carldani/linux/patches/forcedeth/
and please report if it fixes your problem.

Regards,
Carl-Daniel
