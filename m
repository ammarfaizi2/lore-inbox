Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131276AbRCTWjR>; Tue, 20 Mar 2001 17:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131278AbRCTWjI>; Tue, 20 Mar 2001 17:39:08 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:13074 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131276AbRCTWix>; Tue, 20 Mar 2001 17:38:53 -0500
Date: Tue, 20 Mar 2001 22:37:56 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Doug Ledford <dledford@redhat.com>
cc: David Ford <david@blue-labs.org>, Peter Lund <firefly@netgroup.dk>,
        Pozsar Balazs <pozsy@sch.bme.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: esound (esd), 2.4.[12] chopped up sound -- solved
In-Reply-To: <3AB7BB59.9513514C@redhat.com>
Message-ID: <Pine.LNX.4.30.0103202159470.13996-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001, Doug Ledford wrote:

> Why would esd get a short write() unless it is opening the file in non
> blocking mode (which I didn't see when I was working on the i810 sound
> driver)?  If esd is writing to a file in blocking mode and that write is
> returning short, then that sounds like a driver bug to me.

Please quote chapter and verse.

I'm looking at http://www.opengroup.org/onlinepubs/7908799/xsh/write.html 
and cannot see anything which states that write may not return having 
written fewer data than it was asked to.

The only vaguely relevant text I see is...

	Write requests to a pipe or FIFO will be handled the same as a
	regular file with the following exceptions:

	<...>

	* If the O_NONBLOCK flag is clear, a write request may cause the 
	  thread to block, but on normal completion it will return
	  nbyte.

This being an _exception_ clearly implies that for file descriptors other 
than pipes and fifos, it is _not_ necessary to return nbyte on normal 
completion.

Applications (and also I believe glibc) which assume otherwise are, 
technically, broken. Despite being numerous.

-- 
dwmw2


