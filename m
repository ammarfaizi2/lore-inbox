Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWBFWiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWBFWiM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWBFWiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:38:12 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:13698 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S932400AbWBFWiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:38:11 -0500
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: network delays, mysterious push packets
From: David Carlton <david.carlton@sun.com>
Date: Mon, 06 Feb 2006 14:38:10 -0800
Message-ID: <yf2k6c8ru3x.fsf@kealia.sfbay.sun.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on an application that we're trying to switch from a 2.4
kernel to a 2.6 kernel.  (I believe we're using 2.6.9.)  One part of
the program periodically sends out chunks of data (whose size is just
over 1MB) via tcp.

Frequently, alas, these chunks aren't arriving in a timely fashion.
Instrumenting the code and doing a tcpdump, this is what we see:

1) The sender uses sendmsg() to send all the data.  (In chunks of a
   little less than 1.5K, in case it matters.)

2) Most of the data arrives in a timely fashion.  There are a few
   dropped packets that have to get retransmitted; no big deal.  (I
   assume this step overlaps somewhat with step 1; also, sometimes all
   the data makes it, so we don't progress to step 3.)

3) Occasionally, at some point, the transmission slows way down: the
   sender sends out bits of data (1 or 2 Ethernet frames, I can't
   remember) spaced 200ms apart, each marked with PUSH.

I don't understand why they'd be marked with push: by this time, all
the sendmsg calls have returned, so the sender's kernel should have
all the data, so there should only be one transmission marked with
push.  But I'm seeing lots of them.  Which I wouldn't mind so much,
but the 200ms gaps are killing us.

Does this ring any bells?  This 200 millisecond gap + PUSH behavior
seems very odd, so I'm hoping that somebody's seen a misconfiguration
or kernel bug causing these particular symptoms.

Thanks for any suggestions that anybody has.

(I'm not subscribed to the lists, so please Cc: me on any responses.
Also, my apologies for the crosspost - the linux-net archives were
relatively bare and spam-filled, so it wasn't clear to me whether or
not that list was still active.)

David Carlton
david.carlton@sun.com
