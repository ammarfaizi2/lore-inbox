Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269238AbUHZQ66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269238AbUHZQ66 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269230AbUHZQz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:55:56 -0400
Received: from mail.shareable.org ([81.29.64.88]:31942 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269213AbUHZQu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:50:29 -0400
Date: Thu, 26 Aug 2004 17:44:51 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Christoph Hellwig <hch@lst.de>, Christophe Saout <christophe@saout.de>,
       Rik van Riel <riel@redhat.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826164451.GL5733@mail.shareable.org>
References: <Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com> <1093536282.5482.6.camel@leto.cs.pocnet.net> <20040826160750.GC4326@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826160750.GC4326@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> or placing this into a userspace helper that the kernel can invoke
> transparently.

Yes, exactly this for most file formats.
Ideally, with _some_ user control over the handlers for their own
files a bit like Hurd.

Not just archive files: metadata pulled from audio files, images,
distro packages, etc.  In other words much the same as Gnome and KDE's
things, but with more emphasis on metadata extractors and efficient
on-disk cache interaction, and a sane page-cache coherency interface
(possibly FUSE).

Metadata extraction is useful for search and indexing purposes.
(That, and a way to hook change notifications up with indexers --
again comes with any proper coherency interface).

For new applications using a container, it's tempting to want one
format which is optimised for this.  But really many applications want
to write XML or compressed XML, or something else that isn't
especially efficient but is easy to work with on many OSes.  We should
support applications whatever format they need to work with, if
providing an interior view as a directory is useful for them.  (This
implies applications can introduce their own formats for files they
need to operate on.)  By the way, lazy updating of containers is an
even bigger advantage if you have to use XML as the flat format,
because the savings from not serialising when you don't need to are
more pronounced.

For some applications the "content" isn't structured in a way which
maps naturally to a plain archive file.  Hans' /etc/passwd is a simple
example: at least one of the "flat" representations, when there are
enough entries, probably ought to be a DB file for faster lookup.
(Though, it would be great if /etc/passwd could automagically get fast
lookup due to an automagic underlying representation, while still
appearing to be a flat file when you cat it).

Also, imagine "cd" into a MySQL table file.  It might just work.

By the way, we don't need containers to waste huge amounts of space
like the Microsoft Word "fast save" documents did.  Because our
containers are created on demand, there is no performance advantage in
them having unused holes, unlike the case were Word was saving changes
periodically.

-- Jamie

