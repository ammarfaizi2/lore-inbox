Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBHQNM>; Thu, 8 Feb 2001 11:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbRBHQMy>; Thu, 8 Feb 2001 11:12:54 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:35346 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129055AbRBHQMe>; Thu, 8 Feb 2001 11:12:34 -0500
Date: Thu, 8 Feb 2001 17:11:26 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Pavel Machek <pavel@suse.cz>,
        Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.21.0102081202570.25475-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.3.96.1010208165626.9964C-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The problem is that aio_read and aio_write are pretty useless for ftp or
> > http server. You need aio_open.
> 
> Could you explain this? 

If the server is sending many small files, disk spends huge amount time
walking directory tree and seeking to inodes. Maybe opening the file is
even slower than reading it - read is usually sequential but open needs to
seek at few areas of disk.

And if you have one-threaded server using open, close, aio_read and
aio_write, you actually block the whole server while it is opening a
single file. This is not how async io is supposed to work.

Mikulas


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
