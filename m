Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281812AbRKQTzf>; Sat, 17 Nov 2001 14:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281813AbRKQTz0>; Sat, 17 Nov 2001 14:55:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43277 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281812AbRKQTzU>; Sat, 17 Nov 2001 14:55:20 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH][RFC] Re: 2.4.15-pre5: /proc/cpuinfo broken
Date: 17 Nov 2001 11:54:44 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9t6fa4$ldo$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0111171052060.1458-100000@penguin.transmeta.com> <Pine.GSO.4.21.0111171359410.11475-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.GSO.4.21.0111171359410.11475-100000@weyl.math.psu.edu>
By author:    Alexander Viro <viro@math.psu.edu>
In newsgroup: linux.dev.kernel
> 
> On Sat, 17 Nov 2001, Linus Torvalds wrote:
> 
> > 
> > On Sat, 17 Nov 2001, Alexander Viro wrote:
> > >
> > > Frankly, I'd prefer to try (b) before reverting to (a).  Patch doing that
> > > variant follows.  Linus, your opinion?
> > 
> > (d) make seq_file have my originally suggested "subposition" code.
> > 
> > Ie make the X low bits of "pos" be the position in the record, with the
> > high bits of "pos" being the current "record index" kind of thing.
> > 
> > That makes lseek() happy.
> 
> It will not help.  lseek() in question is relative and crosses the
> record boundary.  I.e. we have
> 
> 	n = read(fd, buf, ...);
> 	/* process k bytes */
> 	lseek(fd, k-n, SEEK_CUR);
> 
> and that will break just as the current variant does.  It's not about
> seek to remembered position - it's a relative seek to calculated offset.
> Calculated from number of bytes returned by read().
> 

We may really want to consider if we want /proc entries to be
S_IFREG().  The closest equivalent I can think of is really a
character device node (S_IFCHR) more so that S_IFIFO.

	  -hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
