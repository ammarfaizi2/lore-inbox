Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVBDNTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVBDNTd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 08:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVBDNTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 08:19:32 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:12062 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261271AbVBDNTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 08:19:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ttxaBpufmsOHdtS+t6exEtqe8wZY8mYmswROfDLVIZe8319Q6IcoAWxL2ONUQ4KL834UytYKIyUMBztf8XpWy3WImCro/hWEZnNMUXGL1iRUmS6VWq9xZS6/mQxUIrQQffTApHiiX6BTVnFe7M4m9aPeMeWKfCxB/Hh2pvDw3XM=
Message-ID: <a71293c205020405174ffa8d9d@mail.gmail.com>
Date: Fri, 4 Feb 2005 08:17:43 -0500
From: Stephen Evanchik <evanchsa@gmail.com>
Reply-To: Stephen Evanchik <evanchsa@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050204063520.GD2329@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <a71293c20502031443764fb4e5@mail.gmail.com>
	 <200502031934.16642.dtor_core@ameritech.net>
	 <20050204063520.GD2329@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005 07:35:20 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > >  /*
> > > + * Try to initialize the IBM TrackPoint
> > > + */
> > > +   if (max_proto > PSMOUSE_PS2 && trackpoint_init(psmouse) == 0) {
> > > +           psmouse->vendor = "IBM";
> > > +           psmouse->name = "TrackPoint";
> > > +
> > > +           return PSMOUSE_PS2;
> >
> > Why PSMOUSE_PS2? Reconnect will surely not like it.
> 
> Indeed. IIRC this patch killed wheel mouse detection in ubuntu.

Earlier versions of the patch didn't disable the device while probing
so events could be interpreted as the magic ID of a TrackPoint. It now
resets and disables the PS/2 device before detection but not after a
detect failure.

I'll clean that up so its more sensible.


Stephen
