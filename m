Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbTIQKmj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 06:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbTIQKmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 06:42:39 -0400
Received: from abort.boom.net ([205.159.115.34]:4421 "EHLO abort.boom.net")
	by vger.kernel.org with ESMTP id S261396AbTIQKmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 06:42:38 -0400
Date: Wed, 17 Sep 2003 03:42:37 -0700
From: Reza Naima <reza@reza.net>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: i810_audio bug (?)
Message-ID: <20030917104237.GB21397@boom.net>
Reply-To: Reza Naima <reza@reza.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-URL: http://www.reza.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I pass audio_samplerate = 32000 to 

       ioctl(afd, SNDCTL_DSP_SPEED, &audio_samplerate)

it changes my audio_sample rate from 32000 to 31627.

Now, this is causing problems with my downstream apps so I did some
investigating. Looking into i810_set_adc_rate() in i810_audio.c, 
there is some wierd math going on..

1) first, the original rate (32000) is converted to a new rate ..

	rate = (rate * clocking)/48000

	where clocking, in my case, is 48566. 

2) this new value is fed into newrate=ac97_set_adc_rate() which returns 
   the orignal sampling rate value (32000).  This number is then modified
   by the ratio

	dmabuf->rate = newrate * 48000 / clocking.

3) This results in the value 31627 that I'm seeing.  Now, is this the
   actual sample rate, or some internal value used to generate a 32000kbps
   sample rate?  If so, is it perhaps a bug that dmabuf->rate is being
   returned rather than newrate?


Thanks,
-Reza



