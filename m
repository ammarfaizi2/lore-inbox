Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbUKDSdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbUKDSdw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 13:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbUKDSdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:33:51 -0500
Received: from sartre.ispvip.biz ([209.118.182.154]:2511 "HELO
	sartre.ispvip.biz") by vger.kernel.org with SMTP id S262362AbUKDScJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 13:32:09 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.7
From: "Michael J. Cohen" <mjc@unre.st>
To: Ingo Molnar <mingo@elte.hu>
Cc: sboyce@blueyonder.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20041104142317.GA19476@elte.hu>
References: <41897119.6030607@blueyonder.co.uk>
	 <418988A6.4090902@cybsft.com> <20041104100634.GA29785@elte.hu>
	 <1099563805.30372.2.camel@localhost> <1099567061.7911.4.camel@localhost>
	 <20041104114545.GA3722@elte.hu>
	 <1099573171.7876.0.camel@optie.uni.325i.org>
	 <1099575262.8110.1.camel@optie.uni.325i.org>
	 <20041104140528.GA16604@elte.hu>
	 <1099577631.8090.4.camel@optie.uni.325i.org>
	 <20041104142317.GA19476@elte.hu>
Content-Type: text/plain
Date: Thu, 04 Nov 2004 13:31:57 -0500
Message-Id: <1099593117.7982.14.camel@optie.uni.325i.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 15:23 +0100, Ingo Molnar wrote:
> * Michael J. Cohen <mjc@unre.st> wrote:
> 
> > config attached, and I'll try booting with nmi_watchdog=1 next time it
> > locks.
> 
> i'd also suggest to turn CONFIG_RWSEM_DEADLOCK_DETECT on.
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

threw in your tcp_window oneliner mentioned in another thread and that
seemed to curb the lockups I was getting.  xmms+jackd in realtime mode
is getting some xruns during any kind of IDE activity. network isn't
quite as fussy.

http://325i.org/kernel/2.6.10-rc1-mm2-RT-V0.7.8
+tcp_window-jackd-diskio.dmesg is the dmesg to go with the following
jackd log.  during the entire test I used xmms-jack with an mp3 read
from an nfs source.

optie ~ # jackd -R -d alsa -P -HMm -z s -o 6   
jackd 0.99.0
Copyright 2001-2003 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

loading driver ..
creating alsa driver ... hw:0|-|1024|2|48000|0|6|hwmon|swmeter|-|32bit
control device hw:0
configuring for 48000Hz, period = 1024 frames, buffer = 2 periods
Couldn't open hw:0 for 32bit samples trying 24bit instead
Couldn't open hw:0 for 24bit samples trying 16bit instead
Noise-shaped dithering at 16 bits
**** alsa_pcm: xrun of at least 55.205 msecs
**** alsa_pcm: xrun of at least 7.287 msecs
**** alsa_pcm: xrun of at least 101.226 msecs
**** alsa_pcm: xrun of at least 21.544 msecs
**** alsa_pcm: xrun of at least 78.721 msecs
**** alsa_pcm: xrun of at least 278.089 msecs

to produce the disk load I ran 'emerge metadata'.

upon running bonnie++, I got:

**** alsa_pcm: xrun of at least 808.719 msecs
**** alsa_pcm: xrun of at least 702.963 msecs
**** alsa_pcm: xrun of at least 78.230 msecs
**** alsa_pcm: xrun of at least 78.351 msecs
**** alsa_pcm: xrun of at least 78.390 msecs
**** alsa_pcm: xrun of at least 77.898 msecs
**** alsa_pcm: xrun of at least 78.354 msecs
**** alsa_pcm: xrun of at least 78.394 msecs
**** alsa_pcm: xrun of at least 77.835 msecs
**** alsa_pcm: xrun of at least 19.489 msecs
**** alsa_pcm: xrun of at least 85.666 msecs
**** alsa_pcm: xrun of at least 14.937 msecs
**** alsa_pcm: xrun of at least 16.331 msecs
**** alsa_pcm: xrun of at least 2.079 msecs

bonnie++ measurements are at
http://325i.org/kernel/2.6.10-rc1-mm2-RT-V0.7.8
+tcp_window-jackd-diskio.bonnie++

finally I downloaded a 700MB avi to /dev/null from the box beside it:
100%[====================================>] 734,797,824   11.08M/s   ETA
00:00

0 xruns

then to /root:

100%[====================================>] 734,797,824   11.07M/s
ETA 00:00

0 xruns during download but 2 xruns while rm'ing the file:

**** alsa_pcm: xrun of at least 41.071 msecs
**** alsa_pcm: xrun of at least 66.074 msecs


I could only find tcp related info in dmesg. strange.

HTH,

Michael Cohen


