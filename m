Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265181AbUEVDgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbUEVDgT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 23:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbUEVDgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 23:36:18 -0400
Received: from mx.style.net ([209.246.126.82]:53721 "EHLO style.net")
	by vger.kernel.org with ESMTP id S265181AbUEVDfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 23:35:48 -0400
From: "Spinka, Kristofer" <kspinka@style.net>
To: <viro@parcelfarce.linux.theplanet.co.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Unserializing ioctl() system calls
Date: Fri, 21 May 2004 20:35:55 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcQ/qAmFRornc78qSgyUYI0X2xBvZAABXR/w
In-Reply-To: <20040522025400.GU17014@parcelfarce.linux.theplanet.co.uk>
Message-ID: <auto-000001650065@style.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't necessarily have to be a flag on a driver, just an example.

I was more interested in a transitional interface to wean current
modules/code off of any BKL expectations during an ioctl.

Why should the kernel take out the BKL for the module during an ioctl?  Does
the kernel know how long this request might take?

  /kristofer

-----Original Message-----
From: viro@www.linux.org.uk [mailto:viro@www.linux.org.uk] On Behalf Of
viro@parcelfarce.linux.theplanet.co.uk
Sent: Friday, May 21, 2004 7:54 PM
To: Spinka, Kristofer
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unserializing ioctl() system calls

On Fri, May 21, 2004 at 10:46:45PM -0400, Spinka, Kristofer wrote:
> I noticed that even in the 2.6.6 code, callers to ioctl 
> system call (sys_ioctl in fs/ioctl.c) are serialized with 
> {lock,unlock}_kernel().
> 
> I realize that many kernel modules, and POSIX for that 
> matter, may not be ready to make this more concurrent.
> 
> I propose adding a flag to indicate that the underlying 
> module would like to support its own concurrency 
> management, and thus we avoid grabbing the BKL around the 
> f_op->ioctl call.
> 
> The default behavior would adhere to existing standards, 
> and if the flag is present (in the underlying module), we 
> let the module (or modules) handle it.
> 
> Reasonable?

No.  Flags on drivers are never a good idea.  What's more, if somebody
wants that shit parallelized they can always drop BKL upon entry and
reacquire on exit from their ->ioctl().

