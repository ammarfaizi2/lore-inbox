Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbUKVRKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbUKVRKE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 12:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbUKVRHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 12:07:39 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:7066 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262222AbUKVRBp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 12:01:45 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 22 Nov 2004 17:52:01 +0100
From: Gerd Knorr <kraxel@suse.de>
To: Johannes Stezenbach <js@convergence.de>, Gerd Knorr <kraxel@suse.de>,
       Johannes Stezenbach <js@linuxtv.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Takashi Iwai <tiwai@suse.de>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: modprobe + request_module() deadlock
Message-ID: <20041122165201.GA2060@bytesex>
References: <20041122102502.GF29305@bytesex> <20041122141607.GA21184@linuxtv.org> <20041122144432.GB575@bytesex> <20041122153637.GA10673@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122153637.GA10673@convergence.de>
X-GPG-Fingerprint: 79C4 EE94 CC44 6DD4 58C6  3088 DBB7 EC73 8750 D2C4  [1024D/8750D2C4]
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I can fix that in the driver, by delaying the request_module() somehow
> > until the saa7134 module initialization is finished.  I don't think that
> > this is a good idea through as it looks like I'm not the only one with
> > that problem ...
> 
> Delaying request_module() sounds ugly. Anyway, if you can
> get it to work reliably...

I think I can, havn't tried yet through.

> Actually dvb-bt8xx.ko has a similar problem (no hotplug for DVB). It
> uses bttv_sub_register(), though, but this doesn't do probing
> and the PCI ids have to be in bttv-cards.c. It would be nicer
> if dvb-bt8xx.ko could use a similar mechanism as dvb-ttpci.ko.

Well, you can use the second PCI function.

> Or do you plan to add request_module("dvb-bt8xx") in bttv-driver.c?

I can do that as well, bttv knows anyway which ones are dvb cards and
which ones are not.

> And how about cx88 (I haven't checked this)?

cx88-dvb has a PCI ID table.  The cx2388x has a separate PCI function
for the MPEG stuff which makes it a bit easier to get that handled
by hotplug directly ;)

  Gerd

