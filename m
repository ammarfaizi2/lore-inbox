Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317815AbSG2Uc0>; Mon, 29 Jul 2002 16:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317874AbSG2Uc0>; Mon, 29 Jul 2002 16:32:26 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:270 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317815AbSG2UcZ>;
	Mon, 29 Jul 2002 16:32:25 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207292035.g6TKZgF161537@saturn.cs.uml.edu>
Subject: Re: Speaker twiddling [was: Re: Panicking in morse code]
To: pavel@suse.cz (Pavel Machek)
Date: Mon, 29 Jul 2002 16:35:42 -0400 (EDT)
Cc: arodland@noln.com (Andrew Rodland), wowbagger@sktc.net (David D. Hagood),
       linux-kernel@vger.kernel.org
In-Reply-To: <20020729174912.C38@toy.ucw.cz> from "Pavel Machek" at Jul 29, 2002 05:49:12 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:

> You might even add FSK checksum at each end of morse line ;-), if you realy
> want checksum. Plus it will sound cool. You should also play special melody
> at each start of repeat, to be more decoder-friendly [and it will also
> sound cool].

I looked into writing a decoder. It's really helpful to have a
fixed ratio of high/low states. It's also good to avoid silence.
The melody is important, so the user will know how long to
record, and to provide a way to sync up the decoder.

AMTOR w/ FEC is looking pretty good, but it needs the
character set fixed. (new shift states, 1 ASCII per 2 Baudot,
or a new code table) I hear there are extensions available
that would at least do lowercase and a bit more puctuation.

Not being a DSP expert, I'm using an FFT to get the power
spectrum for a small region. I slide this window along the
audio sample. I have pretty pictures of the bits now. :-)
It looks like I could pick a frequency with a wide range
of thresholds that give me the proper mark:space ratio,
then recover the clocking... It's not too hard I think, even
after going *.wav --> *.ogg --> *.au or misinterpreting the
data type.

So this is 100 baud. Guessing at good frequencies:
1940 HZ and 1500 HZ
1600 HZ and 1140 HZ
(wide separation needed because I'm not a DSP expert)
