Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbVLENmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbVLENmE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 08:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVLENmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 08:42:04 -0500
Received: from spirit.analogic.com ([204.178.40.4]:26888 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932413AbVLENmD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 08:42:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051203004102.GA2923@redhat.com>
X-OriginalArrivalTime: 05 Dec 2005 13:42:02.0245 (UTC) FILETIME=[AC1B5350:01C5F9A1]
Content-class: urn:content-classes:message
Subject: Re: Add tainting for proprietary helper modules.
Date: Mon, 5 Dec 2005 08:41:57 -0500
Message-ID: <Pine.LNX.4.61.0512050832290.27133@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Add tainting for proprietary helper modules.
Thread-Index: AcX5oawiwIltVVVlS0iir1yV0o0+eg==
References: <20051203004102.GA2923@redhat.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Dave Jones" <davej@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Dec 2005, Dave Jones wrote:

> Kernels that have had Windows drivers loaded into them are undebuggable.
> I've wasted a number of hours chasing bugs filed in Fedora bugzilla
> only to find out much later that the user had used such 'helpers',
> and their problems were unreproducable without them loaded.
>
> Acked-by: Arjan van de Ven <arjan@infradead.org>
> Signed-off-by: Dave Jones <davej@redhat.com>
>
> --- linux-2.6.14/kernel/module.c~	2005-11-29 16:44:00.000000000 -0500
> +++ linux-2.6.14/kernel/module.c	2005-11-29 17:03:55.000000000 -0500
> @@ -1723,6 +1723,11 @@ static struct module *load_module(void _
> 	/* Set up license info based on the info section */
> 	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
>
> +	if (strcmp(mod->name, "ndiswrapper") == 0)
> +		add_taint(TAINT_PROPRIETARY_MODULE);
> +	if (strcmp(mod->name, "driverloader") == 0)
> +		add_taint(TAINT_PROPRIETARY_MODULE);
> +
> #ifdef CONFIG_MODULE_UNLOAD
> 	/* Set up MODINFO_ATTR fields */
> 	setup_modinfo(mod, sechdrs, infoindex);

So your are blacklisting certain drivers? If so, you probably
should have an array containing their names plus a header-file
into which the hundreds, perhaps thousands, of future module-
names can be added.

... Not meant as a joke or an affront. User's should be able to
know what hardware to NOT purchase because of the proprietary
nature of their drivers. Putting a couple "exceptions" into
code as above is not good coding practice. If you need to
exclude stuff, there should be an exclusion procedure that
treats all that stuff equally, no?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.44 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
