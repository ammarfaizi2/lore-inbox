Return-Path: <linux-kernel-owner+w=401wt.eu-S1751134AbXALO1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbXALO1H (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 09:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbXALO1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 09:27:07 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:2608 "EHLO
	odyssey.analogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbXALO1F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 09:27:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 12 Jan 2007 14:27:01.0728 (UTC) FILETIME=[B998FE00:01C73655]
Content-class: urn:content-classes:message
Subject: Re: How can I create or read/write a file in linux device driver?
Date: Fri, 12 Jan 2007 09:27:01 -0500
Message-ID: <Pine.LNX.4.61.0701120907430.23919@chaos.analogic.com>
In-Reply-To: <20070112132459.GY13675@harddisk-recovery.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How can I create or read/write a file in linux device driver?
Thread-Index: Acc2VbmiJM7LBe+iQ9ufX59V6pZPkg==
References: <200701121547221465420@gmail.com> <9a8748490701120227h757d473ctaf5673aa318fe090@mail.gmail.com> <20070112132459.GY13675@harddisk-recovery.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Erik Mouw" <erik@harddisk-recovery.com>
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>, "congwen" <congwen@gmail.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Jan 2007, Erik Mouw wrote:

> On Fri, Jan 12, 2007 at 11:27:01AM +0100, Jesper Juhl wrote:
>> On 12/01/07, congwen <congwen@gmail.com> wrote:
>>> Hello everyone, I want to create and read/write a file in Linux kernel or
>>> device driver,
>>
>> Don't read/write user space files from kernel space.
>>
>> Please search the archives, this get asked a lot and it has been
>> explained a million times why it's a bad idea.
>> You can also read http://www.linuxjournal.com/article/8110
>
> Rather point to
>
>  http://kernelnewbies.org/FAQ/WhyWritingFilesFromKernelIsBad
>
>
> Erik
>
> -- 
> +-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
> | Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
> -

Sometimes a idiot boss will say; "You need to read or write files from
within the driver. If you don't do what I tell you, you are fired!"
Sigh, assuming you can't walk next door and get a reasonable job, it
__is__ possible to unreliably access files within the kernel. Note
that the kernel is __designed__ to perform user-mode operations, so
it is a bit difficult.

First, since file-operations require process context, and the kernel
is not a process, you need to create a kernel thread to handle your file
I/O. You write code to properly start up and shut down the kernel thread
before you do anything else. There are drivers in the kernel tree that
can be used as templates. The code that the kernel thread executes, needs
to be written so that it can receive commands to open/close/read/write
files, perhaps from semaphores or other communications methods. You can't
just create the thread and let it spin. It will eat up most all the CPU time!

Once you set up this "internal environment," you use the appropriate
kernel function(s) such as sys_open(), etc. You need to look at the code
and figure out what the parameters are. This is all very scary stuff and
it will take a long time to get it right. Once you have that working, there
is no guarantee that it will work with another kernel version simply by 
recompiling it. This is because some kernel versions lock portions of kernel 
code that you need. It's a pain.

In the unlikely event that you get a reasonably bug-free system running,
please publish the code on some web-site so it can be referenced in the
future by people whose bosses are idiots.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
