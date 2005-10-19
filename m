Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbVJSPsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVJSPsf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVJSPsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:48:35 -0400
Received: from spirit.analogic.com ([204.178.40.4]:34309 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751113AbVJSPse convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:48:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <4ae3c140510190831j7530742aqc2b82e9e9cd6dde3@mail.gmail.com>
References: <4ae3c140510190831j7530742aqc2b82e9e9cd6dde3@mail.gmail.com>
X-OriginalArrivalTime: 19 Oct 2005 15:48:33.0026 (UTC) FILETIME=[8F265620:01C5D4C4]
Content-class: urn:content-classes:message
Subject: Re: Is ext3 flush data to disk when files are closed?
Date: Wed, 19 Oct 2005 11:48:32 -0400
Message-ID: <Pine.LNX.4.61.0510191141370.5007@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Is ext3 flush data to disk when files are closed?
Thread-Index: AcXUxI9FGG3luD+4SJCydwA/ywS2nA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Xin Zhao" <uszhaoxin@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Oct 2005, Xin Zhao wrote:

> As far as I know, if an application modifies a file on an ext3 file
> ssytem, it actually change the page cache, and the dirty pages will be
> flushed to disk by kupdate periodically.
>
> My question is: if a file is to be closed, but some of its data pages
> are marked as dirty, will system block on close() and wait for dirty
> pages being flushed to disk? If so, it seems to decrease performance
> significantly if a lot of updates on many small files are involved.
>
> Can someone point me to the right place to check how it works? Thanks!
>
> Xin

In principle, if you open a file, write to it, close it, have
somebody else open it, read it, close it, then delete it, it
probably will never touch a physical disk. This is the basic
way a VFS (virtual file system) works. The system maintains a
RAM Disk that overflows to the physical media.

Given that, there are various ways to provoke the system into
writing data to the disk(s), such as executing `sync`. However,
normally file-data are written when the kernel needs to free
up some memory or when the disk(s) are un-mounted.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
