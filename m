Return-Path: <linux-kernel-owner+w=401wt.eu-S1760887AbWLHSvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760887AbWLHSvu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 13:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760890AbWLHSvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:51:50 -0500
Received: from spirit.analogic.com ([204.178.40.4]:1823 "EHLO
	spirit.analogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760887AbWLHSvt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:51:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 08 Dec 2006 18:51:44.0972 (UTC) FILETIME=[E84A70C0:01C71AF9]
Content-class: urn:content-classes:message
Subject: Re: Linux slack space question
Date: Fri, 8 Dec 2006 13:51:44 -0500
Message-ID: <Pine.LNX.4.61.0612081337510.20280@chaos.analogic.com>
In-Reply-To: <3c698a820612080921u20a957d9x1ac1e01e6734d025@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux slack space question
thread-index: Acca+ehRfKIWpg6UQNmoTzKlgwXI7A==
References: <3c698a820612080921u20a957d9x1ac1e01e6734d025@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Maria Short" <mgolod@ieee.org>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Dec 2006, Maria Short wrote:

> I have a question regarding how the Linux kernel handles slack space.
> I know that the ext3 filesystems typically use 1,2 or 4 KB blocks and
> if a file is not an even multiple of the block size then the last
> allocated block will not be completely filled, the remaining space is
> wasted as slack space.
>

Not wasted, could be extended if additional data are written.

> What I need is the code in the kernel that does that. I have been
> looking at http://lxr.linux.no/source/fs/ext3/inode.c but I could not
> find the specific code for partially filling the last block and
> placing an EOF at the end, leaving the rest to slack space.

An EOF? Unlike CP/M the Linux file-systems copy to user-space up to the
last byte written to the file, not up to the last block. Therefore, there
is no need for "fill" and certainly no EOF character. All Linux/Unix
files are binary files, i.e., there are no special characters inserted.
Now, when you read a file using buffered I/O (the f***() functions), the
'C' runtime library converts I/O so that functions like feof(*stream) work.
The actual EOF on a binary file occurs when a read() returns 0 bytes.

The number of bytes actually written to files are handled in inodes. In fact, 
you can make a file larger simply by moving a file-pointer. That changes
the inode value. Such files are called sparse files and, when read, the space 
not written is cleared so the user never reads something that wasn't
specifically written.

  >
> Please forward the answer to mgolod@ieee.org as soon as possible.
>
> Thank you very much.
> -

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.68 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
