Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129945AbRBRT0R>; Sun, 18 Feb 2001 14:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130497AbRBRT0J>; Sun, 18 Feb 2001 14:26:09 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:51217 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S129945AbRBRT0B>; Sun, 18 Feb 2001 14:26:01 -0500
Date: Sun, 18 Feb 2001 19:25:53 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: <kuznet@ms2.inr.ac.ru>
cc: <linux-kernel@vger.kernel.org>, <davem@redhat.com>
Subject: Re: SO_SNDTIMEO: 2.4 kernel bugs
In-Reply-To: <200102181724.UAA24231@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.30.0102181843200.21465-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 18 Feb 2001 kuznet@ms2.inr.ac.ru wrote:

> Hello!
>
> > Unfortunately, I discovered a bug with SO_SNDTIMEO/sendfile():
>
> None of the options apply to sendfile(). It is not socket level
> operation. You have to use alarm for it.

Hi Alexey,

Actually sendfile() _does_ timeout using SO_SNDTIMEO. It just takes longer
to timeout because the kernel sendfile() page loop will (usually) need to
timeout a short write, and then timeout a 0 byte write.

So the actual timeout would be 2 * SO_SNDTIMEO.

Unfortunately, I'm seeing timeout at (I think) 3 * SO_SNDTIMEO, which I
can't account for.

Cheers
Chris

