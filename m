Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269049AbUHaTlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269049AbUHaTlJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268877AbUHaThw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:37:52 -0400
Received: from mx-out.forthnet.gr ([193.92.150.6]:5910 "EHLO
	mx-out-04.forthnet.gr") by vger.kernel.org with ESMTP
	id S268873AbUHaTgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:36:33 -0400
From: V13 <v13@priest.com>
To: Spam <spam@tnonline.net>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the idea of what reiser4 wants to do with metafiles and why
Date: Tue, 31 Aug 2004 22:35:34 +0300
User-Agent: KMail/1.7
Cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, reiserfs-list@namesys.com
References: <41323AD8.7040103@namesys.com> <200408312055.56335.v13@priest.com> <36793180.20040831201736@tnonline.net>
In-Reply-To: <36793180.20040831201736@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408312235.35733.v13@priest.com>
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 August 2004 21:17, Spam wrote:
> > On Sunday 29 August 2004 23:21, Hans Reiser wrote:
> >> The Idea
> >>
> >> You should be able to access metadata about a file the same way you
> >> access the file's data, but with a name based on the filename followed
> >> by a name to select the metadata of interest.
> >>
> >> Examples:
> >>
> >> cat song_of_silence/metas/owner
> >> cat song_of_silence/metas/permissions
> >> cat 10 > song_of_silence/metas/mixer_defaults/volume
> >> cat song_of_silence/metas/license
> >
> > Maybe I'm crazy but:
> >
> >  You're talking about a major change in the way filesystems work if this
> > is going to be used by other FSs too. If  I understand this correctly it
> > is a completely new thing and trying to do it by patching existing
> > well-known 'primitives' may be wrong.
> >
> >   AFAIK and AFAICS the metadata are not files or directories. You can
> > look at them as files/dirs but they are not, just like a tar is not a
> > directory. I believe that the correct thing to do (tm) is to add a new
> > 'concept' named 'metadata' (which already exists). This way you'll have
> > files, directories and metadata (or whatever you call them). So, each
> > directory can have metadatas and files and each file can have metadatas.
> > Then you have to provide some new methods of accessing them and not to
> > use chdir() etc. (lets say chdir_meta() to enter the meta dir which will
> > work for files too). After entering the 'metadir' you'll be able to use
> > existing methods etc to access its 'files'.
> >
> >   This approach doesn't mess with existing things and can be extended for
> > other filesystems too.
> >
> > (Just a thought)
>
>   It  is a good thought. However I think they are trying to figure out
>   a  way  to have the metadata and streams to be accesible with legacy
>   applications.

They will be since after chdir_meta() the user will be able to look at the 
metadata just like Hans described it. The only thing that changes (from the 
userland POV) is the way someone can enter the 'metadata directory'. This way 
you don't have to have a special name, just a special function and no 
existing application (like tar) can possibly break because it will not know 
how to enter this 'metadata directory'.

<<V13>>
