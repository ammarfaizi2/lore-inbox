Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVHBNDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVHBNDv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 09:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVHBNCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 09:02:15 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:18698 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S261509AbVHBM7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 08:59:46 -0400
Message-ID: <42EF6E3E.4060206@superbug.demon.co.uk>
Date: Tue, 02 Aug 2005 13:59:42 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.5 (Windows/20050711)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thorsten Knabe <linux@thorsten-knabe.de>
CC: Andrew Haninger <ahaning@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] Re: [2.6 patch] schedule obsolete OSS drivers for
 removal
References: <20050726150837.GT3160@stusta.de>  <Pine.LNX.4.61.0507281636040.20815@tek01.intern.thorsten-knabe.de>  <Pine.LNX.4.61.0507290849050.8400@tm8103.perex-int.cz>  <Pine.LNX.4.61.0507291735500.31150@tek01.intern.thorsten-knabe.de>  <20050731193922.GI3608@stusta.de> <105c793f0508010726dc12bc7@mail.gmail.com> <Pine.LNX.4.61.0508020110050.13611@tek01.intern.thorsten-knabe.de>
In-Reply-To: <Pine.LNX.4.61.0508020110050.13611@tek01.intern.thorsten-knabe.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Knabe wrote:

> On Mon, 1 Aug 2005, Andrew Haninger wrote:
>
>> Thorsten: Please remember to include the list(s) when emailing those
>> links/numbers. I'd like to be able to watch it, too, and add any
>> information that I can, rather than entering a duplicate bug.
>
>
> Hello.
>
> I have taken a closer look at the ALSA AD1816 sound driver during the 
> last weekend. Here are my findings:
>
> On vanilla Linux 2.6.12.3 and 2.6.13-rc4 modprobe hangs in D-state 
> when loading the snd-ad1816a module. No messages have been logged to 
> the syslog and the system is otherwise stable. Of course the sound 
> card is unusable.
> On Linux 2.6.8 (as shipped with current Debian Sarge), vanilla Linux 
> 2.6.10 and Linux 2.6.11.12 the module loads fine.
>
> I have done some tests with xmms(Debian), kphone(VoIP-Phone/Debian) 
> and iaxcomm(VoIP-Phone/self-made). Audio playback with xmms is always 
> fine using either ALSA or OSS emulation. Using OSS emulation with one 
> of the VoIP phones, playback and recording stop a few seconds after 
> the call is started. Using the ALSA interface with kphone works, but 
> there is a continuous clicking approximately 3 times per second. Also 
> audio latency is poor compared to the OSS driver. iaxcomm does not 
> support the ALSA audio interface, thus no problems here. :-)
> The native OSS driver is fine on all kernels with all tested 
> applications.
>
> Also the ALSA driver does not have an equivalent for the 
> "ad1816_clockfreq" option of the OSS driver. The AD1816 chip requires 
> a 33MHz reference clock, however some cards use a different (mostly 
> 32.125MHz) clock, thus the audio sample rate has to be corrected 
> before it is written to the hardware registers for proper playback and 
> recording speed.
>
> I have not filed any bug reports to the ALSA bug tracking system so 
> far, but will do so tomorrow and add the corresponding bug numbers to 
> this thread.
>
> Thorsten
>
It sounds to me that the best way to fix this is either:
a) Detect sound card subversion number and select different clock based 
on that.
b) Some how auto detect the clock, much like the intel8x0 driver does.
c) Provide a manual option like the OSS driver. (We should probably have 
this as well as (a) for the cases where (a) does not know about 
particular soundcard X yet.

James

