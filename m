Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWAFCWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWAFCWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbWAFCWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:22:54 -0500
Received: from host1.compusonic.fi ([195.238.198.242]:62822 "EHLO
	minor.compusonic.fi") by vger.kernel.org with ESMTP
	id S1751375AbWAFCWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:22:53 -0500
Date: Fri, 6 Jan 2006 04:20:13 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: Olivier Galibert <galibert@pobox.com>,
       Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>,
       Jaroslav Kysela <perex@suse.cz>, Pete Zaitcev <zaitcev@redhat.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Adrian Bunk <bunk@stusta.de>, Tomasz Torcz <zdzichu@irc.pl>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       ALSA development <alsa-devel@alsa-project.org>,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
In-Reply-To: <43BDB858.5060500@folkwang-hochschule.de>
Message-ID: <Pine.LNX.4.61.0601060348380.29362@zeus.compusonic.fi>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de>
 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
 <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl>
 <43BDA02F.5070103@folkwang-hochschule.de> <20060105234951.GA10167@dspnet.fr.eu.org>
 <43BDB858.5060500@folkwang-hochschule.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Joern Nettingsmeier wrote:

> shuffle 16 tracks of 24bit 48k audio in and out of the machine at a latency
> where a professional drummer will not complain, with routing options adequate
> for professional work, and then let's see how simple your API is.
This is nonsense. This is something where the API design cannot make any 
difference.

To get (say) 10 ms latencies you have to tell the sound subsystem 
to allocate to buffer that is smaller than 10 ms. This in turn means that 
the application must be able to run it's processing loop within less than 10 
ms with 100.000...0% confidence. This is true regardless of how advanced 
or primitive the audio subsystem (API) is.

What happens if some system load peak delays the application by 20 ms? The 
result is complete failure. What is the ALSA (API) feature OSS doesn't 
have that makes it able to predict what kind of output the application 
should have fed to the device during the (about) 20 ms period of silence? 

The fact is that there is nothing the audio subsystem can do to recover 
the situation. For this very simple reason the OSS API lacks everything 
that would be necessary to cope with this kind of problems.

After all the lowest possible audio latency depends on the level of real 
time response capabilities of the underlaying OS/hardware/application 
environment. If the app doesn't get the CPU right in time it will fail 
(believe or not).

If the system can fullfill the response time requirements then any sound 
subsystem will work equally well (unless they are seriously broken).

The sound subsystem implementations may have performance 
differences of few usecs. However they don't make one better than another 
in cases when the peak latencies are in millisecond range. In addition 
same devices have FIFO/bus delays of up to few msec byt even then 
advances in the audio subsystem/API design cannot help at all.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
