Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbVKPJLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbVKPJLY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 04:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbVKPJLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 04:11:24 -0500
Received: from webmailv3.ispgateway.de ([80.67.16.113]:22246 "EHLO
	webmailv3.ispgateway.de") by vger.kernel.org with ESMTP
	id S1030248AbVKPJLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 04:11:22 -0500
Message-ID: <1132132269.437af7ad5f8c4@www.domainfactory-webmail.de>
Date: Wed, 16 Nov 2005 10:11:09 +0100
From: Clemens Ladisch <clemens@ladisch.de>
To: Markus Rechberger <mrechberger@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: snd_usb_audio
References: <d9def9db0511151518u10342e79r2a980683642051ff@mail.gmail.com>
In-Reply-To: <d9def9db0511151518u10342e79r2a980683642051ff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 213.238.46.206
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Rechberger wrote:
> finally the em28xx driver made it into the kerneltree, but one
> problem still remains
> the snd_usb_audio driver.
>
> The problem with the snd_usb_audio driver is that it only supports
> up to 10 isochronous packets.

This is packets per URB; we typically have 8 URBs.

> If people watch TV using such a framegrabber device and set audio
> to > 8000hz the video isoc transfer will break and the video will
> stop.

What exactly breaks?  Are you using playback or capture?

If there is an underrun when starting a _playback_ stream, then it's a
known bug that has been fixed in 2.6.15-rc1.

> regarding usbaudio.c (in 2.6.14):
> #define MAX_PACKS       10
> #define MAX_PACKS_HS    (MAX_PACKS * 8) /* in high speed mode */
>
> MAX_PACKS is the upper limit that is adjustable, the second one
> isn't used at all
>
> an easy hack would be to allow up to 100 packets but I also have a
> usb 1.1 soundblaster that might have problems with too many packets.
>
> The correct value for em28xx devices is around 80 packets.

Did you test this?  Capturing doesn't use MAX_PACKS.

> does anyone know more about the packet limitations on USB 1.1 and
> 2.0 devices?

The only limitation are the host controller drivers.


HTH
Clemens

