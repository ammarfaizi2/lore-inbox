Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSGMRaZ>; Sat, 13 Jul 2002 13:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSGMRaY>; Sat, 13 Jul 2002 13:30:24 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:29128 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315257AbSGMRaX>;
	Sat, 13 Jul 2002 13:30:23 -0400
Date: Sat, 13 Jul 2002 13:33:10 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Paul Menage <pmenage@ensim.com>
cc: LKML <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [RFC] dcache scalability patch (2.4.17) 
In-Reply-To: <E17TQeZ-0006OR-00@pmenage-dt.ensim.com>
Message-ID: <Pine.GSO.4.21.0207131328360.15574-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Jul 2002, Paul Menage wrote:

> - accessing foo/../bar, won't mark foo as referenced, even though it
> might be being referenced frequently. Probably not a common case for foo
> to be accessed exclusively in this way, but it could be fixed by marking
> a dentry referenced when following ".."

It certainly will.  Look - until ->d_count hits zero referenced bit is
not touched or looked at.  At all.

Look at the code.  There is _no_ aging for dentries with positive ->d_count.
They start aging only when after they enter unused_list...

