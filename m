Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWACPWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWACPWN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 10:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWACPWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 10:22:12 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:51175 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932402AbWACPWK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 10:22:10 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Tue, 3 Jan 2006 15:22:06 +0000
User-Agent: KMail/1.9
Cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
References: <20050726150837.GT3160@stusta.de> <200601031441.27519.s0348365@sms.ed.ac.uk> <Pine.LNX.4.61.0601031548210.436@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601031548210.436@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601031522.06898.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 January 2006 14:50, Jan Engelhardt wrote:
> >The problem with using OSS compatibility, at least on this machine with
> > ALSA 1.0.9, is that if you use it you automatically lose the software
> > mixing capabilities of ALSA, so it really is less than ideal.
>
> Well, I am able to open /dev/dsp multiple times here without problems.
> (Is /dev/dsp soft- or hardmixing?)

As far as I'm aware, it depends on your hardware. For example, software mixing 
kicks in with zero configuration on most hardware that won't mix in hardware, 
e.g. my laptop's i810 audio.

[alistair] 15:18 [~] cat /proc/asound/cards
0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
                     Intel 82801DB-ICH4 with AD1981B at 0xa0100000, irq 11
1 [Modem          ]: ICH-MODEM - Intel 82801DB-ICH4 Modem
                     Intel 82801DB-ICH4 Modem at 0x3400, irq 11

I can successfully hear two mixed sources when I execute the following:

ogg123 -q --device=alsa09 01\ -\ Good\ Times\ Bad\ Times.ogg

And on another terminal

ogg123 -q --device=alsa09 01\ -\ Good\ Times\ Bad\ Times.og

This is ALSA soft mixing the two sources for me. Very nifty. However, if I 
throw an OSS into the mix (whilst these other two are playing).

[alistair] 15:20 [~/Music/Led Zeppelin - I] ogg123 -q --device=oss 01\ -\ 
Good\ Times\ Bad\ Times.ogg
Error: Cannot open device oss.

In fact, ogg123 hangs at this point (oh dear). If I try what you suggested and 
play two OSS sources, this doesn't work either:

ogg123 -q --device=oss 01\ -\ Good\ Times\ Bad\ Times.ogg

Works, but then:

ogg123 -q --device=oss 01\ -\ Good\ Times\ Bad\ Times.ogg
Error: Cannot open device oss

This is all a little OT for this thread, but it's certainly the case with 
alsa-lib-1.0.10 on 2.6.15-rc7. My card isn't capable of hardware mixing, 
yours might be (SBLive!/Audigy or something).

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
