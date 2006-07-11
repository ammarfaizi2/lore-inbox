Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWGKQ5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWGKQ5m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWGKQ5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:57:42 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11141 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751007AbWGKQ5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:57:42 -0400
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
From: Lee Revell <rlrevell@joe-job.com>
To: Valdis.Kletnieks@vt.edu
Cc: Adam =?iso-8859-2?Q?Tla=B3ka?= <atlka@pg.gda.pl>,
       alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
       perex@suse.cz, alan@lxorguk.ukuu.org.uk
In-Reply-To: <200607111430.k6BEUUus006736@turing-police.cc.vt.edu>
References: <20060707231716.GE26941@stusta.de>
	 <p737j2potzr.fsf@verdi.suse.de> <1152458300.28129.45.camel@mindpipe>
	 <20060710132810.551a4a8d.atlka@pg.gda.pl>
	 <1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl>
	 <200607110209.k6B29psN007504@turing-police.cc.vt.edu>
	 <20060711081528.4d3ab197.atlka@pg.gda.pl>
	 <200607111430.k6BEUUus006736@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 12:57:43 -0400
Message-Id: <1152637064.21909.61.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 10:30 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 11 Jul 2006 08:15:28 +0200, Adam =?ISO-8859-2?B?VGxhs2th?= said:
> > Sorry to say but it is just not that way. Window manager is for managing windows
> > and it shouldn't depend on any audio system. It should use an external app using exec call
> > to play sounds (aplay, sox, wavplay etc.) configured by some config option.
> 
> So what you're saying is that something like 'esd' *is* needed.  (It's
> certainly silly to keep doing fork/exec for every little sound sample when
> you can just leave the app running and hand it requests...)

That approach also won't be reliable as it ignores the realtime
constraint that is inherent in audio playback.  It will probably work on
a fast/lightly loaded machine but will glitch out under load.

It's how GDM plays startup/shutdown sounds and it sucks - on shutdown
the sound is choppy.  You either need a dedicated daemon running
SCHED_FIFO or an RT thread for reliable audio playback.

Lee

