Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319284AbSIKS7W>; Wed, 11 Sep 2002 14:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319290AbSIKS7W>; Wed, 11 Sep 2002 14:59:22 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:14853 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S319284AbSIKS7U>; Wed, 11 Sep 2002 14:59:20 -0400
Date: Wed, 11 Sep 2002 21:03:37 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Xuan Baldauf <xuan--lkml@baldauf.org>, linux-kernel@vger.kernel.org,
       Reiserfs List <reiserfs-list@namesys.com>
Subject: Re: Heuristic readahead for filesystems
Message-ID: <20020911190337.GG14900@louise.pinerecords.com>
References: <3D7F647B.1E0707FB@baldauf.org> <Pine.LNX.4.44L.0209111340060.1857-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0209111340060.1857-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 16 days, 22:08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I wonder wether Linux implements a kind of heuristic
> > readahead for filesystems:
> 
> > If an application did a stat()..open()..read() sequence on a
> > file, it is likely that, after the next stat(), it will open
> > and read the mentioned file. Thus, one could readahead the
> > start of a file on stat() of that file.
> 
> > Example: See this diff strace:
> 
> Your observation is right, but I'm not sure how much it will
> matter if we start reading the file at stat() time or at
> read() time.
> 
> This is because one disk seek takes about 10 million CPU
> cycles on modern systems and we'll have completed the stat(),
> open() and started the read() before the disk arm has started
> moving ;)

Please correct me if I'm missing something: I tend to assume
that if the cost of the disk seek is known to be a relatively
huge value, a fraction of it could be used as a timeout for disk
read request reordering with performance not deteriorating (except
for the heuristics overhead of course). I.e., if some code in the
block layer were able to detect a lot of "parallel yet sequential"
reads were going on, the amount of seeks could be minimized for
the price of the final timeout.

T.
