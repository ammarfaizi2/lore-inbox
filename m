Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131955AbQL1WMh>; Thu, 28 Dec 2000 17:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132027AbQL1WM0>; Thu, 28 Dec 2000 17:12:26 -0500
Received: from hermes.mixx.net ([212.84.196.2]:18444 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S131955AbQL1WMJ>;
	Thu, 28 Dec 2000 17:12:09 -0500
Message-ID: <3A4BB303.69AF7E64@innominate.de>
Date: Thu, 28 Dec 2000 22:39:15 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: test13-pre5
In-Reply-To: <Pine.LNX.4.21.0012281637200.12364-100000@freak.distro.conectiva> <Pine.LNX.4.10.10012281243010.788-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>  - global dirty list for global syn(). We don't have one, and I don't
>    think we want one. We could add a few lists, and split up the active
>    list into "active" and "active_dirty", for example, but I don't like
>    the implications that would probably have for the LRU ordering.

This has been the subject of a lot of flam^H^H^H^H discussion on
#kernelnewbies about this and it's still an open question.  The only way
to see if a separate active_dirty hurts or helps is to try it.  Later.
:-)

I don't see how a separate active_dirty list can hurt LRU ordering.  We
could still take the pages off the two lists in the same order we did
with one list if we wanted to, or at least, statistically the same in
turns of number, age, time since entering the list, etc.  That better
not cause radically different or undesireable behaviour or something is
really broken.

By breaking active into two lists we'd get a very interesting tuning
parameter to play with: the relative rate at which pages are moved from
active to inactive.  Beyond that, the active_dirty list could be pressed
into service quite easily as a page-oriented version of kflushd, and
would obviously be useful as a global sync list.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
