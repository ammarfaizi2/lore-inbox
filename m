Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269548AbVBFIhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269548AbVBFIhc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 03:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269265AbVBFIhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 03:37:31 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:58856 "EHLO suse.de")
	by vger.kernel.org with ESMTP id S265405AbVBFIhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 03:37:18 -0500
Date: Sun, 6 Feb 2005 09:37:39 +0100
From: Vojtech Pavlik <vojtech@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       zhilla <zhilla@spymac.com>, Victor Hahn <victorhahn@web.de>
Subject: Re: [RFC/RFT] Better handling of bad xfers/interrupt delays in psmouse
Message-ID: <20050206083739.GC8642@ucw.cz>
References: <200502051448.57492.dtor_core@ameritech.net> <20050205211136.GB8451@ucw.cz> <200502060029.21068.dtor_core@ameritech.net> <200502060223.55090.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502060223.55090.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 02:23:48AM -0500, Dmitry Torokhov wrote:

> Ok, here is the patch using PSMOUSE_CMD_POLL. Seems to work fine with 2
> external mice that I have and my touchpad in PS/2 compatibility mode.
> 
> Unfortunately POLL command kicks Synaptics out of absolute mode so I
> disabled all time-based sync checks for Synaptics altogether. This should
> be OK since Synaptics have pretty strict protocol rules and usually
> can resync on their own. I wonder what POLL does to ALPS?
> 
> Again, 2.6.10 version can be found here:
> 
> 	http://www.geocities.com/dt_or/input/2_6_10/
> 
> Comments/testing is appreciated.
 
Did you check that issuing the POLL command in the middle of a mouse
packet does indeed reset the counter of the streaming mode? I'd expect
them to be separate, at least on some mice, if POLL is handled as a
normal mouse command, and after the three bytes from POLL are sent, the
mouse could just continue sending the packet like with any other
command.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
