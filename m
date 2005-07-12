Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVGLVAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVGLVAw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVGLVAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:00:45 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11689 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262400AbVGLU6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:58:48 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: "Kjetil Svalastog Matheussen <k.s.matheussen@notam02.no>" 
	<k.s.matheussen@notam02.no>,
       Chris Friesen <cfriesen@nortel.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
In-Reply-To: <188690000.1121142633@[10.10.2.4]>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
	 <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe>
	 <20050709203920.394e970d.diegocg@gmail.com>
	 <1120934466.6488.77.camel@mindpipe>  <176640000.1121107087@flay>
	 <1121113532.2383.6.camel@mindpipe>  <42D2D912.3090505@nortel.com>
	 <1121128260.2632.12.camel@mindpipe>  <165840000.1121141256@[10.10.2.4]>
	 <1121141602.2632.31.camel@mindpipe>  <188690000.1121142633@[10.10.2.4]>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 16:58:44 -0400
Message-Id: <1121201925.10580.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 21:30 -0700, Martin J. Bligh wrote:
> Some sort of comprimise has to be struck for now, until we get sub-HZ
> timers. I'd prefer 100, personally (I had that set as default in my tree
> for a long time). Some people would prefer 1000 or even more, maybe.
> 250/300 seems like a reasonable comprimise to me. Exactly what problems
> *does* it cause (in visible effect, not "timers are less granular").
> Jittery audio/video? How much worse is it?

OK, here's a real world example, taken straight from the linux-audio-dev
list today.

Lee

Lee Revell <rlrevell@joe-job.com> :
> On Tue, 2005-07-12 at 20:57 +0200, Kjetil Svalastog Matheussen wrote:
>> E-radium has been tested with both the 2.4 kernel and the 2.6 kernel
>> and with a ~1GhZ machine and a ~2ghz machine. (A 2.4 kernel with a
>> 100hz resolution timer will proably not work very nice though.)
>
> Can you please explain why 100HZ would be a problem for your app?  Right
> now the kernel people are trying to change the default HZ for 2.6 to
> 250.  I have told them that this is insane but they seem inclined to do
> it anyway.
>

The program use poll to sleep. If the resolution of the kernel is 100Hz,
there would sometimes be a too long delay of up to 10ms (and probably beyond)
before the program is woken up,  and before a midi message is sent,
which can cause music to stutter.

Simple as that. :-)

> If you can provide more examples of apps that would be broken by this
> change maybe we can convince them not to change it.
>

Hmm, mplayer I guess...
Don't know how muse, rosegarden, seq24 etc. handles timing...
But all midi-sequencers that doesn't use /dev/rtc could suffer. (?)


