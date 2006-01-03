Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWACT5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWACT5m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWACT5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:57:42 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:35754 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S932511AbWACT5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:57:41 -0500
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Thomas Sailer <sailer@sailer.dynip.lugs.ch>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0601032036250.9362@tm8103.perex-int.cz>
References: <20050726150837.GT3160@stusta.de>
	 <200601031522.06898.s0348365@sms.ed.ac.uk> <20060103160502.GB5262@irc.pl>
	 <200601031629.21765.s0348365@sms.ed.ac.uk>
	 <20060103170316.GA12249@dspnet.fr.eu.org>
	 <1136312901.24703.59.camel@mindpipe> <1136316640.4106.26.camel@unreal>
	 <Pine.LNX.4.61.0601032036250.9362@tm8103.perex-int.cz>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 20:56:26 +0100
Message-Id: <1136318187.4106.32.camel@unreal>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-08.tornado.cablecom.ch 32700; Body=3
	Fuz1=3 Fuz2=3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 20:37 +0100, Jaroslav Kysela wrote:

> Anyone reported that? Also what's the exact bug symptom?

Many people reported this on various mailing lists, but I'm not aware of
any bugzilla/whatever ticket.

Problem seems to be that ALSA/OSS does not report the true HW sampling
rate, but tries to do the sample rate conversion by itself, but
apparently not doing it good enough for modem type applications.

Anyway I find it not a good idea of alsa to try to do sample rate
conversion in kernel for OSS, as the native OSS drivers never did this,
and it is useless for software (like soundmodem) that tries to find out
the hardware rates in order to adapt to them. Kernel resampling badly
interferes with this.

Tom

PS: I was too lazy to investigate this in depth, it was easier to just
add a native ALSA driver to soundmodem.


