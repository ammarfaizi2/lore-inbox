Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267474AbUHZFYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267474AbUHZFYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 01:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267645AbUHZFYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 01:24:35 -0400
Received: from mail.shareable.org ([81.29.64.88]:49605 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S267474AbUHZFYS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 01:24:18 -0400
Date: Thu, 26 Aug 2004 06:23:19 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Nicholas Miell <nmiell@gmail.com>, Wichert Akkerman <wichert@wiggy.net>,
       Jeremy Allison <jra@samba.org>, Andrew Morton <akpm@osdl.org>,
       Spam <spam@tnonline.net>, torvalds@osdl.org, reiser@namesys.com,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826052319.GA28857@mail.shareable.org>
References: <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net> <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826044425.GL5414@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> > Anything that currently stores a file's metadata in another file really
> > wants this right now. Things like image thumbnails, document summaries,
> > digital signatures, etc.
> 
> That is _highly_ debatable. I would much rather have my cp and grep
> and cat and tar and such continue to work than have to rewrite every
> tool because we've thrown the file-is-a-stream-of-bytes concept out
> the window. Never mind that I've got thumbnails, document summaries,
> and digital signatures already.
> 
> While the number of annoying properties of files with forks is
> practically endless, the biggest has got to be utter lack of
> portability. How do you stick the thing in an attachment or on an ftp
> site? Well you can't because it's NOT A FILE. 
> 
> A file is a stream of bytes.

I couldn't agree more.  Metadata which is easily lost is a terrible
place to put a "document summary".

However, it's not a bad place to put thumbnails which are generated
from the file contents, if they can be regenerated after transporting.
It's slightly better than a ".thumbnails" directory because the latter
won't follow renames and things like that.

It's a very good place to put metadata which is semantically bound to
the file in special ways not intended for transport, such as security
attributes, auto-invalidated digests of the file's contents, an
auto-unpacked view of an archive, a virtual tree of an XML or other
structured file, or an auto-generated textual representation of a
binary file.

The key concept is "not intended for transport".

Generally that means permissions metadata, and things which are
re-generated from the file's contents on demand.*

It's a very bad place to put an abstract of a text document, or the
names of authors, or the MIME content type, or the character encoding
of the document, or the name of the shell to run the file as a script,
unless these things are also deducible from the file's contents.
However, sometimes the content doesn't give any clue, and then
something like the character encoding of a text file is usefully
stored in the metadata simply because that's better than nothing.

Of course the facility can be abused.  What does Windows XP do?  Does
it only store the appropriate kind of metadata in the alternate
streams?  Even Windows XP users expect files transfered over HTTP or
WebDAV to work, don't they?

-- Jamie

* - By my definition, modification time arguably shouldn't be metadata.
    Personally I like downloads to be stamped with their source's
    modification time, which is why I don't use Mozilla's download
    manager but cut-and-paste URLs to "wget -N" instead.
