Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315734AbSEMEW7>; Mon, 13 May 2002 00:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315594AbSEMEW6>; Mon, 13 May 2002 00:22:58 -0400
Received: from daimi.au.dk ([130.225.16.1]:4728 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S315734AbSEMEW5>;
	Mon, 13 May 2002 00:22:57 -0400
Message-ID: <3CDF3F92.B3C3A18A@daimi.au.dk>
Date: Mon, 13 May 2002 06:22:42 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-12smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Peter Chubb <peter@chubb.wattle.id.au>, Elladan <elladan@eskimo.com>,
        " Jakob =?iso-8859-1?Q?=D8stergaard?=" <jakob@unthought.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
In-Reply-To: <Pine.GSO.4.21.0205121848080.27629-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Mon, 13 May 2002, Peter Chubb wrote:
> 
> > This is why in SVr4, struct cred is cloned at open time, and passed
> > down to each VFS operation.
> 
> That doesn't work for shared mappings over holes.  Unfortunately.
> Yes, credentials cache a-la 4.4BSD would help in many cases, but
> we have no reasonably credentials when kswapd writes a dirty page
> on disk.  It _can_ cause allocations.  And many processes might've
> touched that page until it finally got written out - which credentials
> would you use?

I'd rather have the check done when the page gets dirty in the
first place. Refuse the CoW if there is not diskspace to write
it back. Right now we can go beyond the diskspace we are allowed
to use and we will silently loose data if we go beyond the
available diskspace.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
