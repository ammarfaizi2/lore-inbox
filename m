Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbTIVGJu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 02:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTIVGJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 02:09:50 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:57528 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263005AbTIVGJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 02:09:48 -0400
Date: Mon, 22 Sep 2003 08:09:38 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <petero2@telia.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Broken synaptics mouse..
Message-ID: <20030922060938.GA27702@ucw.cz>
References: <Pine.LNX.4.44.0309110744030.28410-100000@home.osdl.org> <200309211816.36783.dtor_core@ameritech.net> <20030922053103.GA27045@ucw.cz> <200309220058.48015.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309220058.48015.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 12:58:48AM -0500, Dmitry Torokhov wrote:
 
> But in this case not only will I have to specify the event device Synaptics
> is connected to but also explicitly specify _every other_ input device I use
> (besides the touchpad I have a track-stick as a separate device and an USB
> mouse in my docking station). I will also loose hot-plug capabilities I have 
> now for free. 

The problem is that nothing comes for free. The hotplug capability you
have now comes at the cost of utter nonconfigurability, that is - it
gets input from every pointing devices.

The bright-future solution is to have GPM and XFree configured at
runtime by the /sbin/hotplug agent to open/close devices as they come
and go.

This again comes at a cost - more complex setup - but one that is
completely configurable as to which device goes where, stable in regard
of plug-in order, etc.

> All in all it just doesn't fly... I wonder if we could declare evdev
> the master handler and do not propagate events to the secondary
> handlers if some process has appropriate event device opened.

We could. Don't do a 'cat /dev/input/event0' if event0 is your keyboard
then, though. ;)

We also could change the EVIOCGRAB semantics to only grab in respect to
the handler, not just the single handle ...

But I still hope we'll be able to get to the /sbin/hotplug solution
without having to create too many intermediate solutions.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
