Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbVLUXTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbVLUXTa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbVLUXTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:19:30 -0500
Received: from psionic.psi5.com ([212.112.229.180]:61376 "EHLO
	psionic8.psi5.com") by vger.kernel.org with ESMTP id S964953AbVLUXT3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:19:29 -0500
Message-ID: <43A9E2C9.7080300@hogyros.de>
Date: Thu, 22 Dec 2005 00:18:33 +0100
From: Simon Richter <Simon.Richter@hogyros.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051018)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Alessandro Zummo <azummo-lists@towertech.it>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org,
       lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] RTC subsystem
References: <20051220220022.4e9ff931@inspiron>	<43A94811.4010704@hogyros.de>	<20051221160712.2d322f42@inspiron>	<43A97CAF.50301@hogyros.de> <20051221184122.5253df01@inspiron>
In-Reply-To: <20051221184122.5253df01@inspiron>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig920050ECEE0F6B7E892C7EB0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig920050ECEE0F6B7E892C7EB0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

Alessandro Zummo schrieb:

>>It would be good to have a way to change which clock is the "primary" 
>>one from userspace later (userspace because this is clearly site policy).

>  If I'm not wrong, the RTC is usually queried at bootup
>  and written to on shutdown. If NTP mode is active, 
>  it is also written every 11 minutes.

A good ntpd will adjust the speed rather than write to the clock; the
ntpd shipped by most distributions can already handle multiple time sources.

I'm thinking of the case where a computer is not attached to a network
but needs accurate tim; in this case I'd give it a battery powered RTC
and a time signal receiver. As most time signals are low-bandwidth, they
may not carry full time information in each tick so it may take several
minutes to fully synchronize. In this case I'd like to use the battery
backed up clock first and switch later on when synchronized.

>  I guess /proc/driver/rtc will be deprecated sooner or
>  later. The /dev/rtc interface only supports one clock.
>  It can either be extended to have /dev/rtcX or we
>  can extend the sysfs one to allow clock updating.

/dev is the way to go IMO. As far as I've understood sysfs, it carries
meta information about devices and drivers only, the actual
communication then happens through device nodes still.

>  NTP mode could then be adjusted to update one or more
>  of the rtcs. Maybe each RTC could have an attribute
>  (let's say /sys/class/rtc/rtcX/ntp) which tells the
>  kernel whether to update it or not.

That's entirely a userspace thing. What the userspace needs to know from
the kernel is whether the clock is writable and whether its speed can be
adjusted.

>  -EPERM ? -EACCESS? :)

-EIO or -ENOSYS would also be possible options.

   Simon

--------------enig920050ECEE0F6B7E892C7EB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQCVAwUBQ6ni31Yr4CN7gCINAQIoEAQAghXWhuqJ/nWEJ8nDbyCrXd7pA+fo1ZHD
w7IJWzF84fMI46KjJB3lcQUybhOLfoqCqOngpW0fFh5fPm8wNwiJNPhB3tJEdOyT
HmPOcVQrqHQ1lESEQGXG+kqors1+KViMln5AHINQHm1U7cBmYfKTbtzigkH3zryP
U/Ia2PhAzNM=
=WGa4
-----END PGP SIGNATURE-----

--------------enig920050ECEE0F6B7E892C7EB0--
