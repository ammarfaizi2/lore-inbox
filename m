Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315603AbSECIgn>; Fri, 3 May 2002 04:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315604AbSECIgm>; Fri, 3 May 2002 04:36:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:44979 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315603AbSECIgl>;
	Fri, 3 May 2002 04:36:41 -0400
Date: Fri, 3 May 2002 04:36:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Pavel Machek <pavel@ucw.cz>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing checks in exec_permission_light()
In-Reply-To: <20020503080356.GB232@elf.ucw.cz>
Message-ID: <Pine.GSO.4.21.0205030432050.18432-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 May 2002, Pavel Machek wrote:

> Hi!
> 
> > +	if (S_ISDIR(inode->i_mode) && capable(CAP_DAC_READ_SEARCH))
> > +		return 0;
> 
> Is this right? This means that root can do cat /, no? That does not
> seem like expected behaviour.

1) it's permission(..., MAY_EXEC)
2) in any case, root _can_ open "/" with O_RDONLY.  Always could.  That's
what you do for ls /, after all - open(2) followed by getdents(2).  Now,
read(2) will fail (check what ->read() for directories is set to), but
that has nothing to permission checks.

