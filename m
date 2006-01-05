Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWAERUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWAERUU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 12:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbWAERUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 12:20:20 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:16316 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S1751055AbWAERUT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 12:20:19 -0500
In-Reply-To: <s5hmziaird8.wl%tiwai@suse.de>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de> <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl> <mailman.1136368805.14661.linux-kernel2news@redhat.com> <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl> <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D9B9456F-DBDC-4D77-B40C-4709CB728E96@dalecki.de>
Cc: =?UTF-8?Q?Tomasz_K=C5=82oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Jaroslav Kysela <perex@suse.cz>, Pete Zaitcev <zaitcev@redhat.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Adrian Bunk <bunk@stusta.de>, Olivier Galibert <galibert@pobox.com>,
       Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andi Kleen <ak@suse.de>, ALSA development <alsa-devel@alsa-project.org>,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: [OT] ALSA userspace API complexity
Date: Thu, 5 Jan 2006 18:19:48 +0100
To: Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-01-05, at 17:14, Takashi Iwai wrote:
>
> Because OSS API doesn't cover many things.  For example,
>
> - PCM with non-interleaved formats
> - PCM with 3-bytes-packed 24bit formats
>
> These functions are popluar on many sound devices.
>
> In addition, imagine how you would implement the following:
>
> - Combination of multiple devices
> - Split of channels to concurrent accesses
> - Handling of floating pointer samples
> - Post/pre-effects (like chorus/reverb)
>
> Forcing OSS API means to force to process the all things above in
> the kernel.  I guess many people would disagree with it.

Not at all. What a sane system would do would be the following:

1. Provide kernel devices, which are supposed to be used by a single  
user space helper
daemon claiming them once and for ever. Those would expose the  
extensive low level hardware interface
which is required to implement this kind of processing. Those  
controlling devices would be basically
accessible by the root user.

2. Provide kernel devices, which are supposed to be used by consumer  
applications. Those would
be basically just engaged in the data lifting between the user space  
application
the kernel and the processing daemon application.

Very much a design similar what can be found in the area of terminal  
support where there is a distinction
between a pseudo tty and a tty driver. Actually if one thinks about  
it the sound output and feeding *should* be associated with a  
terminal device. Keyboard/Micro Display/Speakers - pretty much the  
same data flow.

Very much the same as the relation between the ethernet interface  
card drivers and the netowork stack support.

No the alsa mess just basically hurrying up to map the hardware  
facilities as primitively as possible in to user space for messing  
around inside some "library" which is supposed to do wonders.
