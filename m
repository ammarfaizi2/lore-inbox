Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWIMPdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWIMPdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 11:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWIMPdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 11:33:16 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:3343 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750945AbWIMPdP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 11:33:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 13 Sep 2006 15:33:12.0978 (UTC) FILETIME=[ECA9E720:01C6D749]
Content-class: urn:content-classes:message
Subject: Re: Error binding socket: address already in use
Date: Wed, 13 Sep 2006 11:33:12 -0400
Message-ID: <Pine.LNX.4.61.0609131130180.27566@chaos.analogic.com>
In-Reply-To: <1GNVuW-02KMfw0@fwd29.sul.t-online.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Error binding socket: address already in use
thread-index: AcbXSezSni3NkGbJQhOsqJiiYSnJow==
References: <1GNVuW-02KMfw0@fwd29.sul.t-online.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Peter Lezoch" <pledr@t-online.de>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Sep 2006, Peter Lezoch wrote:

>
> Hi,
> killing a server task that is operating on a UDP socket( AF_INET, SOCK_DGRAM, IPPROTO_UDP ), leaves the socket in an unclosed state. A subsequently started task, that wants to use the same port, gets from bind above error message.This is, in my opinion, wrong behavior, because of the connectionless nature of UDP. Only reboot solves this situation. It looks, as if in net/socket.c, TCP and UDP are handled in the same way without taking into account the different nature of the protocols?!
> How can I overcome this problem ?
>
> kind regards
>
> peter lezoch


Try:
  int opt = 1;
  setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.66 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
