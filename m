Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUHaR5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUHaR5E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUHaR5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:57:03 -0400
Received: from mx-out.forthnet.gr ([193.92.150.6]:27556 "EHLO
	mx-out-04.forthnet.gr") by vger.kernel.org with ESMTP
	id S265805AbUHaR4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:56:03 -0400
From: V13 <v13@priest.com>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the idea of what reiser4 wants to do with metafiles and why
Date: Tue, 31 Aug 2004 20:55:55 +0300
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, reiserfs-list@namesys.com
References: <41323AD8.7040103@namesys.com>
In-Reply-To: <41323AD8.7040103@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408312055.56335.v13@priest.com>
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 August 2004 23:21, Hans Reiser wrote:
> The Idea
>
> You should be able to access metadata about a file the same way you
> access the file's data, but with a name based on the filename followed
> by a name to select the metadata of interest.
>
> Examples:
>
> cat song_of_silence/metas/owner
> cat song_of_silence/metas/permissions
> cat 10 > song_of_silence/metas/mixer_defaults/volume
> cat song_of_silence/metas/license

Maybe I'm crazy but:

 You're talking about a major change in the way filesystems work if this is 
going to be used by other FSs too. If  I understand this correctly it is a 
completely new thing and trying to do it by patching existing well-known 
'primitives' may be wrong. 

  AFAIK and AFAICS the metadata are not files or directories. You can look at 
them as files/dirs but they are not, just like a tar is not a directory. I 
believe that the correct thing to do (tm) is to add a new 'concept' named 
'metadata' (which already exists). This way you'll have files, directories 
and metadata (or whatever you call them). So, each directory can have 
metadatas and files and each file can have metadatas. Then you have to 
provide some new methods of accessing them and not to use chdir() etc. (lets 
say chdir_meta() to enter the meta dir which will work for files too). After 
entering the 'metadir' you'll be able to use existing methods etc to access 
its 'files'.

  This approach doesn't mess with existing things and can be extended for 
other filesystems too.

(Just a thought)

<<V13>>
