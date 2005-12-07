Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751822AbVLGXgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbVLGXgp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbVLGXgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:36:44 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:52451 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1751822AbVLGXgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:36:43 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: uart_match_port() question
Date: Wed, 7 Dec 2005 16:36:33 -0700
User-Agent: KMail/1.8.2
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1133050906.7768.66.camel@gaston> <200512071515.11937.bjorn.helgaas@hp.com> <1133997226.7168.93.camel@gaston>
In-Reply-To: <1133997226.7168.93.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512071636.33901.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 December 2005 4:13 pm, Benjamin Herrenschmidt wrote:
> ...  Part of the problem here is for example PIO. There is no such
> thing as PIO on a PowerPC, it's purely a PCI abstraction, thus inX/outX
> will only work once the PCI host briges have been discovered and their
> IO space mapped (setup_arch() time, but I definitely want my early
> console earlier).

ia64 has a similar problem, but it's a bit easier because firmware
configures and tells us about the legacy (0-64K) I/O port space.
So we do have to look up the MMIO base where those I/O ports get
mapped, but that's basically the first thing in setup_arch().  We
don't do much before that, so it hasn't been worthwhile to make
the console work earlier.
