Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbSLVUFj>; Sun, 22 Dec 2002 15:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbSLVUFj>; Sun, 22 Dec 2002 15:05:39 -0500
Received: from unthought.net ([212.97.129.24]:6121 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S265238AbSLVUFi>;
	Sun, 22 Dec 2002 15:05:38 -0500
Date: Sun, 22 Dec 2002 21:13:45 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Greg Stark <gsstark@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More tests [Was: Problem with read blocking for a long time on /dev/scd1]
Message-ID: <20021222201345.GG30634@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Greg Stark <gsstark@mit.edu>, linux-kernel@vger.kernel.org
References: <87adj0b3hj.fsf@stark.dyndns.tv> <87u1h799v5.fsf@stark.dyndns.tv> <87of7euj51.fsf_-_@stark.dyndns.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87of7euj51.fsf_-_@stark.dyndns.tv>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 22, 2002 at 11:13:14AM -0500, Greg Stark wrote:
> 
> I've done some more tests:
> 
> The problem still occurs with straight ide drivers, no ide-scsi
> 
> The problem still occurs with 2.4.20-ac2

Can you reproduce on 2.4.18 or 2.4.19-pre5 ?

AFAIK 2.4.X broke at 2.4.19-pre6 - something was changed that related to
the order in which read requests are scheduled.

I have a file-server here which also blocks on reads for as long as 5-10
seconds at a time - in particular when the nightly backup runs.

It's a PITA for those of us who're hit by it (imagine working in an
emacs that freezes up for 10 seconds every 10 minutes). But not a lot of
people have complained, so nobody has (again to my knowledge - please
correct if I'm mistaken) come up with a solution that was not just a
hack that for some reason which noone understands, seems to make the
problem appear less.

I would *so* love to be corrected on that one  ;)

> 
> I removed extraneous llseek syscalls from libdvdread, it's now reading purely
> sequentially and still failing. I doubt an llseek to the current location even
> gets through to the driver but I figured I would remove another variable.

Writes stall reads "almost indefinitely". It's a "feature".

If you can reproduce this in 2.4.18 (which was "invincible" as
file-server kernel for me, except that I needed newer IDE drivers for a
new Promise card and therefore had to make the switch), then I'm
completely mistaken and my ramblings have nothing to do with what you're
seeing.

Please try reproducing on 2.4.18, to confirm or deny.

> Question: Does the readahead parameter in hdparm affect accesses to the raw
> /dev/hdd device? Does it affect atapi cdrom access?

Nothing tunable cures the problem - if it is indeed the same problem you
are hit by.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
