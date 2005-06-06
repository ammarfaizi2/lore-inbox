Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVFFOM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVFFOM1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 10:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVFFOM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 10:12:26 -0400
Received: from anubis.fi.muni.cz ([147.251.54.96]:26640 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S261462AbVFFOMH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 10:12:07 -0400
Date: Mon, 6 Jun 2005 16:12:14 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Sk98Lin driver
Message-ID: <20050606141214.GA2837@mail.muni.cz>
References: <20050606131425.GF18862@mail.muni.cz> <20050606132841.GA10486@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050606132841.GA10486@infradead.org>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 02:28:42PM +0100, Christoph Hellwig wrote:
> Can you give the skge driver that obsoletes sk98lin in -mm?
> 
> (insert rant here why it's still not in mainline)

Slightly better but still not good enough.

Using my testing application it reports about 10 errors/sec (frame). 

Using iperf:
iperf -s -u -w 16m
------------------------------------------------------------
Server listening on UDP port 5001
Receiving 1470 byte datagrams
UDP buffer size: 16.0 MByte
------------------------------------------------------------
[  5] local 147.251.54.96 port 5001 connected with 147.251.54.34 port 32915
[  5]  0.0-10.3 sec    614 MBytes    502 Mbits/sec  15.220 ms 376630/814324 (46%)
[  5]  0.0-10.3 sec  1 datagrams received out-of-order

it is 46% packet loss but no errors on interface.

(peer is dual opteron box, my box is Pentium-M 1.6GHz, 512MB RAM).

Sending to peer using iperf:
iperf -s -u -w 16m
------------------------------------------------------------
Server listening on UDP port 5001
Receiving 1470 byte datagrams
UDP buffer size: 16.0 MByte
------------------------------------------------------------
[  3] local 147.251.54.34 port 5001 connected with 147.251.54.96 port 1024
[  3]  0.0-10.0 sec    836 MBytes    700 Mbits/sec  0.013 ms 290722/886955 (33%)
[  3]  0.0-10.0 sec  1 datagrams received out-of-order

This second case is a lot better than original driver from syskonnect which
flooded outgoing interface at rate 500Mbps and no more packets were transmitted.

Boxes are interconnected using GE switch which can handle about 920Mbps between
two dual operon boxes.

-- 
Luká¹ Hejtmánek
