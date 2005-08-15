Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbVHOUYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbVHOUYm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 16:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVHOUYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 16:24:42 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:25798 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964942AbVHOUYl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 16:24:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EtV+MZ/zqe/wdL62ehjFrkvWSro/AVpk5H9uSJAPMe3hpPhlyBm9YB2/IiXklfCCdWlKEojZxNwiYmCtR8EPh9lUM5IE+TmxhN31no4DuqmezFgeK5SjH/RjjHhySCHXWZtYwYHEKH8KF+vu+1yEeRpv1O6P5QPo1OymHTtS8Ko=
Message-ID: <9e47339105081513245b168d24@mail.gmail.com>
Date: Mon, 15 Aug 2005 16:24:40 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: Joe Peterson <joe@skyrush.com>
Subject: Re: [PATCH] to drivers/input/evdev.c to add mixer device "/dev/input/events"
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <4300EF7C.9020500@skyrush.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4300D09C.4030702@skyrush.com> <20050815174558.GB1450@ucw.cz>
	 <4300D845.8070605@skyrush.com> <20050815185729.GA1450@ucw.cz>
	 <4300EF7C.9020500@skyrush.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/05, Joe Peterson <joe@skyrush.com> wrote:
> So, overall, I agree that we should not invent hacks to make up for
> another software package's problems, but perhaps input devices,
> especially ones that sometimes are not there at boot or not there all
> the time, should be treated in a way that lets programs stay ignorant of
> the intermittent nature of the devices.  It does not sound right to push
> the handling of the intermittent nature to each user program.  If the
> kernel could handle that aspect, it would make all programs more stable.
> And most of those "plug and unplug" events, even if handled by X or
> other programs, would really be unnecessary in most cases.  In the case
> of a touchscreen, there is no need for X to know it switched off and
> back on again - it just needs to keep listening for touch events.  For X
> to be "hotplug aware" in this sense only adds complication, I would
> think.  At least if there were a mode in the device/hotplug/udev stuff
> to make a "permanent" device (from boot, and always), you could spare
> the program all of that.

Vojtech is right. The problem is in X and should not be fixed in the
kernel. You need to complain about this on the Xorg lists.

http://lists.freedesktop.org/mailman/listinfo/xorg

In your example you missed the case of someone having X running and
they plug in a new device that X has never seen before. The Linux
kernel has a hotplug system that tracks all of these plug in/out
events. The problem is that X is not using the hotplug system when it
should. X could even track your display being open/closed if it was
listening to the hotplug events.

The xorg evdev input driver is here:
http://cvs.freedesktop.org/xorg/driver/xf86-input-evdev/

-- 
Jon Smirl
jonsmirl@gmail.com
