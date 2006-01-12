Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161407AbWALXD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161407AbWALXD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 18:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161405AbWALXD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 18:03:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29061 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161402AbWALXD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 18:03:26 -0500
Date: Thu, 12 Jan 2006 18:03:15 -0500
From: Dave Jones <davej@redhat.com>
To: Adam Belay <ambx1@neo.rr.com>, Con Kolivas <kernel@kolivas.org>,
       ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-ck1
Message-ID: <20060112230315.GO19827@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adam Belay <ambx1@neo.rr.com>, Con Kolivas <kernel@kolivas.org>,
	ck list <ck@vds.kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200601041200.03593.kernel@kolivas.org> <20060104190554.GG10592@redhat.com> <20060112221133.GA11601@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112221133.GA11601@neo.rr.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 05:11:33PM -0500, Adam Belay wrote:
 
 > > I've been curious for some time if this would actually show any measurable
 > > power savings. So I hooked up my laptop to a gizmo[1] that shows how much
 > > power is being sucked.
 > > 
 > > both before, and after, it shows my laptop when idle is pulling 21W.
 > > So either the savings here are <1W (My device can't measure more accurately
 > > than a single watt), or this isn't actually buying us anything at all, or
 > > something needs tuning.
 > 
 > I've done quite a bit of testing with dynticks and various c-state strategies.
 > On my thinkpad T42, dynticks can save about .5 W (as read from the ACPI battery
 > interface, but hey it's a good ballpark measurement).

In the follow-ups to my above message, I found that it was actually
working, and dropped from 21W down to as low as 18W in some cases, but
USB and the input layer are firing off timers very regularly, so it
bounces around all over the place.

 > It might be possible to do even a little better.  Currently, I'm developing a
 > new ACPI idle policy that tries to take advantage of the long time we may
 > be able to spend in a C3 state.

As soon as that usb timer hits (every 250ms iirc) you'll bounce back out
of any low-power state you may be in. It's a bit craptastic that we do
this, even if we don't have any USB devices plugged in.

		Dave

