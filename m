Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267807AbUHZI14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267807AbUHZI14 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 04:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267818AbUHZI14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:27:56 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:60167 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267807AbUHZI1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:27:46 -0400
Message-ID: <412D9FFA.6030307@hist.no>
Date: Thu, 26 Aug 2004 10:31:54 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Nicholas Miell <nmiell@gmail.com>, Wichert Akkerman <wichert@wiggy.net>,
       Jeremy Allison <jra@samba.org>, Andrew Morton <akpm@osdl.org>,
       Spam <spam@tnonline.net>, torvalds@osdl.org, reiser@namesys.com,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net> <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org>
In-Reply-To: <20040826053200.GU31237@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
[...]

>What it breaks is the concept of a file. In ways that are ill-defined,
>not portable, hard to work with, and needlessly complex. Along the
>way, it breaks every single application that ever thought it knew what
>a file was.
>
>Progress? No, this has been done before. Various dead operating
>systems have done it or similar and regretted it. Most recently MacOS,
>which jumped through major hurdles to begin purging themselves of
>resource forks when they went to OS X. They're still there, but
>heavily deprecated.
>
>  
>
>>cp, grep, cat, and tar will continue to work just fine on files with
>>multiple streams.
>>    
>>
>
>Find some silly person with an iBook and open a shell on OS X. Use cp
>to copy a file with a resource fork. Oh look, the Finder has no idea
>what the new file is, even though it looks exactly identical in the
>shell. Isn't that _wonderful_? 
>
It is what I'd expect.  Now, use cp -R to copy  the file
_with its directory_, and see if that fares better.  If not - bad
implementation of fs and/or cp.  The way I see file-as -directory
is that _file_ operations (like the reads issued by cat) only
work on the file part.  You want the directory part?  Use
directory operations such as those "cp -R" use.

>Now try cat < a > b on a file with a
>fork. How is that ever going to work?
>  
>
It is going to copy the _file_ part, of course.  I wouldn't
expect anything else - "cat" doesn't deal with directories.

This also raise the question of when to use file-as-directory.
A usage where you need everything to follow the file, even
when using "cat" calls out for an application that puts everything
into one file.  Directory-as-file is the wrong tool for that job, so don't
worry about such problems.

Sticking thumbnails in a file-as-dir is another story though.  Move the
file (with "mv a b", not  "cat a>b;rm a") moves the image file _and_ the
thumbnail.  No time wasted on regenerating thumbnails, no disk space
or cleanup time wasted on dangling thumbs.  Use the image file
for its intended purposes (view it, mail it off, serve it on the web,
edit it, print it) and the thumbnail doesn't get in the way
because it isn't embedded in the file format.  Embedding it
in the file might work for jpeg which support generic embedded data,
it surely won't work for every image format out there.

This is my idea of how file-as-directory should work.

Helge Hafting


Helge Hafting

