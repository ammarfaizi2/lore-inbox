Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932627AbWJGGZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbWJGGZY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 02:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932728AbWJGGZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 02:25:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:36276 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932627AbWJGGZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 02:25:22 -0400
Date: Fri, 6 Oct 2006 23:24:58 -0700
From: Greg KH <greg@kroah.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>
Subject: Re: sysfs & ALSA card
Message-ID: <20061007062458.GF23366@kroah.com>
References: <Pine.LNX.4.61.0610061548340.8573@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0610061548340.8573@tm8103.perex-int.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 04:00:27PM +0200, Jaroslav Kysela wrote:
> Hi,
> 
> 	I would like to discuss where is the right root for soundcards in 
> the sysfs tree. I would like to put card specific variables like id there 
> (see /proc/asound/card0/id).

That would be nice to have in sysfs, I agree.

> Also, I plan to create link from 
> /sys/class/sound tree to the appropriate card to show relationship. 
> Something like:
> 
> /sys/<somewhere>/soundcard/0
> 
> /sys/class/sound/controlC0/soundcard -> ../../../<somewhere>/soundcard/0
> 
> 	Any comments and suggestions?

Yeah, this isn't that hard right now.  Just create a new struct device
for every card, point the parent of this new device to the device that
represents the card, and then point the other different sound specific
devices to the new card.

Hm, let me go hack at it and see what I come up with, code is so much
better for an example...

thanks,

greg k-h
