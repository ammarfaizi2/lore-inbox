Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269337AbUICHtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269337AbUICHtg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269334AbUICHtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:49:35 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:44550 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S269328AbUICHtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:49:12 -0400
Message-ID: <413822FC.8090600@hist.no>
Date: Fri, 03 Sep 2004 09:53:32 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stuart Young <cef-lkml@optusnet.com.au>
CC: linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
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
Subject: Re: silent semantic changes with reiser4
References: <200408261819.59328.vda@port.imtp.ilyichevsk.odessa.ua> <20040901205140.GL4455@legion.cup.hp.com> <20040902125417.GA12118@thunk.org> <200409030045.20098.cef-lkml@optusnet.com.au>
In-Reply-To: <200409030045.20098.cef-lkml@optusnet.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart Young wrote:

>On Thu, 2 Sep 2004 22:54, Theodore Ts'o wrote:
>  
>
>>On Wed, Sep 01, 2004 at 01:51:40PM -0700, Jeremy Allison wrote:
>>    
>>
>>>>So you're saying SCP, CVS, Subversion, Bitkeeper, Apache and rsyncd
>>>>will _all_ lose part of a Word document when they handle it on a
>>>>Window box?
>>>>
>>>>Ouch!
>>>>        
>>>>
>>>Yep. It's the meta data that Word stores in streams that will get lost.
>>>      
>>>
>>And this is why I believe that using streams in application is well,
>>ill-advised.  Indeed, one of my concerns with providing streams
>>support is that application authors may make the mistake of using it,
>>and we will be back to the bad old days (when MacOS made this mistake)
>>where you will need to binhex files before you ftp them (and unbinhex
>>them on the otherside) --- and if you forget, the resulting file will
>>be useless.
>>    
>>
This is not a problem with multiple streams implemented right - as a 
directory.
You don't stay away from directories just because you have to tar
them in order to put them on ftp sites? ;-)

Still, you're right that apps using streams jsut for the hell of it is bad.
That sort of thing happens all the time when something new shows up,
some people will use it without thinking.

>
>At least currently (to my knowledge anyway) all stream support in Windows is 
>data that is not important, and that can be either regenerated from 
>filesystem metadata or (more usually) the main file stream itself.
>
>This sort of data is really where streams excel, by providing a way to access 
>data that would otherwise take time/cpu to regenerate over and over, but that 
>in itself is not indispensable. 
>
Streams as a cache.

>Good examples of this are indexes of data 
>within a document, details of who owns/created/modified the document, common 
>views or reformatting of the data, etc. With audio/video/graphics, you could 
>store lower quality transforms of data (eg: stereo to mono, resolution 
>reduction, thumbnails, etc) in the streams for a file. With a word document, 
>it could be things like an index (assuming it's auto-generated from section 
>headings). With a database, it could be the indexes, and a few views that are 
>expensive time-wise to generate. All of these are easily regenerated from the 
>original data stream, but takes a while. And if you've got the disk, why not 
>use it?
>  
>
Actually, some if this is bad examples of using streams.
Why can't that index be stored _in_ the document?
After all, the word processor is the one who knows the document's
internal format, how to generate the index, and how to use it.  Well,
this example is bad anyway as an index can be created so fast from
a well structured document that there is little need for storing one.
(Example - see how lyx keeps a live index in the "navigate" menu. . .)

A document format may also contain fields specifying who made it, or
even a log of who modified it and when. 

It seems to me that streams are more useful for stuff that the file's
main application don't deal with itself.  Such as attaching icons that
follow the file around.

>If streams were always to be considered volatile, then you could do all sorts 
>of interesting things with them. Any disk cleanup mechanism you have could 
>also reap old streams specifically if the disk gets below a certain amount 
>free. 
>
That would limit streams to caching use _only_, disks fill occationally
and we can't have _useful_ stuff disappearing at random.

Helge Hafting
