Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132353AbQLQWFw>; Sun, 17 Dec 2000 17:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132405AbQLQWFl>; Sun, 17 Dec 2000 17:05:41 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:10400 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132353AbQLQWFe> convert rfc822-to-8bit;
	Sun, 17 Dec 2000 17:05:34 -0500
Date: Sun, 17 Dec 2000 16:35:05 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jorg de Jong <j.e.s.de.jong@freeler.nl>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: test12: innd bug came back?
In-Reply-To: <3A3D06D3.93041108@freeler.nl>
Message-ID: <Pine.GSO.4.21.0012171626000.20573-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Dec 2000, Jorg de Jong wrote:

> > >On 13 Dec 2000, Henrik [ISO-8859-1] Størner wrote:
> > >
> > >> Just to add a "me too" on this. I didn't report when I saw it last week,
> 
> I'd like to second that. ME TOO !
> Since I switched to 2.4.0.test12 I again have the innd bug.
> ( well at least the same symptoms !)

Guys, what blocksize are you using? BTW, old testcase was
cat >foo.c <<EOF
#include <unistd.h>
main(argc,argv)
int argc;
char **argv;
{
	int fd;
	char c=0;
	truncate(argv[1], 10);
	fd = open(argv[1], 1);
	lseek(fd, 16384, 0);
	write(fd, &c, 1);
	close(fd);
}
EOF
gcc foo.c
./a.out /tmp/something_old
od -c </tmp/something_old
where something_old would be something not touched for long (i.e.
completely out of cache). Buggy kernels would leave much more than
10 non-zero bytes. Correct result is a file with bytes 11-16385 being zero.
I doubt that it would be the same beast, though...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
