Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288128AbSAMUm0>; Sun, 13 Jan 2002 15:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288144AbSAMUmQ>; Sun, 13 Jan 2002 15:42:16 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:27142 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288141AbSAMUmM>; Sun, 13 Jan 2002 15:42:12 -0500
Message-ID: <3C41EF9E.8D05D8F7@zip.com.au>
Date: Sun, 13 Jan 2002 12:35:42 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marius Gedminas <mgedmin@centras.lt>
CC: linux-kernel@vger.kernel.org
Subject: Re: Hard lock when mounting loopback file
In-Reply-To: <3C3F3267.7050103@actarg.com> <3C413BF0.24576AEC@zip.com.au>,
		<3C413BF0.24576AEC@zip.com.au> <20020113115230.GB1955@gintaras>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marius Gedminas wrote:
> 
> On Sat, Jan 12, 2002 at 11:49:04PM -0800, Andrew Morton wrote:
> > I don't know a thing about fat layout, but it appears that it uses a
> > linked list of blocks, and if that list ends up pointing back onto
> > itself, the kernel goes into an infinite loop in several places chasing
> > its way to the end of the list.
> >
> > The below patch fixed it for me, and I was able to mount and read
> > your filesystem image.
> >
> > Unless someone has a smarter fix, I'll send this to the kernel
> > maintainers in a week or two.
> 
> It seems to me that this patch will find only those infinite loops where
> the last link of the chain points to itself.  But there could be loops
> where the last link points to the middle of the chain.

Agree.

> Additional check on the number of followed links could be useful there.
> No chain should be longer than the number of clusters on the fs.
> Although on large FAT32 filesystems the number of clusters can be high,
> a very long loop is still better than an infinite one.  (In cases where
> we know the file size, this limit can be reduced to
> file_size/cluster_size + 1 links).

hmm..  OK, I'll take a look at that approach.

-
