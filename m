Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269408AbRGaSic>; Tue, 31 Jul 2001 14:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269411AbRGaSiU>; Tue, 31 Jul 2001 14:38:20 -0400
Received: from [63.209.4.196] ([63.209.4.196]:11 "EHLO neon-gw.transmeta.com")
	by vger.kernel.org with ESMTP id <S269408AbRGaSiJ>;
	Tue, 31 Jul 2001 14:38:09 -0400
Date: Tue, 31 Jul 2001 09:41:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <20010731032104.O2650@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.33.0107310923010.1188-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Tue, 31 Jul 2001, Matti Aarnio wrote:
> >
> > Logical, isn't it?
>
>   No.  I don't see why I should opendir() a directory, fsync()
> that handle, and closedir() the handle.  I would definitely prefer:
>
>        lsync(dirpath)

Btw, you don't have to do opendir() - that just wastes time. Just do
something like

	int lsync(char *path)
	{
	        int err, fd;
	        fd = open(path, 0);
	        if (fd >= 0) {
	                err = fsync(fd);
	                close(fd);
	        }
	        return err;
	}

and you're done. But it won't do the symlink thing...

		Linus

