Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTFDGBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 02:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbTFDGBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 02:01:33 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:24038 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262945AbTFDGBb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 02:01:31 -0400
Message-ID: <3EDD8BD2.9040008@us.ibm.com>
Date: Tue, 03 Jun 2003 23:04:02 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: "David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
       jmorris@intercode.com.au, gandalf@wlug.westbo.se,
       linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org,
       netdev@oss.sgi.com, akpm@digeo.com
Subject: Re: fix TCP roundtrip time update code
References: <200306040043.EAA24505@dub.inr.ac.ru>	<3EDD52F5.8090706@us.ibm.com>	<20030603.202320.59680883.davem@redhat.com>	<16093.30507.661714.676184@napali.hpl.hp.com>	<3EDD7832.7010804@us.ibm.com> <16093.34022.445246.52398@napali.hpl.hp.com>
In-Reply-To: <16093.34022.445246.52398@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:

>  $ httperf --rate 1000 --num-conns 1000000 --verbose --hog --server HOST \
> 	--uri pathto30KBfile

Hmm, ditto, except I was way down at --rate 300 (was seeing client
errors of fd-unavail). Have ulimited upwards but am still seeing
them..

> on 3 clients (for a total of 3000 conns/sec).  You can't go higher
> than 1000 conn/sec per client (IP address) because otherwise you run
> out of port space (due to TIME_WAIT).

You can hike /proc/sys/net/ipv4/tcp_tw_recycle for that.

> This load worked well for a machine with a single GigE card.  All
> network tunables were on the default setting (in particular, the tx
> queue len was 300, which is were the losses came from).
> 
> With this load, I saw bad RTT values in the route cache within a
> couple of seconds after starting the third httperf generator.  It then
> took a bit longer (on the order of 1-2 minutes) until the first
> TCPAbortFailed errors started to pop up

I saw a few AbortOnTimeouts, but no AbortFailed counts.

Those should be TCPAbortOnTimeout counts, rather than TCPAbortFailed
errors, I would expect? Why AbortFailed?  Coming from IP via
tcp_transmit_skb()?

thanks,
Nivedita


