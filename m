Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264096AbRGIRnl>; Mon, 9 Jul 2001 13:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264329AbRGIRnc>; Mon, 9 Jul 2001 13:43:32 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:64016 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264096AbRGIRnX>; Mon, 9 Jul 2001 13:43:23 -0400
Date: Mon, 9 Jul 2001 10:42:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <andrewm@uow.edu.au>,
        Abraham vd Merwe <abraham@2d3d.co.za>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: msync() bug
In-Reply-To: <Pine.LNX.4.21.0107091830090.1429-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0107091040440.14024-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Jul 2001, Hugh Dickins wrote:
> >
> > that cannot happen, remap_pte_range only maps invalid pages or reserved
> > pages.
>
> Anyone know why mmap() of /dev/mem behaves in this way - solves the
> problem Andrew raises, but surely that could be solved in a better way?
> Seems strange that mmap() cannot give you what read() and write() can.

Simple: we MUST NOT muck around with the page counts of random pages.

And if the pages aren't marked Reserved, the page counts _would_ get
corrupted by the VM page handling.

Ergo: you can only mmap Reserved pages (or you have to create a nice
mapping and allocate the pages properly, which in the case of /dev/mem is
obviously not a possibility)

		Linus

