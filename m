Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbRFDXSz>; Mon, 4 Jun 2001 19:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262856AbRFDXSp>; Mon, 4 Jun 2001 19:18:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26126 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262824AbRFDXSl>; Mon, 4 Jun 2001 19:18:41 -0400
Subject: Re: disk-based fds in select/poll
To: pp@ludusdesign.com (Pierre Phaneuf)
Date: Tue, 5 Jun 2001 00:16:29 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B1C0EE9.9F8F58A4@ludusdesign.com> from "Pierre Phaneuf" at Jun 04, 2001 06:42:49 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1573aH-00068I-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, so while knowing about select "lying" about readability of a file
> fd, if I would stick a file fd in my select-based loop anyway, but would

You could fix select to return when the page was cachied and return EWOULDBLOCK
on reads if the page was not present to be honest. I don't think that would
actually break any apps, and the specs seem to allow it

> only try to read a bit at a time (say, 4K or 8K) would trigger
> readahead, yet finish quickly enough that I can get back to processing
> other fds in my select loop?

Probably

> Wouldn't that cause too many syscalls to be done? Or if this is actually
> the way to go without an actual thread, how should I go determining an
> optimal block size?

fs block size I suspect or small multiple thereof

