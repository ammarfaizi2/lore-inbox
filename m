Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136170AbRDVPI2>; Sun, 22 Apr 2001 11:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136171AbRDVPIT>; Sun, 22 Apr 2001 11:08:19 -0400
Received: from [212.150.182.35] ([212.150.182.35]:30224 "EHLO
	exchange.guidelet.com") by vger.kernel.org with ESMTP
	id <S136170AbRDVPIN>; Sun, 22 Apr 2001 11:08:13 -0400
Message-ID: <003301c0cb46$7d50a400$910201c0@zapper>
From: "Alon Ziv" <alonz@nolaviz.org>
To: <linux-kernel@vger.kernel.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        "Alexander Viro" <viro@math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0104221026360.28681-100000@weyl.math.psu.edu>
Subject: Re: light weight user level semaphores
Date: Sun, 22 Apr 2001 18:08:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, I don't argue about that. (Well, almost--- see below...)
It's just that we need _some_ method for getting over the silly POSIX
FD-handling restrictions...  And the negative-FDs may be the solution.

(Note I said we 'can' declare other semantics; not 'should'.  So these
FDs can still be normal ones, just at the other end of the numbering
range...)

My misgivings are:
* There's no way to integrate other signalling mechanisms; e.g., we may
  wish for a 'wake-all-waiters' signaller, or for a 'timed-wait' that
  arrives via an FD and not as a signal
* a pipe is a more-or-less good semaphore; it may be too heavyweight,
  as it's forced to pass useless [in this case] info, and we can't
  control its wakeup order [although POSIX doesn't seem to require this]

[ Actually, I once had an idea of binding signals into an FD, so they can be
  'read' out of it...  with that, an alarm() is a 'timed-wait' waitable by
  poll() :-) ]

    -az

----- Original Message -----
From: "Alexander Viro" <viro@math.psu.edu>
To: "Alon Ziv" <alonz@nolaviz.org>
Cc: <linux-kernel@vger.kernel.org>; "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Sent: Sunday, April 22, 2001 16:31
Subject: Re: light weight user level semaphores


>
>
> On Sun, 22 Apr 2001, Alon Ziv wrote:
>
> > Well, that's the reason for my small-negative-integer semaphore-FD
idea...
> > (It won't support select() easily, but poll() is prob'ly good enough)
> > Still, there is the problem of read()/write()/etc. semantics; sure, we
can
> > declare that 'negative FDs' have their own semantics which just happen
to
> > include poll(), but it sure looks like a kludge...
>
> You _still_ don't get it. The question is not "how to add magic kernel
> objects that would look like descriptors and support a binch of
> ioctls, allowing to do semaphores", it's "do we need semaphores
> to be kernel-level objects". Implementation with pipes allows to avoid
> the magic crap - they are real, normal pipes - nothing special from
> the kernel POV. read(), write(), etc. are nothing but reading and writing
> for pipes.
>
>
>

