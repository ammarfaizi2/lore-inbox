Return-Path: <linux-kernel-owner+w=401wt.eu-S932108AbWLNJKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWLNJKw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 04:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWLNJKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 04:10:52 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33897 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932110AbWLNJKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 04:10:50 -0500
Date: Thu, 14 Dec 2006 01:10:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Igmar Palsenberg <i.palsenberg@jdi-ict.nl>
Cc: linux-kernel@vger.kernel.org, npiggin@suse.de, erich <erich@areca.com.tw>
Subject: Re: 2.6.16.32 stuck in generic_file_aio_write()
Message-Id: <20061214011042.7b279be6.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0612140953080.9623@jdi.jdi-ict.nl>
References: <Pine.LNX.4.58.0611291329060.18799@jdi.jdi-ict.nl>
	<20061130212248.1b49bd32.akpm@osdl.org>
	<Pine.LNX.4.58.0612010926030.31655@jdi.jdi-ict.nl>
	<Pine.LNX.4.58.0612042201001.14643@jdi.jdi-ict.nl>
	<Pine.LNX.4.58.0612061615550.24526@jdi.jdi-ict.nl>
	<20061206074008.2f308b2b.akpm@osdl.org>
	<Pine.LNX.4.58.0612070940590.28683@jdi.jdi-ict.nl>
	<Pine.LNX.4.58.0612071328030.9115@jdi.jdi-ict.nl>
	<Pine.LNX.4.58.0612140912010.30202@jdi.jdi-ict.nl>
	<20061214004213.13149a48.akpm@osdl.org>
	<Pine.LNX.4.58.0612140953080.9623@jdi.jdi-ict.nl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 09:55:38 +0100 (CET)
Igmar Palsenberg <i.palsenberg@jdi-ict.nl> wrote:

> 
> > > Hmm.. Switching CONFIG_HZ from 1000 to 250 seems to 'fix' the problem. 
> > > I haven't seen the issue in nearly a week now. This makes Andrew's theory 
> > > about missing interrupts very likely.
> > > 
> > > Andrew / others : Is there a way to find out if it *is* missing 
> > > interrupts ?
> > > 
> > 
> > umm, nasty.  What's in /proc/interrupts?
> 
> See below. The other machine is mostly identifical, except for i8042 
> missing (probably due to running an older kernel, or small differences in 
> the kernel config).
> 

Does the other machine have the same problems?

Are you able to rule out a hardware failure?

> [jdiict@lnx01 ~]$ cat /proc/interrupts
>            CPU0       CPU1
>   0:   73702693   74509271   IO-APIC-edge      timer
>   1:          1          1   IO-APIC-edge      i8042
>   4:       2289       8389   IO-APIC-edge      serial
>   8:          0          1   IO-APIC-edge      rtc
>   9:          0          0   IO-APIC-fasteoi   acpi
>  12:          3          1   IO-APIC-edge      i8042
>  16:  203127788          0   IO-APIC-fasteoi   uhci_hcd:usb2, eth0
>  17:        525        492   IO-APIC-fasteoi   uhci_hcd:usb4
>  18:   13000070   67584889   IO-APIC-fasteoi   arcmsr
>  19:          0          0   IO-APIC-fasteoi   ehci_hcd:usb1
>  20:          0          0   IO-APIC-fasteoi   uhci_hcd:usb3
> NMI:          0          0
> LOC:  148127756  148133476
> ERR:          0
> MIS:          0

The disk interrupt is unshared, which rules out a few software problems, I
guess.

