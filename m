Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269421AbRGaTEx>; Tue, 31 Jul 2001 15:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269415AbRGaTEn>; Tue, 31 Jul 2001 15:04:43 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:48401 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S269410AbRGaTEf>;
	Tue, 31 Jul 2001 15:04:35 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107311904.XAA10312@ms2.inr.ac.ru>
Subject: Re: missing icmp errors for udp packets
To: therapy@endorphin.org (clemens)
Date: Tue, 31 Jul 2001 23:04:06 +0400 (MSK DST)
Cc: pekkas@netcore.fi, therapy@endorphin.org, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <20010731205101.B8211@ghanima.endorphin.org> from "clemens" at Jul 31, 1 08:51:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> your patch will not prevent the first ping to empty the token bucket,
> because burst is still 0, which is larger than dst->rate_token, and since
> XRLIM_BURST_FACTOR times the timeout (which is 6*0=0 in that case) is the
> token maximum, it will be truncated to 0,
> causing the following packets (if in time) to be dropped.

Argh... I see, gap is too short and not enough of tokens are accumulated.
Thank you.

Damn, I see two ways: 1. to make sysctl active function
and recalculate max/sum of rates over classes and fill bucket.

Or to remove limiting distinguishing types, which is ideal
logically.

Alexey
