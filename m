Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267854AbTAHTjf>; Wed, 8 Jan 2003 14:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267859AbTAHTjf>; Wed, 8 Jan 2003 14:39:35 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:54223 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S267854AbTAHTjd>; Wed, 8 Jan 2003 14:39:33 -0500
Date: Thu, 09 Jan 2003 08:48:03 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Wolfgang Fritz <wolfgang.fritz@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: [Asterisk] DTMF noise
Message-ID: <70200000.1042055283@localhost.localdomain>
In-Reply-To: <3E1C4872.7080508@gmx.net>
References: <D6889804-2291-11D7-901B-000393950CC2@karlsbakk.net>
 <3E1BD88A.4080808@users.sf.net> <3E1C1CDE.8090600@sktc.net>
 <3E1C4872.7080508@gmx.net>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, January 08, 2003 16:49:06 +0100 Wolfgang Fritz 
<wolfgang.fritz@gmx.net> wrote:


> That is done in the isdn_audio DTMF detection but did not work very well
> with a number of phone sets I tested which seem to generate DTMF tones
> with strong harmonics. They may be out of spec but they exist.

Distortion :-)  Unfortunately, this stuff is cheap analog and even harmonic 
distortion will create havoc with that algorithm.

By the way, if you happened to be trying this with Quicknet hardware, there 
is a major overhaul to the driver coming that reduces the distortion levels 
in the analog stages of the hardware immensely.  (I suspect not as the 
thread is about isdn)

> I have a patch which adds a simple energy comparison and some
> plausablility checks to the DTMF eval code but does not look at the
> harmonics. That improved the detection with above phone sets.
>
> Maybe it would be better to reenable harmonic checks but comparing
> harmonic levels to the level of the fundamental instead of using
> absolute values as in the present implementation.

It certainly would.  And be relatively generous about the relative amount 
of harmonic allowed; something like 30%.  If you use absolute levels, 
you're at the mercy of noise and level calibration errors, both of which 
you have to assume are present.  If you require the relative level to be 
too low, you're at the mercy of distortion.

> OTOH I don't think its a good approach to check harmonics anyway but to
> check other non DTMF frequencies in the main speech band and only accept
> a DTMF if a DTMF frequency pair is present but no signal on the non DTMF
> frequencies (no signal = xxx dB below the detected DTMF levels).
>
> There exists a long text about DTMF detection somewhere on the net (I may
> have the link in the office but I'm on vacation now). What I remember is
> that a "correct" DTMF detection requires much more computing power as the
> present i4l implementation needs (much longer audio samples for the
> goertzel filter, a larger number of frequencies to check) and a standard
> test procedure with a lot of test cases which are not available to mortal
> humans (audio tapes from Bellcore IIRC)

There is a pretty good text linked in the source :-)

It's also near the top of a google for goertzel filter dtmf.

What I don't get is why the kernel links to this text, but implements one 
of the algorithms that the conclusion of that paper rejects as unable to 
satisfy the standard for DTMF detection?  Maybe the original implementor 
wanted to avoid doing matrix math in the kernel, or couldn't understand 
what to do.  The best algorithm was only twice as expensive in CPU, for 
dramatically better reliability and standards compliance.

Andrew


