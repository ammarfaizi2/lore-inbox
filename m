Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269137AbRGaBRQ>; Mon, 30 Jul 2001 21:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269139AbRGaBRE>; Mon, 30 Jul 2001 21:17:04 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:22277 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269137AbRGaBQu>; Mon, 30 Jul 2001 21:16:50 -0400
Date: Mon, 30 Jul 2001 22:16:54 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <20010731025700.G28253@emma1.emma.line.org>
Message-ID: <Pine.LNX.4.33L.0107302214210.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 31 Jul 2001, Matthias Andree wrote:
> On Thu, 26 Jul 2001, Linus Torvalds wrote:
>
> > Congratulations. You have been brainwashed by Dan Bernstein.

[snip fsync() on directory ... on second thought this isn't enough]

> Chase up to the root manually, because Linux' ext2 violates SUS
> v2 fsync() (which requires meta data synched BTW), as has been
> pointed out (and fixed in ReiserFS and ext3)?

Agreed.  fsync() on the file needs to write the meta
data, this includes the directory and (if needed)
the parent directories all the way up to the root.

> So, please tell my why Single Unix Specification v2 specifies EIO for
> rename. Asynchronous I/O cannot possibly trigger immediate EIO.

Crap. An asynchronous rename() can hit the situation
where it cannot read the disk when searching for the
directory it wants to move the file to.

rename(/from/a/b/file, /to/d/f/file) can fail when
the system gets an IO access on reading "d".

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

