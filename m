Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWFGLMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWFGLMo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 07:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWFGLMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 07:12:44 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:41735 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751165AbWFGLMn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 07:12:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 07 Jun 2006 11:12:41.0339 (UTC) FILETIME=[4AFF94B0:01C68A23]
Content-class: urn:content-classes:message
Subject: Re: Quick close of all the open files.
Date: Wed, 7 Jun 2006 07:12:40 -0400
Message-ID: <Pine.LNX.4.61.0606070700040.25108@chaos.analogic.com>
In-reply-to: <3faf05680606061445r7da489d9tc265018bc7960779@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Quick close of all the open files.
Thread-Index: AcaKI0sesbQGDvmUTpu4EXS5IAkRuQ==
References: <3faf05680606061445r7da489d9tc265018bc7960779@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "vamsi krishna" <vamsi.krishnak@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Jun 2006, vamsi krishna wrote:

> Hello,
>
> I found that the following code is closing all the open files by the
> program, do you think its a bug in kernel code?
>
> ------------
> fp = tmpfile();
> fp->_chain = stderr;
> fpclose(fp);
> fp = NULL;
> ------------
>
> o Is there any other elegant way to close all the open files (rather
> than reading from /proc/<pid>/fd and calling close on each of the fd?)
>
> Looking forward to hear from you.
>
> Thank you,
> Vamsi.
> -

tmpfile() returns a pointer to the FILE type. FILE is an opaque
type, meaning you have no business accessing any of its contents.
In fact, there are no user accessible headers from which you
could properly determine the contents of this type. Your program
should not even know that it is a structure. In fact, it could
be a pointer to a linked list.

Anything you think you are seeing, any behavior you think exists,
is invalidated once you access any members of this structure.

If you want to close all open buffered files (streams), you use
fcloseall().

Also, the FILE type and any buffering is performed by the 'C'
runtime library. The kernel only does open/read/write/close,
the underlying primitives. If you find anything wrong with
FILE operations, you should contact the people who provided
your 'C' runtime library, not the Linux kernel group.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
