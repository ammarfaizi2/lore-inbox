Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282693AbRLQTxn>; Mon, 17 Dec 2001 14:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282691AbRLQTxd>; Mon, 17 Dec 2001 14:53:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2573 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S282664AbRLQTxO>;
	Mon, 17 Dec 2001 14:53:14 -0500
Date: Mon, 17 Dec 2001 19:53:12 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT wierd behavior..
Message-ID: <20011217195312.K31706@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011217181840.G2431@athlon.random> <Pine.LNX.4.21.0112171757530.2812-100000@localhost.localdomain> <3C1E400B.A4D25F9D@zip.com.au> <9vlgsd$1b7$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9vlgsd$1b7$1@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Dec 17, 2001 at 07:26:05PM +0000
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 07:26:05PM +0000, Linus Torvalds wrote:
> Andrew Morton  <akpm@zip.com.au> wrote:
> >I take that to mean that if an error occurs, we return that
> >error regardless of how much was written.
> 
> I disagree.
> 
> Note that writing 15 characters out of 30 is also a "successful write" -
> it's just a _partial_ write.
> 
> >Which makes sense.  Consider this code:
> >
> >	open(file)
> >	write(100k)
> >	close(fd)
> >
> >if the write gets an IO error halfway through, it looks like
> >the caller never gets to hear about it at present.

	IIRC, SUS states that if a fatal error occurred causing the
partial write, that error will be returned on the next write or upon
close().  Thus:

	/* Smart program handles partial writes */
	write(100k); = 50k
	write(remaining 50k); = -1/ENOSPC|EIO|etc

or:

	/* Dumb program doesn't handle partial write */
	write(100k); = 50k
	close(fd); = -1/EIO
	
Joel

-- 

Life's Little Instruction Book #444

	"Never underestimate the power of a kind word or deed."

			http://www.jlbec.org/
			jlbec@evilplan.org
