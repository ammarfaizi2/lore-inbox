Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbWIFBJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbWIFBJJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 21:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbWIFBJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 21:09:08 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:26805 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965153AbWIFBJH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 21:09:07 -0400
Subject: Re: [BUG] no sound on ppc mac mini
From: john stultz <johnstul@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
       lkml <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>
In-Reply-To: <1157503851.22705.160.camel@localhost.localdomain>
References: <1152821370.6845.9.camel@localhost>
	 <1152831309.23037.31.camel@localhost.localdomain>
	 <1f1b08da0607312337l34eabc56jdee7b056acd9a71a@mail.gmail.com>
	 <1153.153.96.175.159.1154423993.squirrel@secure.sipsolutions.net>
	 <1157502802.28296.58.camel@localhost>
	 <1157503851.22705.160.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 18:08:44 -0700
Message-Id: <1157504924.2222.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 10:50 +1000, Benjamin Herrenschmidt wrote:
> > However...  ;)
> > 
> > It seems the new device doesn't have any volume control. I know the old
> > toonie driver used some form of softvol support, but "it just worked",
> > where as now I have no control over my system's audio volume.
> 
> It's a userland problem :) Your alsa config needs to enable the softvol
> plugin for it.

Yea. I figured. :( I've played around a bit w/ the .asoundrc file to
re-enable softvol (A similar hack was needed originally after the toonie
driver went in), but so far I've been unsuccessful.

> > While not the most terrible of regressions, its a bit irritating (waking
> > to loud mail notifications, specifically :). Is this something that I
> > have to wait for an alsa userland update to fix, or is the new kernel
> > driver just not fully functional yet?
> 
> Part of the problem is that you can't anymore identify the type of codec
> based on the card name thus Alsa old mecanism of having a specific
> toonie config file that includes softvol doesn't work any more. The
> trick was bad in the first place though because you can have multiple
> different codecs anyway, so it didn't scale. (The old driver couldn't
> deal with it, but the new one can, though we haven't yet implemented
> support for any of the topaz digital codecs).
> 
> I remember a discussion with the Alsa folks where it was question to
> have Alsa userland automatically instanciate softvol if there is no
> volume provided by the driver, which is a better approach.
> 
> Takashi, was this ever implemented ? John, what is your Alsa userland
> version ?

1.0.10-4ubuntu4

thanks
-john

