Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWGELyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWGELyG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 07:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWGELyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 07:54:06 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:35600 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964830AbWGELyE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 07:54:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 05 Jul 2006 11:54:02.0642 (UTC) FILETIME=[B5895F20:01C6A029]
Content-class: urn:content-classes:message
Subject: Re: possible dos / wsize affected frozen connection length (was: Re: 2.6.17.1: fails to fully get webpage)
Date: Wed, 5 Jul 2006 07:54:01 -0400
Message-ID: <Pine.LNX.4.61.0607050743470.30694@chaos.analogic.com>
In-Reply-To: <20060705005540.GL2344@zip.com.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: possible dos / wsize affected frozen connection length (was: Re: 2.6.17.1: fails to fully get webpage)
thread-index: AcagKbWQxwjn7oSrSR2vTD4bwTwYBQ==
References: <20060629015915.GH2149@zip.com.au> <20060628.194627.74748190.davem@davemloft.net> <20060629030923.GI2149@zip.com.au> <20060628.204709.41634813.davem@davemloft.net> <20060629041827.GJ2149@zip.com.au> <44A3E898.1020202@tmr.com> <20060629225039.GO2149@zip.com.au> <20060705005540.GL2344@zip.com.au>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "CaT" <cat@zip.com.au>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Jul 2006, CaT wrote:

> On Fri, Jun 30, 2006 at 08:50:39AM +1000, CaT wrote:
>> Another datapoint to this is that I've had this my netcat web test
>> running since 8:42pm yesterday. It's 8:37am now. It hasn't progressed
>> in any way. It hasn't quit. It hasn't timed out. It just sits there,
>> hung. This leads me to consider the possibility of a DOS, either
>> intentional or accidental (think about 2.6.17.x running on a mail server
>> and someone mails/spams from a broken place).
>
> I'm just wondering if connections hanging around this long are normal.
> The above has now been running for 6 days. netstat is still reporting an
> established session. netcat has not timed out. It's all just sitting
> there doing nothing.
>
> --
>    "To the extent that we overreact, we proffer the terrorists the
>    greatest tribute."
>    	- High Court Judge Michael Kirby

TCP/IP connections can continue forever. That's one of the reasons why
Berkeley sockets has SO_KEEPALIVE for a socket option. In the absence
of such an option, the physical connection can be broken for a week,
reconnected, then the session can continue.

In your case, you probably have a real error in which one end of the
connection crashed. However, until the other end shuts down that
socket, the connection is logically correct and should not be
forcefully terminated.

A DOS is unlikely because with no data being transferred, little
non-swapable resources are used. You can control the maximum number
of connections allowed from a host with your firewall software
(like iptables).

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.86 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
