Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVGLPLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVGLPLa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 11:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVGLPIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 11:08:43 -0400
Received: from dvhart.com ([64.146.134.43]:19382 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261540AbVGLPIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 11:08:24 -0400
Date: Tue, 12 Jul 2005 08:08:22 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Friesen <cfriesen@nortel.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <15890000.1121180902@[10.10.2.4]>
In-Reply-To: <1121180403.2632.59.camel@mindpipe>
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050708214908.GA31225@taniwha.stupidest.org> <20050708145953.0b2d8030.akpm@osdl.org> <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe> <20050709203920.394e970d.diegocg@gmail.com> <1120934466.6488.77.camel@mindpipe>  <176640000.1121107087@flay> <1121113532.2383.6.camel@mindpipe>  <42D2D912.3090505@nortel.com> <1121128260.2632.12.camel@mindpipe>  <165840000.1121141256@[10.10.2.4]> <1121141602.2632.31.camel@mindpipe>  <188690000.1121142633@[10.10.2.4]> <1121178300.2632.51.camel@mindpipe>  <14170000.1121180207@[10.10.2.4]> <1121180403.2632.59.camel@mindpipe>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Lee Revell <rlrevell@joe-job.com> wrote (on Tuesday, July 12, 2005 11:00:02 -0400):

> On Tue, 2005-07-12 at 07:56 -0700, Martin J. Bligh wrote:
>> --Lee Revell <rlrevell@joe-job.com> wrote (on Tuesday, July 12, 2005 10:24:59 -0400):
>> 
>> > On Mon, 2005-07-11 at 21:30 -0700, Martin J. Bligh wrote:
>> >> Exactly what problems
>> >> *does* it cause (in visible effect, not "timers are less granular").
>> >> Jittery audio/video? How much worse is it?
>> > 
>> > Yes, exactly.  Say you need to deliver a frame of audio or video every
>> > 5ms. 
>> 
>> Ummm. that's a 200HZ refresh rate, is it not? That seems unreasonable 
>> (to a lay-person, as far as video goes).
>> 
> 
> Seems unreasonable now but things like HDTV actually have much tighter
> constraints than this.  And frame times this small are quite often used
> for audio, which admittedly is less affected by HZ because those devices
> generate their own interrupts.
> 
>> > You have a rendering thread and a display thread that communicate
>> > via FIFOs.  The main thread waits in select() for the next frame to
>> > complete rendering or for the deadline to expire.  That's next to
>> > impossible with HZ=100, because the best you can do is the deadline
>> > +-10ms.  With HZ=1000 it's no problem.
>> 
>> So if we have a 50HZ refresh rate, and a HZ rate of 250 or 300, it'll
>> work fine then, right? I know that's actually some error in the timers,
>> so it may be 2 or 3 ticks, not 1, but if we're running HZ at 5 or 6
>> times the frequency of video, presumably that'd still work fine?
> 
> Yes, for PAL/NTSC, but it's nice to be forward looking...

Well, looking forward, you'll have sub-HZ timers, so none of this will
matter. Actually, looking at the above, 150 seems perfectly reasonable
to me, but 300 seems to be close enough. I'll run some numbers on both.

>From your above email, I'm more convinced than ever that lowering HZ is
the right thing to do ...

M.


