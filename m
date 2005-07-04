Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVGDIjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVGDIjh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 04:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVGDIjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 04:39:37 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:47365 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261460AbVGDIjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 04:39:35 -0400
To: pavel@ucw.cz
CC: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
In-reply-to: <20050703193941.GA27204@elf.ucw.cz> (message from Pavel Machek on
	Sun, 3 Jul 2005 21:39:42 +0200)
Subject: Re: FUSE merging?
References: <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu> <1120126804.3181.34.camel@laptopd505.fenrus.org> <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu> <20050630235059.0b7be3de.akpm@osdl.org> <E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu> <20050701001439.63987939.akpm@osdl.org> <E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu> <20050701010229.4214f04e.akpm@osdl.org> <20050703193941.GA27204@elf.ucw.cz>
Message-Id: <E1DpMTJ-000639-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 04 Jul 2005 10:38:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, the right question is "how is fuse better than coda". I've
> asked that before; unlike nfs, userspace filesystems implemented with
> coda actually *work*, but do not provide partial-file writes.

You answered your own question.

I did talk to Jan Harkes about the file I/O issue before starting
FUSE.  [searching archives] here's a quote from him about this:

  "I've been thinking about partial file accesses myself. However, I
  really don't want to go all the way to block-level caching. That
  would add a lot of overhead either in passing every read/write call
  up to userspace, or by using a largish amount of memory to keep
  track of availability of parts of the file. It also defeats the more
  efficient 'streaming' fetch of a whole file.

  However, something that would work reasonably well is a file offset
  marker that indicates how much data is available. Basically, when the
  application opens a file, the open upcall returns after the first...
  let's say 64KB... have arrived. Any read's and write (and mmap's) that
  access the available part of the file will be allowed. When any
  operation tries to access beyond the marker an upcall is made which
  blocks until the related part of the file has streamed in."

So true random access doesn't fit too well into the CODA philosophy.

Of course you could extend CODA to handle this as well (and all the
other things needed for safe user mounts), but the results would
proably not have pleased either side.

Miklos
