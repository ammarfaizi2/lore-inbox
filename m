Return-Path: <linux-kernel-owner+w=401wt.eu-S932082AbWLNIzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWLNIzu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 03:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWLNIzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 03:55:50 -0500
Received: from jdi.jdi-ict.nl ([82.94.239.5]:60619 "EHLO jdi.jdi-ict.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932082AbWLNIzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 03:55:49 -0500
Date: Thu, 14 Dec 2006 09:55:38 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdi-ict.nl>
X-X-Sender: igmar@jdi.jdi-ict.nl
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, npiggin@suse.de, erich <erich@areca.com.tw>
Subject: Re: 2.6.16.32 stuck in generic_file_aio_write()
In-Reply-To: <20061214004213.13149a48.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0612140953080.9623@jdi.jdi-ict.nl>
References: <Pine.LNX.4.58.0611291329060.18799@jdi.jdi-ict.nl>
 <20061130212248.1b49bd32.akpm@osdl.org> <Pine.LNX.4.58.0612010926030.31655@jdi.jdi-ict.nl>
 <Pine.LNX.4.58.0612042201001.14643@jdi.jdi-ict.nl>
 <Pine.LNX.4.58.0612061615550.24526@jdi.jdi-ict.nl> <20061206074008.2f308b2b.akpm@osdl.org>
 <Pine.LNX.4.58.0612070940590.28683@jdi.jdi-ict.nl>
 <Pine.LNX.4.58.0612071328030.9115@jdi.jdi-ict.nl>
 <Pine.LNX.4.58.0612140912010.30202@jdi.jdi-ict.nl> <20061214004213.13149a48.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.1.12 (jdi.jdi-ict.nl [127.0.0.1]); Thu, 14 Dec 2006 09:55:38 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Hmm.. Switching CONFIG_HZ from 1000 to 250 seems to 'fix' the problem. 
> > I haven't seen the issue in nearly a week now. This makes Andrew's theory 
> > about missing interrupts very likely.
> > 
> > Andrew / others : Is there a way to find out if it *is* missing 
> > interrupts ?
> > 
> 
> umm, nasty.  What's in /proc/interrupts?

See below. The other machine is mostly identifical, except for i8042 
missing (probably due to running an older kernel, or small differences in 
the kernel config).

Regards,


	Igmar

[jdiict@lnx01 ~]$ cat /proc/interrupts
           CPU0       CPU1
  0:   73702693   74509271   IO-APIC-edge      timer
  1:          1          1   IO-APIC-edge      i8042
  4:       2289       8389   IO-APIC-edge      serial
  8:          0          1   IO-APIC-edge      rtc
  9:          0          0   IO-APIC-fasteoi   acpi
 12:          3          1   IO-APIC-edge      i8042
 16:  203127788          0   IO-APIC-fasteoi   uhci_hcd:usb2, eth0
 17:        525        492   IO-APIC-fasteoi   uhci_hcd:usb4
 18:   13000070   67584889   IO-APIC-fasteoi   arcmsr
 19:          0          0   IO-APIC-fasteoi   ehci_hcd:usb1
 20:          0          0   IO-APIC-fasteoi   uhci_hcd:usb3
NMI:          0          0
LOC:  148127756  148133476
ERR:          0
MIS:          0
