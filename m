Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752541AbWAGO56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbWAGO56 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 09:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbWAGO56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 09:57:58 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:61377 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S1751404AbWAGO55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 09:57:57 -0500
In-Reply-To: <s5hace8i0yd.wl%tiwai@suse.de>
References: <20050726150837.GT3160@stusta.de> <F082489C-B664-472C-8215-BE05875EAF7D@dalecki.de> <Pine.LNX.4.61.0601051154500.21555@yvahk01.tjqt.qr> <0D76E9E1-7FB0-41FD-8FAC-E4B3C6E9C902@dalecki.de> <1136486021.31583.26.camel@mindpipe> <E09E5A76-7743-4E0E-9DF6-6FB4045AA3CF@dalecki.de> <1136491503.847.0.camel@mindpipe> <7B34B941-46CC-478F-A870-43FE0D3143AB@dalecki.de> <1136493172.847.26.camel@mindpipe> <8D670C39-7B52-407C-8BDD-3478DB172641@dalecki.de> <9a8748490601051535s5e28fd81of6814088db7ccac@mail.gmail.com> <A1ECA9D1-29EB-4C44-A343-87B5EAAD4ADA@dalecki.de> <Pine.LNX.4.61.0601060302370.29362@zeus.compusonic.fi> <s5hace8i0yd.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <347855E0-B0CD-49F5-89F0-B3D599B6E712@dalecki.de>
Cc: Hannu Savolainen <hannu@opensound.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, Lee Revell <rlrevell@joe-job.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Adrian Bunk <bunk@stusta.de>,
       Tomasz Torcz <zdzichu@irc.pl>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Sat, 7 Jan 2006 15:57:28 +0100
To: Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-01-07, at 15:09, Takashi Iwai wrote:
>
> In the implementation of OSS API, there is a clear bottleneck: you
> have to implement everthing in the kernel level because of its
> definition.  Remember that the original thread started from the
> reduction of the kernel codes.  Putting more stuff which could be done
> better in user-space is a major drawback, IMO.

One point - there isn't that much to be done inside the kernel for  
the realm
of a generic sound driver. Not if you compare it with other sub  
systems like the SCSI host
controller layer or WiFi protocols for example. BTW. By your argument  
the encryption doesn't
belong in to the kernel as well. In fact one should go even further  
and compare sound
facilities with the *whole* block device layer for example. Mixing  
and *even* resampling
data streams are quite formidable tasks from an algorithmic point of  
view if done properly and not just applying the square transformation  
window as in simple averaging methods one encounters so frequently!.
However let me assure you that it would by no way result in that many  
code lines as in
typical decisive protocol code implementations.

A whole complex cross correlation containing a butterfly FFT core for  
example doesn't take
much more then just about 500 lines of C code. And it's FAST.  
Basically hitting DRAM speed.
Thus technically it's nowadays complete utter nonsense to offload it  
to some additional hardware or to
copy the data for processing in to user space and back.
