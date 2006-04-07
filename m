Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWDGJYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWDGJYe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 05:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWDGJYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 05:24:34 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:21910 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932398AbWDGJYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 05:24:33 -0400
Date: Fri, 7 Apr 2006 11:24:26 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Greg Stark <gsstark@mit.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pchdtv 3000 cx88 audio very very low level
Message-ID: <20060407092426.GA21330@rhlx01.fht-esslingen.de>
References: <8764lmnlcx.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8764lmnlcx.fsf@stark.xeocode.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 06, 2006 at 10:57:34PM -0400, Greg Stark wrote:
> 
> Is this video4linux list still active? I see very little traffic on it. Is
> there a better place for questions about v4l drivers for the pchdtv 3000 cx88
> NTSC tuner?
> 
> I have it working fine but the audio is extremely low level. Even if I boost
> the line-in level and the master output level to max on my sound card it's
> barely audible over the background static.
> 
> Is there something wrong with my card? Or with my drivers?
Since I once tweaked bttv for my card, I'm almost damn sure that this must
be an audio multiplexer (mux) issue. Many TV/tuner cards route their audio
output through incredibly many different types of multiplexer ICs, each
of which requires their own switch mask.
If the mux isn't configured properly, then audio will be switched off
completely except for possibly some very, very silent cross-channel speak.

IOW, you need to examine the driver sources of cx88xx, cx8800, cx88_alsa,
btcx_risc, tveeprom (?) for some multiplexer bit mask and tweak/twiddle that
for your tuner until you manage to hear something properly.

Oh, and:

> [ 5020.679548] tuner 2-0061: type set to 52 (Thomson DTT 7610 (ATSC/NTSC))

That module probably has a type= parameter. Experiment with that one until
you possibly even hear something properly, then try to fix type autodetection
for your card.

Andreas Mohr

-- 
No programming skills!? Why not help translate many Linux applications! 
https://launchpad.ubuntu.com/rosetta
(or alternatively buy nicely packaged Linux distros/OSS software to help
support Linux developers creating shiny new things for you?)
