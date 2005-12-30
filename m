Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVL3TNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVL3TNX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 14:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVL3TNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 14:13:23 -0500
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:45977 "EHLO
	elasmtp-kukur.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1751288AbVL3TNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 14:13:22 -0500
Date: Fri, 30 Dec 2005 14:13:15 -0500 (EST)
From: Dan Streetman <ddstreet@ieee.org>
Reply-To: ddstreet@ieee.org
To: Lee Revell <rlrevell@joe-job.com>
cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net,
       Alan Stern <stern@rowland.harvard.edu>, Bodo Eggert <7eggert@gmx.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: EHCI TT bandwidth (was Re: [PATCH]
 USB_BANDWIDTH documentation change)
In-Reply-To: <1135886739.6804.4.camel@mindpipe>
Message-ID: <Pine.LNX.4.51.0512301407200.28360@dylan.root.cx>
References: <Pine.LNX.4.44L0.0512261731001.10595-100000@netrider.rowland.org>
  <200512270857.35505.david-b@pacbell.net>  <Pine.LNX.4.51.0512291433090.27091@dylan.root.cx>
 <1135886739.6804.4.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-ELNK-Trace: a4c357c9134943511aa676d7e74259b7b3291a7d08dfec790f58622d9a310a9049cf5e0b0b276b49350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.148.162.106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Dec 2005, Lee Revell wrote:

>How do I test them?  Should this make USB audio work with
>CONFIG_USB_BANDWIDTH?

It won't have any effect on CONFIG_USB_BANDWIDTH, as the EHCI transaction 
translator scheudling code doesn't care about that config setting.  This 
also won't have any effect on USB 2.0 devices (e.g. a highspeed Audio 
device).

The updates will only help in the situation where there are multiple
lowpseed or fullspeed devices with periodic endpoints, all connected to
the same USB 2.0 (highspeed) hub.  In that situation it's possible to
"fill up" the USB 2.0 hub's transaction translator periodic schedule with
only a few devices.  The updates allow many more devices to fit in the
TT's periodic schedule.  The specific number of devices depends on how 
many periodic endpoints, those endpoint's poll rates, and their max packet 
sizes.



-- 
Dan Streetman
ddstreet@ieee.org
---------------------
186,272 miles per second:
It isn't just a good idea, it's the law!
