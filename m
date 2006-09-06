Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWIFAv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWIFAv1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 20:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWIFAv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 20:51:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:10434 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030214AbWIFAv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 20:51:26 -0400
Subject: Re: [BUG] no sound on ppc mac mini
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
       lkml <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>
In-Reply-To: <1157502802.28296.58.camel@localhost>
References: <1152821370.6845.9.camel@localhost>
	 <1152831309.23037.31.camel@localhost.localdomain>
	 <1f1b08da0607312337l34eabc56jdee7b056acd9a71a@mail.gmail.com>
	 <1153.153.96.175.159.1154423993.squirrel@secure.sipsolutions.net>
	 <1157502802.28296.58.camel@localhost>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 10:50:51 +1000
Message-Id: <1157503851.22705.160.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> However...  ;)
> 
> It seems the new device doesn't have any volume control. I know the old
> toonie driver used some form of softvol support, but "it just worked",
> where as now I have no control over my system's audio volume.

It's a userland problem :) Your alsa config needs to enable the softvol
plugin for it.

> While not the most terrible of regressions, its a bit irritating (waking
> to loud mail notifications, specifically :). Is this something that I
> have to wait for an alsa userland update to fix, or is the new kernel
> driver just not fully functional yet?

Part of the problem is that you can't anymore identify the type of codec
based on the card name thus Alsa old mecanism of having a specific
toonie config file that includes softvol doesn't work any more. The
trick was bad in the first place though because you can have multiple
different codecs anyway, so it didn't scale. (The old driver couldn't
deal with it, but the new one can, though we haven't yet implemented
support for any of the topaz digital codecs).

I remember a discussion with the Alsa folks where it was question to
have Alsa userland automatically instanciate softvol if there is no
volume provided by the driver, which is a better approach.

Takashi, was this ever implemented ? John, what is your Alsa userland
version ?

Ben.


