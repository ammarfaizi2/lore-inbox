Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268158AbUIFPtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268158AbUIFPtd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 11:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268161AbUIFPtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 11:49:33 -0400
Received: from imag.imag.fr ([129.88.30.1]:39929 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S268158AbUIFPtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 11:49:31 -0400
Date: Mon, 6 Sep 2004 17:48:39 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: Intel ICH - sound/pci/intel8x0.c
Message-ID: <20040906154839.GA6672@linux.ensimag.fr>
Reply-To: 9e47339104090607111e8a6f5d@mail.gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: Matthieu Castet <mat@ensilinx1.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Mon, 06 Sep 2004 17:49:28 +0200 (CEST)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Takashi says the code is already gone in the alsa tree so we don't
> know how they fixed it.
They ask to use generic modules instead.

look at the cvs log :

Summary: remove gameport/MIDI support

snd-intel8x0's gameport/MIDI code has quite a few problems:  the port
addresses cannot be detected reliably (or not at all with newer LPC
bridge devices), joystick port address 0x208 isn't supported, the MIDI
interrupt isn't detected, PnP isn't supported, changing the port
addresses in the LPC bridge configuration doesn't affect the devices
in the Super-I/O chip connected to the LPC bus, and registering this
driver for the LPC bridge PCI device prevents other drivers using the
LPC's PCI id from loading later.

All these problems can be cured by removing the offending code and
using the proper modules for these devices (ns558/snd-mpu401) instead.
