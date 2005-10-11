Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbVJKPQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVJKPQV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 11:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVJKPQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 11:16:21 -0400
Received: from spirit.analogic.com ([204.178.40.4]:36114 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932163AbVJKPQT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 11:16:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051011135944.22612.qmail@web8402.mail.in.yahoo.com>
References: <20051011135944.22612.qmail@web8402.mail.in.yahoo.com>
X-OriginalArrivalTime: 11 Oct 2005 15:16:17.0860 (UTC) FILETIME=[BA657040:01C5CE76]
Content-class: urn:content-classes:message
Subject: Re: Regarding - unresolved symbol
Date: Tue, 11 Oct 2005 11:16:17 -0400
Message-ID: <Pine.LNX.4.61.0510111104390.32115@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Regarding - unresolved symbol
Thread-Index: AcXOdrpsVRaWY7vRR76fXL43zct9yw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "vinay hegde" <thisismevinay@yahoo.co.in>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Oct 2005, vinay hegde wrote:

> Hi,
> I am developing a device driver module related to the
> real time clock on Linux 2.4 kernel. [This is done
> with regard to changing one of the existing timer chip
> on the  system.] For some reason, I am getting into an
> unresolved symbol.
>
> I am following sequence of code in the module (not
> necessarily in the sequential manner though).
>
> ----------
> extern void *sys_call_table[];
> static int (*timer_mknod)(const char *, ... );
> timer_mknod = sys_call_table[__NR_mknod];
> ----------
>
> Whenever I try to insert the module into the kernel, I
> get the following error:
> timer.o: unresolved symbol sys_call_table
>

sys_call_table isn't an exported symbol.

> All the necessary headers are present and I am able to
> see the symbol 'sys_call_table' in System.map. I do
> not see any error in this regard. Can somebody help me
> in pointing out the flaw?
>

The flaw is in attempting to modify the sys_call_table
with a module.

> [I am able to fix this problem by simply using the
> 'sys_mknod()' call in my module, but I really would
> like to know why the above piece of code can not
> work!]
>

Even sys_mknod() should not work from a module; Who's
context did you steal to create that device-file? What
happens next to that poor sucker? Who's data-space
did you corrupt for the file-name string? I note that,
from the names, it's likely that you intend to do this
dastardly deed from a timer-queue!!!

File operations require a process context. The kernel doesn't
have one. All file operations should (read must) be done
from user space. The kernel is designed to do things
on behalf of user-space callers. Executing sys_* from
a module will result in somebody saying; "See, you are
wrong... It works fine!". Later on mysterious errors
occur which are un-trackable.

> Thank you,
> Vinay Hegde
>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
