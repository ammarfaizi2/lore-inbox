Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282866AbRLQUwX>; Mon, 17 Dec 2001 15:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282845AbRLQUwQ>; Mon, 17 Dec 2001 15:52:16 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:14603 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S282866AbRLQUwI>; Mon, 17 Dec 2001 15:52:08 -0500
Message-ID: <3C1E5AEE.7FD79DF4@delusion.de>
Date: Mon, 17 Dec 2001 21:51:58 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Simon Kirby <sim@netnation.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill(-1,sig)
In-Reply-To: <Pine.LNX.4.33.0112141237470.3063-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> > Argh, I hate this.  I fail to see what progress a process could make if
> > it kills everything _and_ itself.  I frequently use "kill -9 -1" to kill
> > everything except my shell, and now I'll have to kill everything else
> > manually, one by one.
> 
> I do agree, I've used "kill -9 -1" myself.
> 
> However, let's see how problematic it is to try to follow it (in 2.5.x,
> not 2.4.x) and if people really complain.
> 
> Count one for the complaints, but I want more to overrule a published
> standard.


Hi,

This change also breaks my shutdown script (Slackware 8.0).
This script contains:

if [ "$1" != "fast" ]; then # shutdown did not already kill all processes
  killall5 -15
  sleep 5
  killall5 -9
fi

It never gets beyond that point, probably because the script itself is
zapped. According to killall5 manual the processes in its own session are
unaffected by this, but that doesn't seem to be entirely true.

Granted, reboots are rare with Linux, but having to fsck every time from
now on is not my notion of fun ;)

Regards,
Udo.
