Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286409AbRLTWB6>; Thu, 20 Dec 2001 17:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286412AbRLTWBv>; Thu, 20 Dec 2001 17:01:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40977 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286409AbRLTWBe>; Thu, 20 Dec 2001 17:01:34 -0500
Date: Thu, 20 Dec 2001 13:59:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Lincoln Dale <ltd@cisco.com>
cc: Dan Kegel <dank@kegel.com>, <mingo@elte.hu>,
        "David S. Miller" <davem@redhat.com>, bcrl <bcrl@redhat.com>,
        billh <billh@tierra.ucsd.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>
Subject: Re: aio
In-Reply-To: <4.3.2.7.2.20011220133542.02c03ef0@171.69.24.15>
Message-ID: <Pine.LNX.4.33.0112201354420.1545-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Dec 2001, Lincoln Dale wrote:
>
> SIGIO sucks in the real-world for a few reasons right now, most of them
> unrelated to 'sigio' itself:

Well, there _is_ one big one, which definitely is fundamentally related to
sigio itself:

sigio is an asynchronous event programming model.

And let's face it, asynchronous programming models suck. They inherently
require that you handle various race conditions etc, and have extra
locking.

Note that "asynchronous programming model" is not the same as
"asynchronous IO completion". The former implies a threaded user space,
the latter implies threaded kernel IO.

And let's face it - threading is _hard_ to get right. People just don't
think well about asynchronous events.

It's much easier to have a synchronous interface to the asynchronous IO,
ie one where you do not have to worry about events happening "at the same
time".

SIGIO just isn't very nice. It's useful for some event notification (ie if
you don't actually _do_ anything in the signal handler), but let's be
honest: it's an extremely heavy notifier. Something synchronous like
"poll" or "select" will beat it just about every time (yes, they don't
scale well, but neither does SIGIO).

		Linus

