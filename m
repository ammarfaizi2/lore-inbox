Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbTGAU1V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 16:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbTGAU1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 16:27:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1233 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263759AbTGAU1N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 16:27:13 -0400
Message-ID: <3F01F1F5.5050907@pobox.com>
Date: Tue, 01 Jul 2003 16:41:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: ICH5 SATA causes high interrupt/system load?
References: <1057087443.3373.4.camel@paragon.slim>
In-Reply-To: <1057087443.3373.4.camel@paragon.slim>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurgen Kramer wrote:
> Hi,
> 
> After reading about problems with ICH5 SATA (Intel 875P) I've
> set my BIOS back to normal mode for the SATA controller. So now the SATA
> drive appears as hdc instead of hde.
> 
> The SATA drive was working in both situations (enhanced/normal) the only
> difference is that with normal mode there no high system load caused by
> the SATA controller (As I reported in a previous mail).
> 
> What's causing the high interrupt count in 'enhanced' mode?


Well, in legacy mode (a.k.a. normal), each ATA port (a.k.a. channel 
a.k.a. bus) gets their own interrupt, which is never shared with another 
device.

In native mode (a.k.a. enhanced), two ATA ports share a single PCI 
interrupt.  Further, this interrupt may be shared with any number of 
other PCI devices.

So, high interrupt count is necessarily a worry because you're probably 
seeing a coalescing of multiple interrupt counts into one big one.

	Jeff



