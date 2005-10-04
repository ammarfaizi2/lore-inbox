Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbVJDRl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbVJDRl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 13:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbVJDRl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 13:41:56 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:12294 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964864AbVJDRlz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 13:41:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.60.0510041924520.8210@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0510041924520.8210@kepler.fjfi.cvut.cz>
X-OriginalArrivalTime: 04 Oct 2005 17:41:49.0310 (UTC) FILETIME=[E5DAB9E0:01C5C90A]
Content-class: urn:content-classes:message
Subject: Re: 2.4 in-kernel file opening
Date: Tue, 4 Oct 2005 13:41:49 -0400
Message-ID: <Pine.LNX.4.61.0510041329180.29678@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4 in-kernel file opening
Thread-Index: AcXJCuXhLjGoTEoISsuNnYtjsn9JNA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Martin Drab" <drab@kepler.fjfi.cvut.cz>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Oct 2005, Martin Drab wrote:

> Hi,
>
> can anybody tell me why there is no sys_open() exported in kernel/ksyms.c
> in 2.4 kernels while the sys_close() is there? And what is then the
> preferred way of opening files from within a 2.4 kernel module?
>
> Thank you,
> Martin

There is no way to open files within the kernel. Any attempt is
just a hack. The kernel is designed to perform tasks on behalf
of the caller. It doesn't have a context. It uses the caller's
context. A file-descriptor is a number that relates to the
current context. i.e., STDIN_FILENO is __different__ for you
and somebody else, even though it has the same numerical value.

To open a file in the kernel requires either a task with a
context (like a kernel thread) or you have to steal the context
of somebody which can destroy some innocent task's context.

You are never supposed to use files inside the kernel; period!
If you need to obtain file-data for a driver or receive file-
data from a driver, we have read(), write(), mmap(), and ioctl()
to accomplish these things from user-mode. A user-mode program can
write data directly to your driver using mmap(), for instance.
Or it can use a function-code you define to upload/download data
using ioctl().

This is a FAQ. Many persons have rejected this advice, only
to later on modify their drivers to correspond to the correct
way of writing Unix/Linux device drivers. This, after they've
trashed many innocent tasks.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
