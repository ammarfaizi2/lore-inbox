Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbVK1NJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVK1NJq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 08:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbVK1NJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 08:09:46 -0500
Received: from spirit.analogic.com ([204.178.40.4]:19725 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932085AbVK1NJp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 08:09:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <17290.64538.843580.695349@gargle.gargle.HOWL>
X-OriginalArrivalTime: 28 Nov 2005 13:09:44.0495 (UTC) FILETIME=[0039E3F0:01C5F41D]
Content-class: urn:content-classes:message
Subject: Re: What's wrong with this really simple function?
Date: Mon, 28 Nov 2005 08:09:39 -0500
Message-ID: <Pine.LNX.4.61.0511280804010.7501@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: What's wrong with this really simple function?
Thread-Index: AcX0HQBDYIm+AMCKQSObjsGAucuWLA==
References: <afd776760511271057l5e3c4e3fq14b0b9ba4cdc7c9a@mail.gmail.com><20051128075505.GA7945@hsnr.de> <17290.64538.843580.695349@gargle.gargle.HOWL>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Juergen Quade" <quade@hsnr.de>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Nov 2005, Nikita Danilov wrote:

> Juergen Quade writes:
> > On Sun, Nov 27, 2005 at 12:57:47PM -0600, Mohamed El Dawy wrote:
> > > Hi,
> > >  I have created this 5-liner system call, which basically opens a
> > > file, write "Hello World" to it, and then returns. That's all.
> > >
> > > Now, when I actually call it, it creates the file successfully but
> > > writes nothing to it. The file is created and is only zero bytes. So,
> > > either write didn't write, or close didn't close. Any help would be
> > > greatly appreciated.
> > > ...
> >
> > The following (module-) code will create and write a file from
> > inside a kernel. Ok -- you know -- you should not use it
> > without really good reasons ...
> >
> >           Juergen.
> >
> > #include <linux/module.h>
> > #include <linux/moduleparam.h>
> > #include <linux/fs.h>
> > #include <asm/uaccess.h>
> >
> > static char filename[255];
> > module_param_string( filename, filename, sizeof(filename), 666 );
> > struct file *log_file;
> >
> > static int __init mod_init(void)
> > {
> > 	mm_segment_t oldfs;
> >
> > 	if( filename[0]=='\0' )
> > 		strncpy( filename, "/tmp/kernel_file", sizeof(filename) );
> > 	printk("opening filename: %s\n", filename);
> > 	log_file = filp_open( filename, O_WRONLY | O_CREAT, 0644 );
> > 	printk("log_file: %p\n", log_file );
> > 	if( IS_ERR( log_file ) )
> > 		return -EIO;
>
> This code is trivially exploitable: /tmp is usually a world-writable
> directory, and everybody can do
>
> $ ln -s /etc/shadow /tmp/kernel_file
>
> or even
>
> $ ln /etc/shadow /tmp/kernel_file
>
> provided that /tmp and /etc are on the same file system.
>
> Please do not use it.
>
> Nikita.

Also, this has become a FAQ. One needs a context with which to
associate file descriptors and even file buffers. Whose did he
steal? When he finds out, he will find the buffer that never
got written to the file.

Again, to read/write files from inside the kernel either create
a kernel thread, steal init's context, or don't.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
