Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbUKHJnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbUKHJnV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUKHJnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:43:15 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:35806 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261817AbUKHJkq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:40:46 -0500
X-Envelope-From: kraxel@bytesex.org
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Con Kolivas <kernel@kolivas.org>,
       Gregoire Favre <Gregoire.Favre@freesurf.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: Why my computer freeze completely with xawtv ?
References: <20041107224621.GB5360@magma.epfl.ch>
	<418EB58A.7080309@kolivas.org> <20041108000229.GC5360@magma.epfl.ch>
	<418EB8EB.30405@kolivas.org> <20041108003323.GE5360@magma.epfl.ch>
	<418EBFE5.5080903@kolivas.org>
	<Pine.LNX.4.60.0411080919220.32677@alpha.polcom.net>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 08 Nov 2004 10:17:39 +0100
In-Reply-To: <Pine.LNX.4.60.0411080919220.32677@alpha.polcom.net>
Message-ID: <87bre88zt8.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski <kangur@polcom.net> writes:

> I am seeing the same problem with my bttv card. It was present in the
> 2.4 day and is present to this day. There are some kernels that are
> more probable to hang while others are less. It does not depend on -ck
> or any other patchset or scheduling. I reported it to bttv maintainer
> year or two ago, but it looks like he is very unresponsive. :-)

Well, if it happens almost independant of the kernel/driver version it
most likely is buggy hardware.  I can't do much about it ...

Well known example are some via chipsets which have trouble with
multiple devices doing DMA at the same time (those tend to run stable
with bttv once you've turned off ide-dma ...).

Getting broken hardware run stable and fast is black magic.  You can
try these (if that happens to help we can put that info into the pci
quirks btw.):

  eskarina kraxel ~# modinfo bttv | grep "pci config"
  parm: vsfx:set VSFX pci config bit [yet another chipset flaw workaround]
  parm: triton1:set ETBF pci config bit [enable bug compatibility for triton1 + others]

Otherwise BIOS updates, obscure BIOS settings, shuffling cards in PCI
slots, enable/disable ACPI and/or APIC, whatelse may or may not help.

See also Documentation/video4linux/bttv/README.freeze

good luck,

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
