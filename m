Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282691AbRLQUVT>; Mon, 17 Dec 2001 15:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282707AbRLQUVA>; Mon, 17 Dec 2001 15:21:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6159 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S282691AbRLQUU5>;
	Mon, 17 Dec 2001 15:20:57 -0500
Date: Mon, 17 Dec 2001 20:20:56 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT wierd behavior..
Message-ID: <20011217202056.L31706@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011217195312.K31706@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.33.0112171156380.1380-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112171156380.1380-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Dec 17, 2001 at 11:59:56AM -0800
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 11:59:56AM -0800, Linus Torvalds wrote:
> On Mon, 17 Dec 2001, Joel Becker wrote:
> > 	/* Smart program handles partial writes */
> > 	write(100k); = 50k
> > 	write(remaining 50k); = -1/ENOSPC|EIO|etc
> 
> We do this, if the error is "hard". And "fatal" implies hardness, so we're
> ok here.

	Right.  "hard" is also synonymous with "non-transient".

> > 	/* Dumb program doesn't handle partial write */
> > 	write(100k); = 50k
> > 	close(fd); = -1/EIO
> 
> But we're not doing this.

	IMHO we should be, and not just to comply with the letter of
SUS/Unix98.  SUS specifies this behavior because a synchronous write()
can return after copying data to the buffer cache.  However, the EIO can
happen later when the buffer cache is trying to flush to disk.  The only
way for an application to see this error is to either run O_SYNC or
receive it upon close().

Joel

-- 

"Every day I get up and look through the Forbes list of the richest
 people in America. If I'm not there, I go to work."
        - Robert Orben

			http://www.jlbec.org/
			jlbec@evilplan.org
