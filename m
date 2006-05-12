Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWELMSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWELMSe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 08:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWELMSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 08:18:34 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:46098 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751262AbWELMSe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 08:18:34 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 12 May 2006 12:18:32.0038 (UTC) FILETIME=[2F0EE860:01C675BE]
Content-class: urn:content-classes:message
Subject: Re: Kernel network layer breakes recv_from() as the server (i think) (kernel-bug)
Date: Fri, 12 May 2006 08:18:31 -0400
Message-ID: <Pine.LNX.4.61.0605120805480.8766@chaos.analogic.com>
In-Reply-To: <44645908.3000109@mallorn.ii.uj.edu.pl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel network layer breakes recv_from() as the server (i think) (kernel-bug)
Thread-Index: AcZ1vi8YDK+hqt3rSjKzrec/gDbhmA==
References: <44645908.3000109@mallorn.ii.uj.edu.pl>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: =?iso-8859-2?Q?Pawe=B3_Jaworski?= <paweusz@mallorn.ii.uj.edu.pl>
Cc: "i am totally stumped" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 May 2006, [iso-8859-2] Pawe³ Jaworski wrote:

> $ brief-problem
> Kernel network layer breakes recv_from() as the server (i think)
>
> $ full-problem
> I am student of Jagiellonian University of Cracow. Recently I've been trying to
> write some network programs as a learning of network protocols. Everything went
> fine except for UDP. I was trying to send a structure through the UDP protocol
> to the server. Every time I was sending a packet, recv_from() returned "Invalid
> argument". As it was my homework, i brought the program to my teacher, but... it
> worked well on systems in my school.
>
> 1. It worked on Linux Mandrake (i think) 10
> 2. It worked on Debian Sarge with kernel-image-2.4.27-2-686-smp
> 3. It worked on Debian Sarge with kernel-image-2.6.8-2
> 4. It worked on IRIX (i know it's not Linux, but... it worked)
>

Not relevent.

[SNIPPED...]

>     exit(1);
>   };
>
>   while (1)
>   {
>     int rd;
>     int i;
>     socklen_t from_size;
>
>     rd = recvfrom( s, (char*)&p, sizeof(p), 0, (struct sockaddr *)&cli_address,
> &from_size);
    ^^^^^^^^______ Was NOT initialized....


Quote man pages: "The argument fromlen is a value-result parameter,
initialized to the size of the buffer associated with from...."
^^^^^^^^^^____ READ this!


recvfrom() returned -1 with errno EINVAL because you fed it
invalid parameters. If some other Unixes ignore parameters,
of if the value on the stack just happened to be okay, it
doesn't mean there is a problem with Linux or any operating
system. You must understand that millions of programs use
the O.S. (any OS). If you find a problem when coding, the
chances are millions:1 against your code!

[SNIPPED crap]


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
