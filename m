Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163474AbWLGV6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163474AbWLGV6X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163477AbWLGV6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:58:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:62915 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163474AbWLGV6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:58:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=XC0xnxlpzQrNY9vUV1ORJsg+mnReq5msilih3tzp3TVgFaJCmcHP5i6vgrae8nFzW84x7WRslQEw6OMxva8BH0rRYC8Qcq3KEXT1IuKp9EkFUziQGvUnMFrrF3eoynzKBzcJPuoVdXpljLjIMnj4p4eIlKNtcOwvJvIXvbVhero=
To: Dan Williams <dcbw@redhat.com>
Subject: Re: [RFC] rfkill - Add support for input key to control wireless radio
Date: Thu, 7 Dec 2006 22:58:14 +0100
User-Agent: KMail/1.9.5
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, John Linville <linville@tuxdriver.com>,
       Jiri Benc <jbenc@suse.cz>, Lennart Poettering <lennart@poettering.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Larry Finger <Larry.Finger@lwfinger.net>
References: <200612031936.34343.IvDoorn@gmail.com> <200612062241.58476.IvDoorn@gmail.com> <1165497754.2972.6.camel@localhost.localdomain>
In-Reply-To: <1165497754.2972.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612072258.14926.IvDoorn@gmail.com>
From: Ivo van Doorn <ivdoorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > > >  2 - Hardware key that does not control the hardware radio and does not report anything to userspace
> > > 
> > > Kind of uninteresting button ;)
> > 
> > And this is the button that rfkill was originally designed for.
> > Laptops with integrated WiFi cards from Ralink have a hardware button that don't send anything to
> > userspace (unless the ACPI event is read) and does not directly control the radio itself.
> 
> My take: if there is a button on your keyboard or laptop labeled "Kill
> my radio now", it _NEEDS_ to be somehow communicated to userspace what
> happened when the user just pressed it a second ago.  Personally, I
> don't particularly care how that happens, and I don't particularly care
> what the driver does.  But if the driver, or the hardware, decides that
> the button press means turning off the transmitter on whatever device
> that button is for, a tool like NetworkManager needs to know this
> somehow.  Ideally, this would be a HAL event, and HAL would get it from
> somewhere.
>
> The current situation with NM is unacceptable, and I can't do anything
> about it because there is no standard interface for determining whether
> the wireless card was disabled/enabled via rfkill.  I simply refuse to
> code solutions to every vendor's rfkill mechanism (for ipw, reading
> iwpriv or sysfs, for example).  I don't care how HAL gets the event, but
> when HAL gets the event, it needs to broadcast it and NM needs to tear
> down the connection and release the device.
> 
> That means (a) an event gets sent to userspace in some way that HAL can
> read it, and (b) the event is clearly associated with specific piece[s]
> of hardware on your system.  If HAL can't easily figure out what device
> the event is for, then the event is also useless to both HAL and
> NetworkManager and whatever else might use it.

This would be possible with rfkill and the ideas from Dmitry.
The vendors that have a button that directly toggle the radio, should
create an input device themselves and just send the KEY_RFKILL event when toggled.

All other types should use rfkill for the toggling handling, that way HAL only needs to
listen to KEY_RFKILL coming from the input devices that are associated to the keys.

> Again, I don't care how that happens, but I like the fact that there's
> renewed interest in getting this fixed.

Ivo
