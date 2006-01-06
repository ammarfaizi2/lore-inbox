Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWAFMv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWAFMv1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 07:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWAFMv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 07:51:27 -0500
Received: from host1.compusonic.fi ([195.238.198.242]:15208 "EHLO
	minor.compusonic.fi") by vger.kernel.org with ESMTP
	id S1751404AbWAFMv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 07:51:26 -0500
Date: Fri, 6 Jan 2006 14:48:47 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: Gabor Gombas <gombasg@sztaki.hu>
Cc: Marcin Dalecki <martin@dalecki.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Lee Revell <rlrevell@joe-job.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Takashi Iwai <tiwai@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Tomasz Torcz <zdzichu@irc.pl>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <20060106103436.GB24929@boogie.lpds.sztaki.hu>
Message-ID: <Pine.LNX.4.61.0601061419560.2371@zeus.compusonic.fi>
References: <0D76E9E1-7FB0-41FD-8FAC-E4B3C6E9C902@dalecki.de>
 <1136486021.31583.26.camel@mindpipe> <E09E5A76-7743-4E0E-9DF6-6FB4045AA3CF@dalecki.de>
 <1136491503.847.0.camel@mindpipe> <7B34B941-46CC-478F-A870-43FE0D3143AB@dalecki.de>
 <1136493172.847.26.camel@mindpipe> <8D670C39-7B52-407C-8BDD-3478DB172641@dalecki.de>
 <9a8748490601051535s5e28fd81of6814088db7ccac@mail.gmail.com>
 <A1ECA9D1-29EB-4C44-A343-87B5EAAD4ADA@dalecki.de>
 <Pine.LNX.4.61.0601060302370.29362@zeus.compusonic.fi>
 <20060106103436.GB24929@boogie.lpds.sztaki.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Gabor Gombas wrote:

> On Fri, Jan 06, 2006 at 03:36:47AM +0200, Hannu Savolainen wrote:
> 
> > There are two very opposite approaches to do a sound subsystem. The ALSA 
> > way is to expose every single detail of the hardware to the applications 
> > and to allow (or force) application developers to deal with them. The OSS 
> > approach is to provide maximum device abstraction in the API level (by 
> > isolating the apps from the hardware as much as practically possible).
> 
> Well, then it is quite clear to me: you can build an OSS-like interface
> on top of ALSA, but you cannot build an ALSA-like interface on top of
> OSS.
This is not entirely correct. An alsa-lib compatible library can be 
implemented on top of OSS. It has already been done up to some degree for 
the audio and mixer parts (sequencer/MIDI support is under work just now).

I agree this is bit inpractical solution since ALSA has some 1500 library 
functions (and more to be added in the future). It is very difficult to 
test such library because just a limited subset of them has been used by 
any of the ALSA apps we were able to get working. In fact it looks like 
two ALSA apps (for similar purpose) may have been implemented using very 
different sets of ALSA functions (with relatively small overlap).

> This implies that an ALSA-like interface should be in the kernel,
> and an OSS-like interface should be implemented on top of it in
> userspace for those who do not need all the features. This way both
> camps are satisfied.
Or full ALSA library could be implemented on top of the OSS drivers. Or 
OSS can be modified to support ALSA's kernel level driver interface (which 
is not documented). Also in these ways both camps are satisfied.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
