Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbVBKV2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVBKV2L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 16:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVBKV2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 16:28:10 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:55218 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262345AbVBKV1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 16:27:35 -0500
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, "Jack O'Quin" <joq@io.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <20050203214133.GA27956@elte.hu>
References: <874qh3bo1u.fsf@sulphur.joq.us>
	 <1106796360.5158.39.camel@npiggin-nld.site> <87pszr1mi1.fsf@sulphur.joq.us>
	 <20050127113530.GA30422@elte.hu> <873bwfo8br.fsf@sulphur.joq.us>
	 <20050202111045.GA12155@nietzsche.lynx.com> <87is5ahpy1.fsf@sulphur.joq.us>
	 <20050202211405.GA13941@nietzsche.lynx.com>
	 <20050202212100.GA12808@elte.hu>
	 <20050202213402.GB14023@nietzsche.lynx.com>
	 <20050203214133.GA27956@elte.hu>
Content-Type: text/plain
Date: Fri, 11 Feb 2005 16:27:32 -0500
Message-Id: <1108157253.20365.71.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-03 at 22:41 +0100, Ingo Molnar wrote:
> > 
> > It's clever that they do that, but additional control is needed in the
> > future. jackd isn't the most sophisticate media app on this planet (not
> > too much of an insult :)) [...]
> 
> i think you are underestimating Jack - it is easily amongst the most
> sophisticated audio frameworks in existence, and it certainly has one of
> the most robust designs. Just shop around on google for Jack-based audio
> applications. What i'd love to see is more integration (and cooperation)
> between the audio frameworks of desktop projects (KDE, Gnome) and Jack.

JACK was not designed as a general purpose sound server, it's main goals
were sample accurate synchronization and low latency which a general
purpose desktop sound server does not need.  But, JACK does provide a
superset of the needed functionality - if you can do low latency you
should be able to handle high latency/buffering jut as easily, and
sample accurate sync will not break apps that don't need it.

The main obstacle to JACK-ifying everything is that it requires audio
apps to conform to the callback based JACK programming model.
JACK-ifying a complex app that expects to be able to read and write
audio whenever it wants to amounts to a complete rewrite.  But simpler
apps like XMMS can use a layer on top of JACK like the bio2jack library.

Anyway, Linspire (formerly L*nd*ws, formerly ...) will be using JACK as
the sound server in their next release.  And GNOME is moving to
gstreamer which can use JACK as a backend.

Bill has a good point, in that JACK is really just scratching the
surface as far as the myriad possibilities that good realtime support
will open up.  Apps like mplayer that use a broken single threaded
design which completely ignores the RT constraint inherent in AV
playback will be corrected for example.

Lee

