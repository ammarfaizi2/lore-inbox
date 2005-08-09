Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVHIOqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVHIOqL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 10:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbVHIOqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 10:46:09 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:14859 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964798AbVHIOqF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 10:46:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <42F8B5EC.2090204@berkeleydata.net>
References: <42F8B5EC.2090204@berkeleydata.net>
X-OriginalArrivalTime: 09 Aug 2005 14:46:03.0618 (UTC) FILETIME=[10FFD420:01C59CF1]
Content-class: urn:content-classes:message
Subject: Re: datagram queue length
Date: Tue, 9 Aug 2005 10:45:58 -0400
Message-ID: <Pine.LNX.4.61.0508091037180.26280@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: datagram queue length
Thread-Index: AcWc8REHmh880yFSSUuJokaxyQXh7w==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jonathan Ellis" <jonathan@berkeleydata.net>
Cc: <linux-net@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Aug 2005, Jonathan Ellis wrote:

> (Posted a few days ago to c.os.l.networking; no replies there.)
>
> I seem to be running into a limit of 64 queued datagrams.  This isn't a
> data buffer size; varying the size of the datagram makes no difference
> in the observed queue size.  If more datagrams are sent before some are
> read, they are silently dropped.  (By "silently," I mean, "tcpdump
> doesn't record these as dropped packets.")
>
> This only happens when the sending and receiving processes are on
> different machines, btw.
>
> Can anyone tell me where this magic 64 number comes from, so I can
> increase it?
>
> Python demo attached.
>
> -Jonathan
>

Your datagram receiver isn't keeping up with your datagram
transmitter. If you increase the number of datagrams that are
being queued, you will still encounter the same problem, but
after more datagrams are stored. You need to either throttle
the transmitter or speed up the receiver.

In your test code, you deliberately don't receive anything
for 5 seconds. What do you expect? You are lucky you get
one datagram!


> # <receive udp requests>
> # start this, then immediately start the other
> # _on another machine_
> import socket, time
>
> sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
> sock.bind(('', 3001))
>
> time.sleep(5)
>
> while True:
>     data, client_addr = sock.recvfrom(8192)
>     print data
>
> # <separate process to send stuff>
> import socket
>
> for i in range(200):
>     sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
>     sock.sendto('a' * 100, 0, ('***other machine ip***', 3001))
>     sock.close()
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
