Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268240AbTBNIpv>; Fri, 14 Feb 2003 03:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268246AbTBNIpt>; Fri, 14 Feb 2003 03:45:49 -0500
Received: from host88-156.pool80116.interbusiness.it ([80.116.156.88]:21888
	"EHLO igor.opun.it") by vger.kernel.org with ESMTP
	id <S268240AbTBNIps>; Fri, 14 Feb 2003 03:45:48 -0500
Message-ID: <3E4CAEFC.92914AB3@libero.it>
Date: Fri, 14 Feb 2003 09:55:24 +0100
From: Abramo Bagnara <abramo.bagnara@libero.it>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en, it
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
References: <Pine.LNX.4.44.0302131452450.4232-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 13 Feb 2003, Davide Libenzi wrote:
> >
> > It does not have necessarily to be just another ioctl/fcntl, it can be a
> > write. About security, chages might be allowed only to the task that
> > created the fd, if you're concerned. It's not that someone will starve
> > w/out such functionality though.
> 
> I'd actually like to reserve writes to _sending_ signals. Especially if
> you have another process that listens in on the signals you get, it might
> want to also force the signals through.

This reminds me the unfortunate (and much needed) lack of an unified way
to send/receive out-of-band data to/from a regular fd.

Something like:
	oob = fd_open(fd, channel, flags);
	write(oob, ...)
	read(oob, ....)
	close(oob);

Don't you think it's time to introduce it and to start to avoid the
proliferation of different tricky ways to do the same things?

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy
