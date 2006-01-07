Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932625AbWAGIZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbWAGIZV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 03:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbWAGIZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 03:25:20 -0500
Received: from styx.suse.cz ([82.119.242.94]:53894 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932625AbWAGIZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 03:25:20 -0500
Date: Sat, 7 Jan 2006 09:25:23 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Peter Osterlund <petero2@telia.com>,
       Luca Bigliardi <shammash@artha.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: request for opinion on synaptics, adb and powerpc
Message-ID: <20060107082523.GA6276@corona.ucw.cz>
References: <20060106231301.GG4732@kamaji.shammash.lan> <Pine.LNX.4.58.0601070053470.2702@telia.com> <1136595097.4840.189.camel@localhost.localdomain> <200601062317.03712.dtor_core@ameritech.net> <1136608396.4840.206.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136608396.4840.206.camel@localhost.localdomain>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 03:33:15PM +1100, Benjamin Herrenschmidt wrote:
> 
> > Why would you want to switch to relative mode when leaving X? As far as
> > I know the only other mouse "user" out there is GPM and there are patches
> > available for it to use event device:
> > 
> > 	http://geocities.com/dt_or/gpm/gpm.html
> > 
> > Unfortunately the maintainer can't find time to merge these so they were
> > sitting there for over 2 years. FWIW Fedora patches their GPM with these.
> 
> gpm among other legacy things ...
 
For X there is the synaptics driver, with more features than the pads
PS/2 mode.

For GPM there are the abovementioned patches, with configurable tap
characteristics, etc. They should be at least as good as the pads own
PS/2 mode.

For other legacy applications, there is the gpm repeater mode, exporting
GPM's functionality over the PS/2 protocol.

For legacy applications without GPM on the system, there is mousedev.c,
creating virtualized PS/2 devices for every application that opens it.
Its tap handling is not perfect, and it's not very much configurable,
but it works.

IMO there are enough options to make the device work well in absolute
mode.

If a relative mode is an absolute must, then a kernel option is IMO
sufficient (we have psmouse.proto=imps for the classic PS/2 Synaptics
pads), although a sysfs attribute would likely be better.

In theory, we could use EV_SYN, SYN_CONFIG for notifying applications
that the device has changed its capabilities, but a
disconnect/recreation will work better, since no applications support
the SYN_CONFIG notification ATM.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
