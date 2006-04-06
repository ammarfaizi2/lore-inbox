Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWDFR7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWDFR7z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 13:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWDFR7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 13:59:55 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:8196 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932074AbWDFR7y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 13:59:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <44354D7B.9070207@gmail.com>
x-originalarrivaltime: 06 Apr 2006 17:59:50.0040 (UTC) FILETIME=[E6070980:01C659A3]
Content-class: urn:content-classes:message
Subject: Re: Badness in local_bh_enable at kernel/softirq.c:140 with inet_stream
Date: Thu, 6 Apr 2006 13:59:49 -0400
Message-ID: <Pine.LNX.4.61.0604061351120.9302@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Badness in local_bh_enable at kernel/softirq.c:140 with inet_stream
Thread-Index: AcZZo+YQTGQPfEWdSU6K6uNjcepJpQ==
References: <44354D7B.9070207@gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "jordi Vaquero" <jordi.vaquero@gmail.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Apr 2006, jordi Vaquero wrote:

> Hello
>
> I'm trying to make a Linux Kernel module. My module has a network
> comunication with sockets, I use the functions like this skeleton,
>
>            sd = sock_create(AF_INET,SOCK_STREAM,IPPROTO_TCP,&sock);
>                if(sd<0){
>                printk(KERN_ERR "Error\n");
>            }else{
>                sout.sin_family = AF_INET;
>                err = inet_aton("172.16.151.1",&sout.sin_addr); //this
>        function works well, I implemented it.
>                sout.sin_port = htons(20000);
>                sd = sock->ops->connect(sock,(struct sockaddr*)&sout,
>        sizeof(sout),O_RDWR);
>                if(sd<0){
>                    printk(KERN_ERR "Error \n");
>                    sock_release(sock);
>                }else{
>                     USE SENDMSG and RECVMSG
>                        ...
>                        ...
>                        ...
>                   sock_release(sock);
>                }
>
> My problem is that sometimes, at some point near the connect function, a
> warning is launched and dmesg shows this:
>
[SNIPPED... Crap]

This has become a FAQ...
If you need to do this INSIDE the kernel, you need to do it from
a kernel thread. Otherwise, your socket is indistinguishable
from somebody else's open file descriptor. A file descriptor needs
a CONTEXT! The kernel doesn't have a CONTEXT! You need a process
to have a context, either a kernel thread or a user-mode task.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
