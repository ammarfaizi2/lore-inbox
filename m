Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVHBAN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVHBAN6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 20:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVHBAN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 20:13:58 -0400
Received: from mail.thorsten-knabe.de ([82.141.44.28]:26887 "EHLO
	mail.thorsten-knabe.de") by vger.kernel.org with ESMTP
	id S261394AbVHBANv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 20:13:51 -0400
Date: Tue, 2 Aug 2005 02:13:43 +0200 (CEST)
From: Thorsten Knabe <linux@thorsten-knabe.de>
X-X-Sender: tek@tek01.intern.thorsten-knabe.de
To: Andrew Haninger <ahaning@gmail.com>
cc: Adrian Bunk <bunk@stusta.de>, Jaroslav Kysela <perex@suse.cz>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       linux-sound@vger.kernel.org
Subject: Re: [Alsa-devel] Re: [2.6 patch] schedule obsolete OSS drivers for
 removal
In-Reply-To: <105c793f0508010726dc12bc7@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0508020110050.13611@tek01.intern.thorsten-knabe.de>
References: <20050726150837.GT3160@stusta.de> 
 <Pine.LNX.4.61.0507281636040.20815@tek01.intern.thorsten-knabe.de> 
 <Pine.LNX.4.61.0507290849050.8400@tm8103.perex-int.cz> 
 <Pine.LNX.4.61.0507291735500.31150@tek01.intern.thorsten-knabe.de> 
 <20050731193922.GI3608@stusta.de> <105c793f0508010726dc12bc7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Report: SpamAssassin@thorsten-knabe.de
	Content analysis details:   (-5.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2005, Andrew Haninger wrote:

> Thorsten: Please remember to include the list(s) when emailing those
> links/numbers. I'd like to be able to watch it, too, and add any
> information that I can, rather than entering a duplicate bug.

Hello.

I have taken a closer look at the ALSA AD1816 sound driver during the last 
weekend. Here are my findings:

On vanilla Linux 2.6.12.3 and 2.6.13-rc4 modprobe hangs in D-state when 
loading the snd-ad1816a module. No messages have been logged to the syslog 
and the system is otherwise stable. Of course the sound card is unusable.
On Linux 2.6.8 (as shipped with current Debian Sarge), vanilla Linux 
2.6.10 and Linux 2.6.11.12 the module loads fine.

I have done some tests with xmms(Debian), kphone(VoIP-Phone/Debian) and 
iaxcomm(VoIP-Phone/self-made). Audio playback with xmms is always fine 
using either ALSA or OSS emulation. Using OSS emulation with one of the 
VoIP phones, playback and recording stop a few seconds after the call is 
started. Using the ALSA interface with kphone works, but there is a 
continuous clicking approximately 3 times per second. Also audio latency 
is poor compared to the OSS driver. iaxcomm does not support the ALSA 
audio interface, thus no problems here. :-)
The native OSS driver is fine on all kernels with all tested applications.

Also the ALSA driver does not have an equivalent for the 
"ad1816_clockfreq" option of the OSS driver. The AD1816 chip requires a 
33MHz reference clock, however some cards use a different (mostly 
32.125MHz) clock, thus the audio sample rate has to be corrected before it 
is written to the hardware registers for proper playback and recording 
speed.

I have not filed any bug reports to the ALSA bug tracking system so far, 
but will do so tomorrow and add the corresponding bug numbers to this 
thread.

Thorsten

-- 
___
  |        | /                 E-Mail: linux@thorsten-knabe.de
  |horsten |/\nabe                WWW: http://linux.thorsten-knabe.de
