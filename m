Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266891AbUIJCJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUIJCJA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 22:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUIJCJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 22:09:00 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:60677 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266891AbUIJCIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 22:08:51 -0400
Message-ID: <41410DE7.3090100@techsource.com>
Date: Thu, 09 Sep 2004 22:13:59 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Adrian Bunk <bunk@fs.tum.de>, Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org> <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk> <20040826010049.GA24731@mail.shareable.org> <412DA40B.5040806@namesys.com> <20040826140500.GA29965@fs.tum.de> <20040826150202.GE5733@mail.shareable.org>
In-Reply-To: <20040826150202.GE5733@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jamie Lokier wrote:
[snip
> When a simple "cd" into .tar.gz or .iso is implemented properly, it
> will have _no_ performance penalty after you have first looked in the
> file, so long as it remains in the on-disk cache.  And, the filesystem
> will manage that cache intelligently.
> 
> Imagine: for looking at source files and such, you probably won't
> bother untarring in future, and you won't bother keeping untarred
> source trees in your home directory for easy access to things you look
> at often.  Why waste the space?  You could install whole applications
> as a .tar and run them from within it, with no performance penalty.
> 
> Similarly, the filesystem will be able to archive directories
> automatically that haven't been touched in a long time, with no
> visible change except increased storage space.  "grep" will be a bit
> slower, but you'll have a useful search tool by then (using coherent
> indexes) which will be more useful than grep, and much faster.
> 

[Again, pardon me for being 5000 messages behind.]

Anyhow, I recall reading an article about 'unified name spaces', and I'm 
not referring to what's on namesys.com.  It mentioned how putting device 
nodes into the file system is a very powerful innovation of UNIX. 
Having files and devices in the same name space simplifies tools and 
makes the environment much more powerful, because you can connect data 
sources and targets together more arbitarily.

If I recall correctly, the article mentioned something about Plan9 
taking things to a greater extreme than UNIX.

Going along with what you said, Jamie, if "containers" like tar files 
could be accessed like directories without being first extracted, it 
would increase the power and flexibility of the whole system.  Windows 
XP does something like this with the way it presents ZIP files as 
directories, and although I'm sure the Windows way isn't nearly as 
efficient and universal as how Linux would do it, I find the feature to 
be INCREDIBLY useful.

Of course, we don't necessarily want codecs for every archive format 
ever invented to be embedded in the kernel.  Instead, we need to do 
something like how you can mount an ISO on a loopback device, only more 
transparently and more flexibly, and with the less performance-critical 
codecs being implemented as daemons in userspace.

Also, there would be limitations.  For instance, many such 
pseudo-directories would be read-only, and some would be writable only 
when on some file systems (like writing to a compressed archive might be 
much easier to implement on Reiser4 than something else, or perhaps the 
ext3 version would have to do a lot more copying, while the Reiser 
version could take advantage of Reiser-specific features like inserting 
in the middle of a file).

