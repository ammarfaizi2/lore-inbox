Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278818AbRKXRcC>; Sat, 24 Nov 2001 12:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278911AbRKXRbv>; Sat, 24 Nov 2001 12:31:51 -0500
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:42629 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S278818AbRKXRbh>; Sat, 24 Nov 2001 12:31:37 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de>
	<Pine.LNX.4.33L.0111241138070.4079-100000@imladris.surriel.com>
	<20011124103642.A32278@vega.ipal.net>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 24 Nov 2001 18:31:34 +0100
In-Reply-To: <20011124103642.A32278@vega.ipal.net> (Phil Howard's message of "Sat, 24 Nov 2001 10:36:42 -0600")
Message-ID: <tg8zcwgjnt.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Howard <phil-linux-kernel@ipal.net> writes:

> | That seems more like a case of "hard drives being pointless
> | for people wanting to store their data" ;)
> 
> Or at least "powering down IBM DTLA series hard drives is pointless
> for people wanting to store their data".

We have got a DTLA drive which shows the typical symptoms without
being powered down regularly.  The defective sectors simply appeared
during normal operation. But that's not the point, I'm pretty
convinced that the DTLA problems are not caused by aborted writes.

However, I'm scared by a major hard disk manufacturer using such a
faulty approach, and claiming it's reasonable.  Maybe you can gain
some performance this way, maybe the firmware is easier to write.  If
there's such a motivation, other manufacturers will follow and soon,
there won't be any reliably drives to buy for us (just being a bit
paranoid...).

> Now I can see a problem if the drive can't flush a write-back cache
> during the "power fade".  With some pretty big caches many drives
> have these days (although I wonder just how useful that is with OS
> caches being as good as they are),

They can reorder writes and eliminate dead writes, breaking journaling
(especially if the journal is on a different disk than the actual
data). ;-) In fact, the "cache" is probably just memory used for quite
a few different purposes: scatter/gather support, command queuing,
storing the firmware, and so on.

Emptying the caches in time is not a problem, BTW.  You just don't get
a full write in this case (and lose some data), but you shouldn't see
any bad sectors.

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
