Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268365AbUIBOxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268365AbUIBOxj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 10:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUIBOxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 10:53:30 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:8656 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268365AbUIBOwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 10:52:23 -0400
From: Stuart Young <cef-lkml@optusnet.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Date: Fri, 3 Sep 2004 00:45:18 +1000
User-Agent: KMail/1.7
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jeremy Allison <jra@samba.org>,
       Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       Linus Torvalds <torvalds@osdl.org>, reiser@namesys.com, hch@lst.de,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       flx@namesys.com, reiserfs-list@namesys.com
References: <200408261819.59328.vda@port.imtp.ilyichevsk.odessa.ua> <20040901205140.GL4455@legion.cup.hp.com> <20040902125417.GA12118@thunk.org>
In-Reply-To: <20040902125417.GA12118@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409030045.20098.cef-lkml@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004 22:54, Theodore Ts'o wrote:
> On Wed, Sep 01, 2004 at 01:51:40PM -0700, Jeremy Allison wrote:
> > > So you're saying SCP, CVS, Subversion, Bitkeeper, Apache and rsyncd
> > > will _all_ lose part of a Word document when they handle it on a
> > > Window box?
> > >
> > > Ouch!
> >
> > Yep. It's the meta data that Word stores in streams that will get lost.
>
> And this is why I believe that using streams in application is well,
> ill-advised.  Indeed, one of my concerns with providing streams
> support is that application authors may make the mistake of using it,
> and we will be back to the bad old days (when MacOS made this mistake)
> where you will need to binhex files before you ftp them (and unbinhex
> them on the otherside) --- and if you forget, the resulting file will
> be useless.

At least currently (to my knowledge anyway) all stream support in Windows is 
data that is not important, and that can be either regenerated from 
filesystem metadata or (more usually) the main file stream itself.

This sort of data is really where streams excel, by providing a way to access 
data that would otherwise take time/cpu to regenerate over and over, but that 
in itself is not indispensable. Good examples of this are indexes of data 
within a document, details of who owns/created/modified the document, common 
views or reformatting of the data, etc. With audio/video/graphics, you could 
store lower quality transforms of data (eg: stereo to mono, resolution 
reduction, thumbnails, etc) in the streams for a file. With a word document, 
it could be things like an index (assuming it's auto-generated from section 
headings). With a database, it could be the indexes, and a few views that are 
expensive time-wise to generate. All of these are easily regenerated from the 
original data stream, but takes a while. And if you've got the disk, why not 
use it?

If streams were always to be considered volatile, then you could do all sorts 
of interesting things with them. Any disk cleanup mechanism you have could 
also reap old streams specifically if the disk gets below a certain amount 
free. This means that old streams that are hanging about don't end up wasting 
all your disk space. Of course, you'd want a way to disable this (for servers 
mainly), and streams would have to be considered volatile on more than just 
Linux as a platform for this to be useful.

Note that I'm not particularly advocating streams here. I'm just pointing out 
'how' it could be useful. It could be very easy to misuse streams and cause 
huge problems (as per Ted's comments), but it's always good to know the other 
side of the argument.

-- 
 Stuart Young (aka Cef)
 cef-lkml@optusnet.com.au is for LKML and related email only
