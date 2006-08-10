Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161457AbWHJQso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161457AbWHJQso (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161453AbWHJQsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:48:43 -0400
Received: from tango.0pointer.de ([217.160.223.3]:12549 "EHLO
	tango.0pointer.de") by vger.kernel.org with ESMTP id S1161441AbWHJQsm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:48:42 -0400
Date: Thu, 10 Aug 2006 18:48:40 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/2] acpi,backlight: MSI S270 laptop support - driver
Message-ID: <20060810164839.GA29324@tango.0pointer.de>
References: <CFF307C98FEABE47A452B27C06B85BB60133DB99@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB60133DB99@hdsmsx411.amr.corp.intel.com>
Organization: .phi.
X-Campaign-1: ()  ASCII Ribbon Campaign
X-Campaign-2: /  Against HTML Email & vCards - Against Microsoft Attachments
X-Disclaimer-1: Diese Nachricht wurde mit einer elektronischen 
X-Disclaimer-2: Datenverarbeitungsanlage erstellt und bedarf daher 
X-Disclaimer-3: keiner Unterschrift.
User-Agent: Leviathan/19.8.0 [zh] (Cray 3; I; Solaris 4.711; Console)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10.08.06 12:15, Brown, Len (len.brown@intel.com) wrote:

Len,

> >drivers/video/backlight/
> >  It doesn't just do backlight control.
> 
> Perhaps the backlight part should live there.

Mhmm, that would mean I'd had to split up the driver. That would mean
duplicate code to a certain degree and two separate mini drivers with
very connected features. 

> >drivers/misc/
> >  Seems to be the last resort for everything that doesn't fit it
> >  otherwise.
> >
> >Unless anyone has a better idea I will move it to drivers/misc/, then.
> 
> Yeah, there is probably a better place than misc.

Hmm. As you might have noticed I already posted an updated driver a
few minutes ago which resides in drivers/misc. Is there any need to
move it once again?

> >I cannot map the "automatic brightness control" feature to the
> >backlight class driver, that's why I duplicated the brightness stuff
> >in /proc/acpi/s270/.
> 
> Better to extend the backlight code so that it can handle the
> special features of this platform than to duplicate brightness
> control in multiple places.

Hmm. Better not. That "automatic brightness control" feature and its
behaviour are very specific to this laptop. I don't see any value in
abstracting that. That would be quite a lot of overdesigning in my
eyes. In fact the driver disables this feature on load by default,
assuming that it was probably loaded to do the control in
software. 

> >> wlan and bluetooth indicators/controls need to appear under
> >> generic places under sysfs -- not under platform specific
> >> files under /proc/acpi.
> >
> >What are those "generic" places? I cannot think of any besides a
> >"platform" device.
> 
> They should appear as properties under their associated
> devices in /sys/devices tree rather than invening a new place.

My updated driver does this now. The attributes appear in
/sys/devices/platform/s270pf/.

> >Any ideas on that ec_transaction() patch I sent earlier?
> 
> I agree 100% that ec.c needs to be whacked.  Unfortunately
> there seem to be 3 people doing it at the same time,
> so we'll have to sort that out.

Whoever works on that: please make sure to offer a generic EC access
function similar to my ec_transaction() patch! Thanks!

Is there any timeframe for this EC rework? Is there any chance to get
my patch merged in the meantime? (Hmm, I guess i am little unpatient...)

> ps. Lennart, please understand that I didn't intend to be gruff.  I
> figured that by the quality of your work -- which is better than
> most -- that I'd go for an immediate reply, even though I was still
> holding a sharp pointed stick at the end of a 6-hour bug scrub
> marathon.

Oh, that's OK. I value a quick reply quite a lot. Thank you very much
for your quick review!

Thanks,
        Lennart

-- 
Lennart Poettering; lennart [at] poettering [dot] net
ICQ# 11060553; GPG 0x1A015CC4; http://0pointer.net/lennart/
