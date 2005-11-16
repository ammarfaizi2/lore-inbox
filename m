Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbVKPLHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbVKPLHW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 06:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbVKPLHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 06:07:21 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:37625 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030277AbVKPLHU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 06:07:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AE/suS5EcwCew2WcaMCki3d3L45WvQSlQpX1fWubNuS7dRvBBybTIvZlhWbbNE3LNcmBBtKYlHjEc76SuL/1gX75PNODR5CSw++oS8s6gm7tUXfEPItO0P2ziTwZCbFmB1pYsDslOyB1cmvbulVl/HA4qDM7OyfmNFtW6d3nS+c=
Message-ID: <d9def9db0511160307v4f0ff3bv805fe20b339dce80@mail.gmail.com>
Date: Wed, 16 Nov 2005 12:07:19 +0100
From: Markus Rechberger <mrechberger@gmail.com>
To: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_usb_audio
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1132132269.437af7ad5f8c4@www.domainfactory-webmail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d9def9db0511151518u10342e79r2a980683642051ff@mail.gmail.com>
	 <1132132269.437af7ad5f8c4@www.domainfactory-webmail.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/05, Clemens Ladisch <clemens@ladisch.de> wrote:
> Markus Rechberger wrote:
> > finally the em28xx driver made it into the kerneltree, but one
> > problem still remains
> > the snd_usb_audio driver.
> >
> > The problem with the snd_usb_audio driver is that it only supports
> > up to 10 isochronous packets.
>
> This is packets per URB; we typically have 8 URBs.
>
> > If people watch TV using such a framegrabber device and set audio
> > to > 8000hz the video isoc transfer will break and the video will
> > stop.
>
> What exactly breaks?  Are you using playback or capture?
>

the video isoc transfer screws up, finally it even stops. submitting
the video isoc urbs starts to fail.

> If there is an underrun when starting a _playback_ stream, then it's a
> known bug that has been fixed in 2.6.15-rc1.
>

it's playback, I'll test the release canditate tonight hopefully it's solved.

> > regarding usbaudio.c (in 2.6.14):
> > #define MAX_PACKS       10
> > #define MAX_PACKS_HS    (MAX_PACKS * 8) /* in high speed mode */
> >
> > MAX_PACKS is the upper limit that is adjustable, the second one
> > isn't used at all
> >
> > an easy hack would be to allow up to 100 packets but I also have a
> > usb 1.1 soundblaster that might have problems with too many packets.
> >
> > The correct value for em28xx devices is around 80 packets.
>
> Did you test this?  Capturing doesn't use MAX_PACKS.
>

yes I tested this regarding the sniffed windows logfile 80 would
probably the best value for it, the stream didn't break with that
value actually. as I already wrote it's playback.

> > does anyone know more about the packet limitations on USB 1.1 and
> > 2.0 devices?
>
> The only limitation are the host controller drivers.
>
ok thanks so far!

Markus
