Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271104AbTG1UzN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271094AbTG1UxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:53:00 -0400
Received: from webmail.hamiltonfunding.la ([12.162.17.40]:14213 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S271038AbTG1UwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:52:24 -0400
To: "Kathy Frazier" <kfrazier@mdc-dayton.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: DMA not supported with Intel ICH4 I/O controller?
References: <PMEMILJKPKGMMELCJCIGIEIMCDAA.kfrazier@mdc-dayton.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 28 Jul 2003 13:52:20 -0700
In-Reply-To: <PMEMILJKPKGMMELCJCIGIEIMCDAA.kfrazier@mdc-dayton.com>
Message-ID: <52brvegyrf.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 28 Jul 2003 20:52:20.0291 (UTC) FILETIME=[2331C130:01C3554A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Kathy> It's a proprietary board that we use to allow the PC to
    Kathy> send blocks of data to some industrial equipment.  We
    Kathy> developed the hardware and Linux driver in-house.  This
    Kathy> same board works (under Linux) on a MoBo using the Intel
    Kathy> 815E chipset (Pentium III) with an IHC2 I/O Controller Hub.
    Kathy> This is the system I did _all_ my stress testing in.  The
    Kathy> plan was to ship our product with these ASUS P4PE MoBos
    Kathy> (using Intel 845PE and ICH4 controller) and were
    Kathy> un-pleasantly surprise when it didn't work.

It sounds like your board is acting as a PCI bus master.  This is
completely different from DMA for the IDE controller.  External PCI
bus masters should be supported by any version of Linux that works on
the motherboard at all.

However there are of course many differences between an 815E and an
845PE motherboard, and between the ICH2 and ICH4.  You may have
borderline PCI compliance or signal integrity issues that only cause
problems on the P4PE motherboard.  The BIOS on the P4PE may be setting
your device up differently from the 815E motherboard.  Your device
might be confusing the BIOS on the P4PE so that the IRQ routing
information (eg in ACPI tables) is screwed up.  And so on.

However, I have not heard of any generic problems with external PCI
bus masters and the ICH4.

Best,
  Roland
