Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268243AbUH2R7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268243AbUH2R7S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268247AbUH2R7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:59:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:41156 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268243AbUH2R7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:59:14 -0400
Date: Sun, 29 Aug 2004 10:57:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hans Reiser <reiser@namesys.com>
cc: Helge Hafting <helgehaf@aitel.hist.no>, Rik van Riel <riel@redhat.com>,
       Spam <spam@tnonline.net>, Jamie Lokier <jamie@shareable.org>,
       David Masover <ninja@slaphack.com>, Diego Calleja <diegocg@teleline.es>,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       jra@samba.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <4131A3B2.30203@namesys.com>
Message-ID: <Pine.LNX.4.58.0408291055140.2295@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no>
 <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org> <4131074D.7050209@namesys.com>
 <Pine.LNX.4.58.0408282159510.2295@ppc970.osdl.org> <4131A3B2.30203@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Aug 2004, Hans Reiser wrote:
> >
> >Realize that openat() works independently of any special streams, it's
> >fundamentally a "look up name starting from this file" (rather than
> >"starting from root" or "starting from cwd").
>
> well, isn't that namespace fragmentation by definition?

No.

There's no difference between

	fd = open("/usr/bin/yes", O_RDWR);

and

	dirfd = open("/usr/bin", O_RDONLY | O_DIRECTORY);
	fd = openat(dirfd, "yes", O_RDWR);

apart from error checking and permissions..

No new namespace.

Only O_XATTR implies a "namespace change".

		Linus
