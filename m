Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbVJRThg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbVJRThg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 15:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbVJRThg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 15:37:36 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:47626 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751475AbVJRThg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 15:37:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <4355494C.5090707@comcast.net>
References: <4355494C.5090707@comcast.net>
X-OriginalArrivalTime: 18 Oct 2005 19:37:33.0526 (UTC) FILETIME=[62B67F60:01C5D41B]
Content-class: urn:content-classes:message
Subject: Re: Keep initrd tasks running?
Date: Tue, 18 Oct 2005 15:37:33 -0400
Message-ID: <Pine.LNX.4.61.0510181527220.1651@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Keep initrd tasks running?
Thread-Index: AcXUG2LcPIlhja7BRiCyj4l75ILgKQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "John Richard Moser" <nigelenki@comcast.net>
Cc: <linux-kernel@vger.kernel.org>,
       "ubuntu-devel" <ubuntu-devel@lists.ubuntu.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Oct 2005, John Richard Moser wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> I have no idea who's the best to ask for this.
>
> I want to start a task in an initrd and have it stay running after init
> is started.  Pretty much:
>
>
> - kernel boot
> - initrd loaded
> - linuxrc executes
> - /bin/mydaemon runs
> - mount rootfs
> - pivot_root
> - exec /sbin/init (PID=1; linuxrc and sh is replaced)
> - mydaemon keeps running, reparented under init, uninterrupted
>
>
> What's the feasibility of this without the system balking and vomiting
> chunks everywhere?  I'm pretty sure 'exec /sbin/init' from linuxrc
> (PID=1) will replace the process image of sh (linuxrc) with init,
> keeping PID=1; but I'm worried this may terminate children too.  Haven't
> tried.
>
> (this actually has a useful application)

Note that the 'init' of linuxrc (/sbin/nash or /sbin/sash) also
has a PID of 1. It gets replaced with /sbin/init or whatever you
use for an emergency shell.

You can load a kernel thread from a driver that gets installed
by initrd. This would allow you to have processes running with
PIDs greater than 1 before the final init gets started. The
present kernel starts quite a few threads up to PID=8 right
now.

Once 'init' gets started, you are going to have either new 'inits'
exec(ed) with PID 1 or children with PIDs greater than 1.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
