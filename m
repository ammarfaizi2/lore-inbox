Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277601AbRJRICM>; Thu, 18 Oct 2001 04:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277609AbRJRICD>; Thu, 18 Oct 2001 04:02:03 -0400
Received: from mail1-gui.server.ntli.net ([194.168.222.13]:40134 "EHLO
	mail1-gui.server.ntli.net") by vger.kernel.org with ESMTP
	id <S277601AbRJRIBw>; Thu, 18 Oct 2001 04:01:52 -0400
Date: Thu, 18 Oct 2001 09:02:22 +0100
From: Nick Craig-Wood <ncw@axis.demon.co.uk>
Message-Id: <200110180802.f9I82Mm21621@irishsea.craig-wood.com>
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <p_gortmaker@yahoo.com>, vonbrand@sleipnir.valparaiso.cl,
        willy tarreau <wtarreau@yahoo.fr>
Subject: Re: Making diff(1) of linux kernels faster 
In-Reply-To: <200110180025.f9I0Ps8t004928@sleipnir.valparaiso.cl>
In-Reply-To: <200110180025.f9I0Ps8t004928@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr> said:
> > Be very careful not to modify a multi-linked file, or
> > it will be damaged in all trees and won't be seen by
> > diff. your editor must unlink before saving.
> 
> Most don't. ed(1), vi(1) and emacs(1) are careful tro write to the very
> same file. jed(1) is the only outlier I'm aware of...

emacs does mv file file~ before saving file so the edited file will
not be linked byt the backup file will be.  You can stop it doing this
by setting backup-by-copying-when-linked.

$ echo "Test1" >> test1
$ ln test1 test2
$ emacs test2 # modify and save the file
$ ls -i test*
2491498 test1  2491500 test2  2491498 test2~

However as Horst von Brand noted if you try this with (standard) vi
you will edit the linked file which is the same behaviour as if you
set backup-by-copying-when-linked in emacs.

-- 
Nick Craig-Wood
ncw@axis.demon.co.uk
