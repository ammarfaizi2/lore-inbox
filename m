Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbTHXSzJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 14:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTHXSzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 14:55:09 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:53262 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261291AbTHXSzF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 14:55:05 -0400
Date: Sun, 24 Aug 2003 21:02:47 +0200
To: Hans Reiser <reiser@namesys.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel@vger.kernel.org, Reiserfs List <reiserfs-list@namesys.com>,
       Nikita Danilov <god@laputa.namesys.com>
Subject: Re: FS: hardlinks on directories
Message-ID: <20030824190247.GA17693@hh.idb.hist.no>
References: <20030804141548.5060b9db.skraw@ithnet.com> <03080409334500.03650@tabby> <20030804170506.11426617.skraw@ithnet.com> <03080416092800.04444@tabby> <20030805003210.2c7f75f6.skraw@ithnet.com> <3F2FA862.2070401@aitel.hist.no> <20030805150351.5b81adfe.skraw@ithnet.com> <20030805220831.GA893@hh.idb.hist.no> <3F48F77D.7040907@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F48F77D.7040907@namesys.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 24, 2003 at 09:35:57PM +0400, Hans Reiser wrote:
> Helge Hafting wrote:
> >
> So, he needs links that count as references, 
Plain hard links.

> links that don't count as 
> references but disappear if the object disappears (without dangling like 
> symlinks),

Current filesystems would need a fs-wide search for soft links,
but this is avoidable by storing a list of links in the inode.
That must be done carefully though, or you'll get another
problem:  if I move a high-level directory, will I have
to update links and inodes linked to 
that exists deep within some subsubsubdirectory?
This had better be unnecessary, meaning the in-inode list
of "reverse links" can't contain paths.
Perhaps the can contain the inode numbers of the referencing directories.

Deleting a file with this new kind of links will then cause
searches in various directories containing those links.

>  and unlinkall(), which removes an object and all of its 
> links.  He needs for the first reference to a directory to be removable 
> only by removing all links to the object, or designating another link to 
> be the "first" reference.
> 
> Sounds clean to me.  This is not to say that I am funded to write 
> it.;-)  I'd look at a patch though.....;-)
> 
> I need to write up a taxonomy of links..... after reiser4 ships.....
> 

This stuff is possible if we get a new type of link then.
I wonder how exisitng link-aware tools will cope.

Helge Hafting 
