Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315981AbSEVPYx>; Wed, 22 May 2002 11:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316141AbSEVPYw>; Wed, 22 May 2002 11:24:52 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36626 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315981AbSEVPYv>; Wed, 22 May 2002 11:24:51 -0400
Subject: Re: AUDIT: copy_from_user is a deathtrap.
To: pavel@suse.cz (Pavel Machek)
Date: Wed, 22 May 2002 15:54:33 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        akpm@zip.com.au (Andrew Morton), rusty@rustcorp.com.au (Rusty Russell),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020522141306.GB29028@atrey.karlin.mff.cuni.cz> from "Pavel Machek" at May 22, 2002 04:13:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AXVZ-0001up-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In such case, linus, here is your "reasonable" example. For PPro, it
> is faster to copy out-of-order, and if we wanted to use that for
> copy_to_user, you'd have your example.

I think there is a misunderstanding here.

Nothing in the standards says that

	write(pipe_fd, halfmappedbuffer, 2*PAGE_SIZE)


must return PAGE_SIZE on an error. What it seems to say is that it if an error
is reported then no data got written down the actual pipe itself. Putting
4K into the pipe then reporting Esomething is not allowed. Copying 4K into
a buffer faulting and erroring with Efoo then throwing away the buffer is
allowed
