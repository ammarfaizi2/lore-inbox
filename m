Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270174AbRH1DNu>; Mon, 27 Aug 2001 23:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270199AbRH1DNk>; Mon, 27 Aug 2001 23:13:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41998 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270174AbRH1DN1>; Mon, 27 Aug 2001 23:13:27 -0400
Date: Mon, 27 Aug 2001 20:10:52 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <Pine.LNX.4.21.0108271954540.7385-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0108272007150.7856-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Aug 2001, Marcelo Tosatti wrote:
>
> It would be needed to pass a "READ or READA" flag to get_block_t calls
> too, which in turn would end up in a lot of code changes on the low level
> filesystems.

No, that's over-doing it. It's not worth it - you are better off just
taking the (rather smallish) risk that the meta-data isn't already cached.

In the long run, if you _really_ want to be clever, then yes. But in the
short run I doubt it's all that noticeable.

> I'm looking forward to "re-implement" the READA/WRITEA logic for 2.5.
>
> Do you have any idea/comments on how to do that with the smaller amount of
> pain ?

Just worry about data, not meta-data. That simplifies the whole issue a
_lot_, and means that you really only need to change readpage().

		Linus

