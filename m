Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135425AbRAQTdK>; Wed, 17 Jan 2001 14:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135522AbRAQTdA>; Wed, 17 Jan 2001 14:33:00 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:60946 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135556AbRAQTcs>; Wed, 17 Jan 2001 14:32:48 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Is sendfile all that sexy?
Date: 17 Jan 2001 11:32:35 -0800
Organization: Transmeta Corporation
Message-ID: <944s0j$9lt$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.30.0101171454340.29536-100000@baphomet.bogo.bogus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.30.0101171454340.29536-100000@baphomet.bogo.bogus>,
Ben Mansell  <linux-kernel@slimyhorror.com> wrote:
>On 14 Jan 2001, Linus Torvalds wrote:
>
>> And no, I don't actually hink that sendfile() is all that hot. It was
>> _very_ easy to implement, and can be considered a 5-minute hack to give
>> a feature that fit very well in the MM architecture, and that the Apache
>> folks had already been using on other architectures.
>
>The current sendfile() has the limitation that it can't read data from
>a socket. Would it be another 5-minute hack to remove this limitation, so
>you could sendfile between sockets? Now _that_ would be sexy :)

I don't think that would be all that sexy at all.

You have to realize, that sendfile() is meant as an optimization, by
being able to re-use the same buffers that act as the in-kernel page
cache as buffers for sending data. So you avoid one copy.

However, for socket->socket, we would not have such an advantage.  A
socket->socket sendfile() would not avoid any copies the way the
networking is done today.  That _may_ change, of course.  But it might
not.  And I'd rather tell people using sendfile() that you get EINVAL if
it isn't able to optimize the transfer.. 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
