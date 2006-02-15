Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946023AbWBOQz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946023AbWBOQz6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 11:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946024AbWBOQz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 11:55:58 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:5127 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1946023AbWBOQz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 11:55:57 -0500
Date: Wed, 15 Feb 2006 17:55:49 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Message-ID: <20060215165549.GC516@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
References: <43D7C1DF.1070606@gmx.de> <200602141732.22712.rob@landley.net> <20060214231732.GB66586@dspnet.fr.eu.org> <200602141924.22965.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602141924.22965.rob@landley.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 07:24:22PM -0500, Rob Landley wrote:
> I'm torn between "nuts to alsa", pointing out that "ln -s /dev /dev/snd" 
> should shut it up nicely, and thinking up a way to actually do what it wants.
> 
> If there's a real need for subdirectories, I'm sure we can come up with a way 
> to shunt stuff into them.  (Of course a shellout could do it, but if it's 
> common enough we could build something into mdev...)
> 
> The easy one's the symlink, assuming there are no name collisions flinging 
> everything into one directory...

Let's see, on a recent kernel and recent udev I have as directories
under /dev:

- disk, a pure udev creation, so no conflict there
- loop, devices names under that are numeric.  mount has /dev/loop%d
  and /dev/loop/%d hardcoded
- bus/usb, this one collides with itself if flattened
- snd/sound, names except for seq and timer are pretty much line
  noise.  "timer" is scary though.
- net with tun and (I think) tap.
- pktcdvd with "control", not sure what tool uses it
- misc is ok (they're all ex-/dev/xx devices)
- video1394, dv1394, i2c with '0' as device name
- dri with card%d
- cpu which self-collides too
- input with a potentially dangerous event%d

So, well, I think you're going to need directories for usb and cpu
without doubt, and some of the rest is potentially risky, long-term
wise.

  OG.

