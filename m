Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267460AbUH1RBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267460AbUH1RBU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 13:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266217AbUH1RBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 13:01:20 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:26121 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267464AbUH1RBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 13:01:03 -0400
Date: Sat, 28 Aug 2004 19:05:15 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, Spam <spam@tnonline.net>,
       Jamie Lokier <jamie@shareable.org>, Hans Reiser <reiser@namesys.com>,
       David Masover <ninja@slaphack.com>, Diego Calleja <diegocg@teleline.es>,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       jra@samba.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040828170515.GB24868@hh.idb.hist.no>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 07:05:35PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 27 Aug 2004, Rik van Riel wrote:
> > 
> > Thing is, there is no way to distinguish between what are
> > virtual files and what are actual streams hidden inside a
> > file.  You don't know what should and shouldn't be backed
> > up...
> 
> I think that lack of distinguishing poiwer is more serious for 
> directories. The more I think I think about it, the more I wonder whether 
> Solaris did things right - having a special operation to "cross the 
> boundary".
> 
> I suspect Solaris did it that way because it's a hell of a lot easier to 
> do it like that, but regardless, it would solve the issue of real 
> directories having both real children _and_ the "extra streams".

There are many ways of doing this. Several extra streams to a directory
that aren't ordinary files in the directory?

It seems to me that we can get a lot of nice functionality in a simpler way:
Instead of thinking about a number of streams attached to something
that is either an ordinary file or directory, just say that the only
change will be that a directory may have a _single_ file stream in
addition to being a plain directory.

The conceptual change is smaller.  Still you achieve multiple
streams, the "main" stream in such a dir+file is the single stream
attached to the directory.  All the "extra streams" are files inside the 
(normal) directory.

* This way, the extra streams aren't "special" in any way and
  should work fine with existing tools. 
* Serving such a filesystem to clients that use multiple streams
  will allow any number of streams per file for them
* Moving the directory+file thing will move both the directory and
  the special stream, and all the extra streams follow because they're
  �part of the directory as usual�.

If the VFS is to be extended in order to support file-as-directory (or
vice versa) then hopefully it can be done in a simple way.

Helge Hafting
 
