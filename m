Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbTDXQPY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 12:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbTDXQPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 12:15:24 -0400
Received: from gate.perex.cz ([194.212.165.105]:1035 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S261896AbTDXQPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 12:15:23 -0400
Date: Thu, 24 Apr 2003 18:26:44 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Werner Almesberger <wa@almesberger.net>
Cc: Matthias Schniedermeyer <ms@citd.de>, Pat Suwalski <pat@suwalski.net>,
       Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
In-Reply-To: <20030424130151.O3557@almesberger.net>
Message-ID: <Pine.LNX.4.44.0304241818400.1758-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Apr 2003, Werner Almesberger wrote:

> Matthias Schniedermeyer wrote:
> > man amixer
> 
> Thanks. Yes, this indeed seems to map to some functionality that's
> understood by the kernel.
> 
> Strange. So does this mean that non-ALSA mixers should not work when
> using ALSA ?

We have emulation layer for non-ALSA mixers. This layer turns mute off 
automagically when volume is greater than zero. This layer doesn't work 
100%, because ALSA API is more extended and there is no way to map the 
extended features to limited API.

> Why do they seem to anyway ?

> Is the driver or hardware side of this mute flag just rarely implemented?

Most of PCI cards which are based on AC97 supports muting for analog i/o.

> Or is the kernel default not always "mute" ?

We mute almost everything. Today, we preset only some of digital controls
and we preserve volume settings for USB devices (might be changed, of 
course).

Our policy is: Don't allow to users to jump from skin when default volumes 
are invalid. Because we cannot determine the settings of an user amplifier
(analog path), the most safe is mute everything.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

