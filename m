Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264306AbUFCVWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264306AbUFCVWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 17:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUFCVWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 17:22:21 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:3712 "EHLO cloud.ucw.cz")
	by vger.kernel.org with ESMTP id S264329AbUFCVV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 17:21:56 -0400
Date: Thu, 3 Jun 2004 23:23:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tuukka Toivonen <tuukkat@ee.oulu.fi>
Cc: Sau Dan Lee <danlee@informatik.uni-freiburg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: SERIO_USERDEV patch for 2.6
Message-ID: <20040603212325.GB1065@ucw.cz>
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de> <20040530111847.GA1377@ucw.cz> <xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de> <20040530124353.GB1496@ucw.cz> <xb7aczq9he1.fsf@savona.informatik.uni-freiburg.de> <20040530134246.GA1828@ucw.cz> <Pine.GSO.4.58.0406011105330.6922@stekt37> <Pine.GSO.4.58.0406031241330.8752@stekt37>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0406031241330.8752@stekt37>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 01:21:21PM +0300, Tuukka Toivonen wrote:
> New version released which addresses the issues you mentioned:
> wget \
> http://www.ee.oulu.fi/~tuukkat/tmp/linux-2.6.6-userdev.20040603.patch
> 
> >On Sun, 30 May 2004, Vojtech Pavlik wrote:
> >>Coexisting would mean that when someone wants to open the raw device,
> >>the serio layer would disconnect the psmouse driver, and give control to
> >>the raw device instead. I believe that could work.
> 
> Done, with slight modification: if the device is opened in read-only mode,
> the kernel drivers are not disconnected. This way the serio port could be
> controlled via IOCTL even when assigned to kernel drivers, if it ever
> becomes useful. Useful also for debugging etc.
> 
> >>I'd like to keep it separate from the
> >>serio.c file, although it's obvious it'll require to be linked to it
> >>statically, because it needs hooks there
> 
> Done. It's now in serio-dev.c. I also added serio-dev.h, which
> unfortunately is slightly messy so that I was able to inline some
> functions. It would be trivial to clean it up, if I wouldn't inline
> those functions.
> 
> I also had to rename serio.c into serio-core.c, which makes the actual
> changes into the file unobvious from the patch above. I made a separate
> diff about that, shown below (just for easy comparison).
> 
> The last change I made converts slashes '/' into underscores '_' (so
> eg. isa0060/serio0 is changed to isa0060_serio0 in /proc/misc, /dev
> with devfs, and /sys) because Sau Dan Lee reported that slashes don't work
> well with sysfs.
> 
> I tested the patch in a couple of machines, especially the new features.
> Seems to work finely.

I like it. Give me a while to evaluate your and Dmitry's approach in
relation to future ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
