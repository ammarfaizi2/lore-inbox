Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbUKVQaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUKVQaU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbUKVQ14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:27:56 -0500
Received: from port-83-236-152-146.static.qsc.de ([83.236.152.146]:47488 "EHLO
	heck.convergence.de") by vger.kernel.org with ESMTP id S261387AbUKVPhq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:37:46 -0500
Date: Mon, 22 Nov 2004 16:36:38 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Gerd Knorr <kraxel@suse.de>
Cc: Johannes Stezenbach <js@linuxtv.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Takashi Iwai <tiwai@suse.de>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: modprobe + request_module() deadlock
Message-ID: <20041122153637.GA10673@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Gerd Knorr <kraxel@suse.de>, Johannes Stezenbach <js@linuxtv.org>,
	Rusty Russell <rusty@rustcorp.com.au>, Takashi Iwai <tiwai@suse.de>,
	"Alexander E. Patrakov" <patrakov@ums.usu.ru>,
	linux-kernel@vger.kernel.org
References: <20041122102502.GF29305@bytesex> <20041122141607.GA21184@linuxtv.org> <20041122144432.GB575@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122144432.GB575@bytesex>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 03:44:33PM +0100, Gerd Knorr wrote:
> > The saa7146 driver seems to have a working solution for this
> > problem: The PCI ids are registered to the subdrivers (e.g. dvb-ttpci
> > or mxb)  so that these are loaded via hotplug. They then register to the
> > saa7146 core as an "extension" module, and the core then does the probing.
> > Grep for saa7146_register_extension().
> 
> That would be kida ugly because I'd need a dummy module then for the
> cards which need neither saa7134-empress nor saa7134-dvb (which is true
> for most of the existing cards btw).

You already have a saa7134-cards.c which you could turn
into a seperate module. I doubt users would care if they need
saa7134.o only or an additional module, if hotplug takes
care of loading them.

> I can fix that in the driver, by delaying the request_module() somehow
> until the saa7134 module initialization is finished.  I don't think that
> this is a good idea through as it looks like I'm not the only one with
> that problem ...

Delaying request_module() sounds ugly. Anyway, if you can
get it to work reliably...

Actually dvb-bt8xx.ko has a similar problem (no hotplug for DVB). It
uses bttv_sub_register(), though, but this doesn't do probing
and the PCI ids have to be in bttv-cards.c. It would be nicer
if dvb-bt8xx.ko could use a similar mechanism as dvb-ttpci.ko.
Or do you plan to add request_module("dvb-bt8xx") in bttv-driver.c?

And how about cx88 (I haven't checked this)?


Johannes
