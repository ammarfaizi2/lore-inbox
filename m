Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbUCWUpz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 15:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbUCWUpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 15:45:39 -0500
Received: from littleblue.penguincomputing.com ([64.243.132.187]:16526 "EHLO
	hermes.penguincomputing.com") by vger.kernel.org with ESMTP
	id S262810AbUCWUpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 15:45:34 -0500
Message-ID: <34994.64.243.132.186.1080075174.squirrel@imap.penguincomputing.com>
Date: Tue, 23 Mar 2004 12:52:54 -0800 (PST)
Subject: RE: megaraid on opteron w/ 8G RAM
From: <ttwillman@penguincomputing.com>
To: <Atulm@lsil.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BC460@exa-atlanta.se.lsil.com>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC460@exa-atlanta.se.lsil.com>
X-Priority: 3
Importance: Normal
Cc: <error27@email.com>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm continuing the work on this system; Dan or I will try to get a serial
console hooked up soon (I'm working on system mostly remotely,
unfortunately).

What I've found so far:

it doesn't appear to be so much a problem with the megaraid driver
specifically; appears to be related more to the x86_64 code.  I've found
that kernel 2.4.25 from kernel.org works fine *if* mem=8128 is passed;
which would appear to me to be an issue with pci memory allocation. 
However RHEL3's 2.4.21-4ELsmp and 2.4.21-9.0.1ELsmp kernels do not work. 
I've also applied MTRR patches and some minor other fixups to no avail so
far.  I have not tried to apply ACPI/APIC patches yet to the RHEL kernels.

The driver stops after sending the first enquiry command to the card;
waits in a tight while loop polling for a response from the card with
interrupts disabled.


kernel.org ker

> What is the megaraid2 driver version? Can you inline the panic messages?
>
> -Atul Mukker
>
> -----Original Message-----
> From: dan carpenter [mailto:error27@email.com]
> Sent: Wednesday, March 10, 2004 9:19 PM
> To: linux-kernel@vger.kernel.org
> Cc: linux-scsi@vger.kernel.org
> Subject: megaraid on opteron w/ 8G RAM
>
>
> I'm using the megaraid 1.19.6 driver on RedHat Work Station
> x86_64.  It works great with only 4 gigs of RAM installed,
> but it locks up when I load the module with 8 gigs of RAM
> installed.  It generally locks up in the issue_scb_block()
> but it's not always consistent about which line it locks
> up on within that function.
>
> On the default Suse Linux Enterprise Server 8 the module
> loads but after around 5 hours of running drive tests the
> drives stop responding.
>
> I also tried the megaraid2 module and that kernel panics
> when the module is loaded.
>
> I'm using an arima motherboard with the 1.84 BIOS.
>
> Is this a known issue?  Has anyone been able to make a
> similar config work?
>
> regards,
> dan carpenter
> --
> ___________________________________________________________
> Sign-up for Ads Free at Mail.com
> http://promo.mail.com/adsfreejump.htm
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



