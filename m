Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbVHKMry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbVHKMry (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 08:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVHKMry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 08:47:54 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:24590 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932398AbVHKMrx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 08:47:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <42FB435E.2070607@effigent.net>
References: <42FB435E.2070607@effigent.net>
X-OriginalArrivalTime: 11 Aug 2005 12:47:51.0050 (UTC) FILETIME=[E25356A0:01C59E72]
Content-class: urn:content-classes:message
Subject: Re: __init()
Date: Thu, 11 Aug 2005 08:47:38 -0400
Message-ID: <Pine.LNX.4.61.0508110835480.14365@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: __init()
Thread-Index: AcWecuJwsDgZBPeeQl6BhLVBzXvwPQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "raja" <vnagaraju@effigent.net>
Cc: <linux-c-programming@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 Aug 2005, raja wrote:

> Hi,
>     Is there any way to execute my own __init() instead of default
> __init() while running an executable.
> -

Sure you link your object file with your own instead of using
the default....

     gcc -c -o myprog.o myprog.c
     as -o start.o start.S

     ld -o myprog myprog.o start.o /lib/libc.so.6
                         |       |              |___ runtime lib
                         |       |__________________ Your startup
                         |__________________________ Your program

Startup starts with a label _start. You may have to write it
in assembly. It calls main() and must never return. Instead
it calls exit() with whatever main() returned, to quit.

__init() is some M$ thing. Linux executables start with
_start().

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
