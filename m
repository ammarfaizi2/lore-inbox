Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbWACWjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWACWjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 17:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWACWjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 17:39:07 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:48136 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S932535AbWACWjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 17:39:06 -0500
Message-ID: <43BAFD07.3030906@superbug.demon.co.uk>
Date: Tue, 03 Jan 2006 22:39:03 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051218)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Sailer <sailer@sailer.dynip.lugs.ch>
CC: Jaroslav Kysela <perex@suse.cz>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
References: <20050726150837.GT3160@stusta.de>	 <200601031522.06898.s0348365@sms.ed.ac.uk> <20060103160502.GB5262@irc.pl>	 <200601031629.21765.s0348365@sms.ed.ac.uk>	 <20060103170316.GA12249@dspnet.fr.eu.org>	 <1136312901.24703.59.camel@mindpipe> <1136316640.4106.26.camel@unreal>	 <Pine.LNX.4.61.0601032036250.9362@tm8103.perex-int.cz> <1136318187.4106.32.camel@unreal>
In-Reply-To: <1136318187.4106.32.camel@unreal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Sailer wrote:
> On Tue, 2006-01-03 at 20:37 +0100, Jaroslav Kysela wrote:
> 
> 
>>Anyone reported that? Also what's the exact bug symptom?
> 
> 
> Many people reported this on various mailing lists, but I'm not aware of
> any bugzilla/whatever ticket.
> 
> Problem seems to be that ALSA/OSS does not report the true HW sampling
> rate, but tries to do the sample rate conversion by itself, but
> apparently not doing it good enough for modem type applications.
> 
> Anyway I find it not a good idea of alsa to try to do sample rate
> conversion in kernel for OSS, as the native OSS drivers never did this,
> and it is useless for software (like soundmodem) that tries to find out
> the hardware rates in order to adapt to them. Kernel resampling badly
> interferes with this.
> 
> Tom
> 
> PS: I was too lazy to investigate this in depth, it was easier to just
> add a native ALSA driver to soundmodem.
> 

You can switch off ALSA's sample rate converter with a line like the 
following:
err = snd_pcm_hw_params_set_rate_resample(this->audio_fd, params, 0);

The zero switches off the alsa-lib resampler.

James

