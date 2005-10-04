Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbVJDPe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVJDPe4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVJDPe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:34:56 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:27403 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964811AbVJDPez convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:34:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <434288E9.3090108@cdac.in>
References: <434288E9.3090108@cdac.in>
X-OriginalArrivalTime: 04 Oct 2005 15:34:52.0999 (UTC) FILETIME=[2A2DE570:01C5C8F9]
Content-class: urn:content-classes:message
Subject: Re: Using DMA in read/write, setting block size for I/O
Date: Tue, 4 Oct 2005 11:34:52 -0400
Message-ID: <Pine.LNX.4.61.0510041127550.28393@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Using DMA in read/write, setting block size for I/O
Thread-Index: AcXI+SpU3yXXIPxyQwieG3E+aiqK9Q==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Karthik Sarangan" <karthiks@cdac.in>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Oct 2005, Karthik Sarangan wrote:

> In my application, I have the following code.
>
> int main(void)
> {
>    char *pcBuffer;
>
>    posix_memalign((void **) pcBuffer, 512, 262144);
>    int ifd = open("/dev/sdb", O_DIRECT | O_RDWR);
>    long lLen;
>
>    lLen = read(ifd, pcBuffer, 262144);
>
>    close(ifd);
>    return 0;
> }
>
> Will the underlying block device read a single 256KB block from the hdd
> into pcBuffer

No. It might read 512 bytes! You can't assume that a read will
always return the value requested. That's a bug. You need code
that will make as many reads as necessary to satisfy your
request.

> or will it read 256KB as a set of smaller blocks?
>

You (your code) may have to read multiple times. The
kernel code may even read ahead.

> Since the buffer is memory aligned will it enable DMA?
>
> scsi disk driver is adaptec aic79xx.o

This Adaptec SCSI driver always uses DMA.

> distro is RedHat Enterprise Linux WS 4 (kernel-2.6.9-11)
> -


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
