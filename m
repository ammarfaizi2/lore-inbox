Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbWEJWnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWEJWnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 18:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbWEJWnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 18:43:14 -0400
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:54799 "EHLO
	smtp-vbr3.xs4all.nl") by vger.kernel.org with ESMTP id S965049AbWEJWnO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 18:43:14 -0400
From: Hans Verkuil <hverkuil@xs4all.nl>
To: v4l-dvb-maintainer@linuxtv.org
Subject: Re: [v4l-dvb-maintainer] [PATCH] new driver for TLV320AIC23B
Date: Thu, 11 May 2006 00:42:34 +0200
User-Agent: KMail/1.8.91
Cc: Scott Alfter <salfter@ssai.us>, linux-kernel@vger.kernel.org
References: <44626150.9050804@ssai.us>
In-Reply-To: <44626150.9050804@ssai.us>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605110042.34815.hverkuil@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 May 2006 23:55, Scott Alfter wrote:
> Signed-off-by: Scott Alfter <salfter@ssai.us>
>
> It took a little bit longer than I thought, but the attached patch
> adds a driver for the TI TLV320AIC23B audio codec.  It implements
> analog audio capture at 32, 44.1, and 48 kHz (16-bit stereo).  The
> hardware is capable of more (it supports more sample rates and
> includes analog output), but in its current form, the driver works
> well with ivtv.
>
> The patch is attached; a test mailing indicated that Thunderbird
> attaches patches inline instead of encoded.  The patch is also
> available from this URL:
>
> http://alfter.us/files/linux-2.6.16-tlv320aic23b.patch
>
> Scott Alfter
> salfter@ssai.us

Hi Scott,

I've taken a quick look and I noticed a few things: first of all I 
recommend making a patch against the v4l-dvb repository as there have 
been a few changes compared to 2.6.16 that are relevant. In particular 
your device should start supporting VIDIOC_INT_G/S_AUDIO_ROUTING 
commands instead of VIDIOC_G/S_AUDIO. See the definition of these 
commands in v4l2-common.h for more info. This also implies that a 
media/tlv320aic23b.h header should be added (look at the existing 
headers such as wm8775.h).

I also noticed what seems to be a superfluous TODO in the 
VIDIOC_INT_AUDIO_CLOCK_FREQ implementation.

The enum (R7, R11, etc) isn't used and can be removed.

The input field of struct tlv320aic23b_state doesn't seem to be used, so 
that too can be removed.

You probably do not have to implement the VIDIOC_S_FREQUENCY command, 
that was wm8775 specific. I doubt it is necessary for this driver.

It is also a good idea to add support for older kernels to this driver 
(again, see the #if lines in the wm8775.c driver).

Hmm, well that seems to be it.

Thanks!

	Hans
