Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269605AbUICKsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269605AbUICKsJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 06:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269589AbUICKsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 06:48:09 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:25985 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269599AbUICKrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 06:47:31 -0400
From: Stuart Young <cef-lkml@optusnet.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Date: Fri, 3 Sep 2004 20:41:18 +1000
User-Agent: KMail/1.7
Cc: Helge Hafting <helge.hafting@hist.no>, "Theodore Ts'o" <tytso@mit.edu>,
       Jeremy Allison <jra@samba.org>, Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       Linus Torvalds <torvalds@osdl.org>, reiser@namesys.com, hch@lst.de,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       flx@namesys.com, reiserfs-list@namesys.com
References: <200408261819.59328.vda@port.imtp.ilyichevsk.odessa.ua> <200409030045.20098.cef-lkml@optusnet.com.au> <413822FC.8090600@hist.no>
In-Reply-To: <413822FC.8090600@hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409032041.22128.cef-lkml@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004 17:53, Helge Hafting wrote:
> Stuart Young wrote:
> >On Thu, 2 Sep 2004 22:54, Theodore Ts'o wrote:
> >>On Wed, Sep 01, 2004 at 01:51:40PM -0700, Jeremy Allison wrote:
> >>>>So you're saying SCP, CVS, Subversion, Bitkeeper, Apache and rsyncd
> >>>>will _all_ lose part of a Word document when they handle it on a
> >>>>Window box?
> >>>>
> >>>>Ouch!
> >>>
> >>>Yep. It's the meta data that Word stores in streams that will get lost.
> >>
> >>And this is why I believe that using streams in application is well,
> >>ill-advised.  Indeed, one of my concerns with providing streams
> >>support is that application authors may make the mistake of using it,
> >>and we will be back to the bad old days (when MacOS made this mistake)
> >>where you will need to binhex files before you ftp them (and unbinhex
> >>them on the otherside) --- and if you forget, the resulting file will
> >>be useless.
>
> This is not a problem with multiple streams implemented right - as a
> directory.

This works if you want (possibly editable) views of a single document. It 
doesn't really work that well for other things. Even then, something has to 
handle all the data translations and decoding, and that means you need to 
store all the reference information somewhere so that the app knows what to 
pass the original file to, so that it can be decoded for the user as they've 
requested.

> You don't stay away from directories just because you have to tar
> them in order to put them on ftp sites? ;-)

No, but I know a lot of people who don't understand that with a lot of ftp 
servers that if you append .tar.gz to the directory name, you can fetch the 
directory. Sure it's all user education, but you have to remember that users 
don't generally want to be educated. They just want to get on with doing 
whatever they are doing.

> Still, you're right that apps using streams jsut for the hell of it is bad.
> That sort of thing happens all the time when something new shows up,
> some people will use it without thinking.

Hence why I was suggesting the idea of disposable data in streams. As long as 
people KNOW it's disposable, but useful to keep around as it cuts down the 
time needed to do stuff, then apps will start to pick up transporting streams 
properly. Least then (hopefully) no real information will get lost that is 
important. Once transporting streams becomes commonplace, then perhaps 
streams can be used for more useful things.

> >At least currently (to my knowledge anyway) all stream support in Windows
> > is data that is not important, and that can be either regenerated from
> > filesystem metadata or (more usually) the main file stream itself.
> >
> >This sort of data is really where streams excel, by providing a way to
> > access data that would otherwise take time/cpu to regenerate over and
> > over, but that in itself is not indispensable.
>
> Streams as a cache.

Almost exactly.

> >Good examples of this are indexes of data
> >within a document, details of who owns/created/modified the document,
> > common views or reformatting of the data, etc. With audio/video/graphics,
> > you could store lower quality transforms of data (eg: stereo to mono,
> > resolution reduction, thumbnails, etc) in the streams for a file. With a
> > word document, it could be things like an index (assuming it's
> > auto-generated from section headings). With a database, it could be the
> > indexes, and a few views that are expensive time-wise to generate. All of
> > these are easily regenerated from the original data stream, but takes a
> > while. And if you've got the disk, why not use it?
>
> Actually, some if this is bad examples of using streams.
> Why can't that index be stored _in_ the document?
> After all, the word processor is the one who knows the document's
> internal format, how to generate the index, and how to use it.  Well,
> this example is bad anyway as an index can be created so fast from
> a well structured document that there is little need for storing one.
> (Example - see how lyx keeps a live index in the "navigate" menu. . .)

The point of such information in my examples is that a stream can store 
information in a particular format (ie: an index) that is common to one 
indexing app/library. Such an index can be used by ANY app that knows the 
index format to search the document. This is almost exactly what MS will do 
(if they haven't done it already) with the File Indexing Service. As it's ONE 
library, then any new user app that creates data can add index creation by 
adding one library. And any app that wants to search these indexes would need 
only to add one library, not every library for every format that it wants to 
search. It's essentially an n^2 vs 2n problem.

> A document format may also contain fields specifying who made it, or
> even a log of who modified it and when.

Exactly, but then you need to:
 1. Read in the Document, and in some formats that are either compressed or 
that do not have a fixed format, this may mean you end up reading most of or 
even an entire file to get this data. This is expensive on CPU, disk cache, 
disk access and transfer times with large files, particularly if it's a slow 
data bus to the storage device.
 2. Parse out the information you want, which means that you need to 
understand the format. With an index stream, in a fixed format, you only need 
one library that can handle the format for you. Without streams, you use lots 
of libraries. By using lots of libraries, you end up using lots of memory to 
hold them, and disk access time/transfer speed to load them.

> It seems to me that streams are more useful for stuff that the file's
> main application don't deal with itself.  Such as attaching icons that
> follow the file around.

Icons themselves wouldn't be that good for multi-user environments. Attaching 
an icon type designator that then allows the app that wants to display an 
icon for the file to pull the appropriate icon from somewhere else (and 
therefore can be matched to whatever theme or specific icon the user wants) 
is probably a better idea.

> >If streams were always to be considered volatile, then you could do all
> > sorts of interesting things with them. Any disk cleanup mechanism you
> > have could also reap old streams specifically if the disk gets below a
> > certain amount free.
>
> That would limit streams to caching use _only_, disks fill occationally
> and we can't have _useful_ stuff disappearing at random.

If they transfer a file with streams on Windows using standard (Posix based) 
tools at the moment then they lose this information anyway. And application 
developers aren't all suddenly going to drop whatever it is they're doing to 
implement stream support as soon as it appears. Things take time, and till 
the majority of applications support it, it's useless to assume that the data 
is not going to dissapear because of a user using a non-updated tool. By 
limiting it to caching, at least in the short term, at least no one is going 
to (hopefully!) get bitten by data loss. Later (and I'm guessing a LOT 
later), who knows, streams could actually become useful for more than just 
caching.

-- 
 Stuart Young (aka Cef)
 cef-lkml@optusnet.com.au is for LKML and related email only
