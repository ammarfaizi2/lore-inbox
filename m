Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbUKVPFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbUKVPFT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 10:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbUKVPDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 10:03:52 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:41113 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261470AbUKVPBC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:01:02 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 22 Nov 2004 15:44:33 +0100
From: Gerd Knorr <kraxel@suse.de>
To: Johannes Stezenbach <js@linuxtv.org>, Gerd Knorr <kraxel@suse.de>,
       Rusty Russell <rusty@rustcorp.com.au>, Takashi Iwai <tiwai@suse.de>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: modprobe + request_module() deadlock
Message-ID: <20041122144432.GB575@bytesex>
References: <20041122102502.GF29305@bytesex> <20041122141607.GA21184@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122141607.GA21184@linuxtv.org>
X-GPG-Fingerprint: 79C4 EE94 CC44 6DD4 58C6  3088 DBB7 EC73 8750 D2C4  [1024D/8750D2C4]
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > They can't actually probe themself.  It's _one_ PCI device (driven by
> > the saa7134 module) which can handle (among other v4l-related things)
> > the DMA transfer of mpeg streams.  That can be used in different ways
> > (or not at all) and the different use cases are handled by the
> > sub-modules.
> > 
> > So the way it is intended to work is that saa7134 has the pci table and
> > gets autoloaded by hotplug, it will have a look at the hardware and then
> > load either saa7134-empress or saa7134-dvb or none of them, so you'll
> > get everything nicely autoloaded.
> 
> The saa7146 driver seems to have a working solution for this
> problem: The PCI ids are registered to the subdrivers (e.g. dvb-ttpci
> or mxb)  so that these are loaded via hotplug. They then register to the
> saa7146 core as an "extension" module, and the core then does the probing.
> Grep for saa7146_register_extension().

That would be kida ugly because I'd need a dummy module then for the
cards which need neither saa7134-empress nor saa7134-dvb (which is true
for most of the existing cards btw).

I can fix that in the driver, by delaying the request_module() somehow
until the saa7134 module initialization is finished.  I don't think that
this is a good idea through as it looks like I'm not the only one with
that problem ...

  Gerd

