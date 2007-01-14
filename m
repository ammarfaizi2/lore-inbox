Return-Path: <linux-kernel-owner+w=401wt.eu-S1751276AbXANNGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbXANNGU (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 08:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbXANNGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 08:06:19 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40632 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbXANNGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 08:06:19 -0500
Message-ID: <45AA2AD7.70607@drzeus.cx>
Date: Sun, 14 Jan 2007 14:06:31 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Philip Langdale <philipl@overt.org>
CC: LAK <linux-arm-kernel@lists.arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] MMC: Major restructuring and cleanup
References: <459CB3D2.4010707@drzeus.cx> <45A9BF57.7050408@overt.org>
In-Reply-To: <45A9BF57.7050408@overt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Langdale wrote:
> So, I think I'm a bit too much of a kernel newbie to be able to provide a
> definitive review, but I've looked over the changes and they look good to me.
>   

Good to hear. I'd like to get this in ASAP, but in order to make sure
everyone gets a look at it, it'll have to go a round in -mm during the
next kernel.

> I fully agree with the rearchitecturing - it makes it a lot easier to see
> what's going on and it'll scale for SDIO (as you mention) and CE-ATA as well,
> if we ever get a hold of any of those :-)
>   

With the very generous help of John Gilmore, I think we'll have those
sorted out in a jiffy. :)

> One concrete observation I'd make is that we should probably try and detect
> MMC first instead of SD. Up until today, I'd have said it didn't really
> matter, but I've been doing some reading and discovered that Protec make
> some very strange cards they call "SuperSD" which can talk mmc4 and sd 1.1.
> These will happily go along with either initialisation sequence - and as mmc4
> is either the same or better than sd 1.1 from a performance point of view,
> we should prefer it. This is independent of your restructuring, but as you're
> fiddling with this code... :-)
>   

Eeeeww... This is a problem as the SD spec. clearly states the order of
init commands. So I wouldn't be surprised if we find SD cards that choke
on the MMC init sequence.

I guess what we lose by not supporting these is 8 bit data bus, but as
we do not currently have a controller for that I think the point is moot.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

