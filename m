Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbUKVOgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbUKVOgR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 09:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbUKVOeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 09:34:36 -0500
Received: from mail.convergence.de ([212.227.36.84]:3977 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S262106AbUKVOMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 09:12:55 -0500
Date: Mon, 22 Nov 2004 15:16:07 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Gerd Knorr <kraxel@suse.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Takashi Iwai <tiwai@suse.de>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: modprobe + request_module() deadlock
Message-ID: <20041122141607.GA21184@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Gerd Knorr <kraxel@suse.de>, Rusty Russell <rusty@rustcorp.com.au>,
	Takashi Iwai <tiwai@suse.de>,
	"Alexander E. Patrakov" <patrakov@ums.usu.ru>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122102502.GF29305@bytesex>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(someone dropped me off the Cc: list for this thread :-(, which is
doubly bad because I'm not subscribed to lkml :-(( )

Gerd Knorr wrote:
> > The traditional way to do this has been to have saa7134-empress do its
> > own probe, and likewise saa7134-dvb.
> 
> They can't actually probe themself.  It's _one_ PCI device (driven by
> the saa7134 module) which can handle (among other v4l-related things)
> the DMA transfer of mpeg streams.  That can be used in different ways
> (or not at all) and the different use cases are handled by the
> sub-modules.
> 
> So the way it is intended to work is that saa7134 has the pci table and
> gets autoloaded by hotplug, it will have a look at the hardware and then
> load either saa7134-empress or saa7134-dvb or none of them, so you'll
> get everything nicely autoloaded.

The saa7146 driver seems to have a working solution for this
problem: The PCI ids are registered to the subdrivers (e.g. dvb-ttpci
or mxb)  so that these are loaded via hotplug. They then register to the
saa7146 core as an "extension" module, and the core then does the probing.
Grep for saa7146_register_extension().

Johannes
