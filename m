Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276595AbRI2TVP>; Sat, 29 Sep 2001 15:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276594AbRI2TVH>; Sat, 29 Sep 2001 15:21:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15631 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276595AbRI2TUz>; Sat, 29 Sep 2001 15:20:55 -0400
Date: Sat, 29 Sep 2001 12:21:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 VM, active cache pages, and OOM
In-Reply-To: <Pine.LNX.4.33L.0109291545570.19147-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0109291219240.8343-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Sep 2001, Rik van Riel wrote:
> On Sat, 29 Sep 2001, Linus Torvalds wrote:
>
> > (which basically says: we only mark the page accessed if we read the
> > _beginning_ of the page, or if we just did a seek to it)
>
> That should work for linear IO, but I fear what influence
> such a thing would have on eg. database indexes ;)

Well, for things that seek, the behaviour will be the same as it was
before: it will always mark the page accessed, because "file->f_reada"
will always be zero for the first read after a lseek.

That's why we have the "or if we just did a seek to it". You cannot _just_
test for "did we read the beginning of a page", because that fails for
seekers, whether database or otherwise.

		Linus

