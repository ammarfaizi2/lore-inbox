Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269259AbUHZSZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269259AbUHZSZG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269241AbUHZSYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:24:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:20883 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269334AbUHZSQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:16:30 -0400
Date: Thu, 26 Aug 2004 11:15:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rik van Riel <riel@redhat.com>
cc: Diego Calleja <diegocg@teleline.es>, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0408261101110.2304@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, Rik van Riel wrote:
> 
> It's a relief to know that nobody's taking my humorous
> suggestion seriously, but now we still have the "standard
> Unix tools can't manipulate files" problem...

I disagree. They can manipulate the files a whole lot better than they can 
manipulate xattr's.

For example, you _could_ probably (but hey, maybe "tar" tries to strip
slashes off the end of filenames, so this might not work due to silly
reasons like that) back up a compound file with

	tar cvf file.tar file file/

although unpacking it would require that tar be taught about the thing. 
And you definitely could write a script to do the thing, ie even with an 
unmodified tar you could do

	tar cvf file-archive.tar file
	cd file
	tar cvf ../attribute-archive.tar .

which is a hell of a lot better than what you can do with the fsattr 
interfaces and unmodified legacy applications.

So one of the advantages of "dir-as-file/file-as-dir" is exactly that you
_can_ manipulate the data with legacy tools. Sure, things that traverse a
directory tree might need some (likely fairly trivial) modifications if
they really want to take advantage of the subfiles, but that's still
likely to be _much_ less of an issue than with fsattr's that have a 
totally different model entirely.

		Linus
