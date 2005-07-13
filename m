Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbVGMUtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbVGMUtm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbVGMUsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:48:43 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:749 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S262768AbVGMUDg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:03:36 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: dtor_core@ameritech.net, Lee Revell <rlrevell@joe-job.com>,
       Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       David Lang <david.lang@digitalinsight.com>,
       Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Diego Calleja <diegocg@gmail.com>, azarah@nosferatu.za.org,
       akpm@osdl.org, cw@f00f.org, christoph@lameter.com
In-Reply-To: <341450000.1121283227@flay>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <200507122239.03559.kernel@kolivas.org>
	 <200507122253.03212.kernel@kolivas.org> <42D3E852.5060704@mvista.com>
	 <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com>
	 <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
	 <20050713184227.GB2072@ucw.cz>
	 <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
	 <1121282025.4435.70.camel@mindpipe>
	 <d120d50005071312322b5d4bff@mail.gmail.com>  <341450000.1121283227@flay>
Content-Type: text/plain
Organization: 
Message-Id: <1121284955.4999.501.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jul 2005 13:02:35 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 12:33, Martin J. Bligh wrote:
> --On Wednesday, July 13, 2005 14:32:02 -0500 Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > Hi,
> > 
> > On 7/13/05, Lee Revell <rlrevell@joe-job.com> wrote:
> >> On Wed, 2005-07-13 at 12:10 -0700, Linus Torvalds wrote:
> >> > So we should aim for a HZ value that makes it easy to convert to and from
> >> > the standard user-space interface formats. 100Hz, 250Hz and 1000Hz are all
> >> > good values for that reason. 864 is not.
> >> 
> >> How about 500?  This might be good enough to solve the MIDI problem.
> >> 
> > 
> > I would expect number of laptop users significatly outnumber ones
> > driving MIDI so as a default entry 250 makes more sense IMHO.
> 
> Could someone actually test it, rather than randomly guessing? ;-)

A Midi NoteOn command (ie: the equivalent of pressing a note on a
musical keyboard) transmitted through a physical Midi interface is
around 1 millisecond long with no running status, or 0.64 msec long with
running status going on (that means one note in between other note
on's)[*]. 

Scheduling of midi output should rely on a timing source that has a
better timing resolution than that. So, HZ=1000 let's us sort of
correctly schedule note-on (and similar sized events). It already
introduces jitter in two byte critical messages like MTC (Midi Time
code) Quarter Frame messages.

-- Fernando

[*] basic midi bit rate is 31250, one midi byte is 10 bits long,
commands can be one, two, three or more bytes long. Midi commands are
made of one status byte and optional data bytes, the status byte can be
ommited on multibyte messages for consecutive messages that are of the
same type (called "running status"). Real time commands such as Midi
Clock can be sent at any time, even in the middle of an already ongoing
midi message. 


