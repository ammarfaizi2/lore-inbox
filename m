Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269715AbUHZWEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269715AbUHZWEF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269712AbUHZWDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:03:55 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:23977 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S269675AbUHZVY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:24:28 -0400
From: David Lang <david.lang@digitalinsight.com>
To: David Masover <ninja@slaphack.com>
Cc: Christophe Saout <christophe@saout.de>, Rik van Riel <riel@redhat.com>,
       Jamie Lokier <jamie@shareable.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Date: Thu, 26 Aug 2004 14:17:46 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <412E2E86.8050909@slaphack.com>
Message-ID: <Pine.LNX.4.60.0408261414100.27825@dlang.diginsite.com>
References: <Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com>
 <1093536282.5482.6.camel@leto.cs.pocnet.net> <412E2E86.8050909@slaphack.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, David Masover wrote:

> Christophe Saout wrote:
>
> | Yes, the main compound stream unaware applications would see would just
> | be a writable view of its contents. Probably not trivial to implement
> | but doable.
>
> Not the main stream, I think, but we do need a way to make "eight-stream
> octopus" files portable.  But there needs to be a copy(2) syscall, and
> apps need to start supporting it.  After all, copy-on-write was planned
> for Reiser4, now 4.1*.  And don't anyone dare suggest "userland library".
>
> | It should be a simple format. Something simliar to tar. The worst thing
>
> Simple, yes.  Similar to tar, no.
>
> How about a serializer plugin?  foo.mp3/serialize (say) should return
> some single stream which contains all of foo.mp3.  It could work for
> directories as well, recursively, at least on the same filesystem --
> you'd back up by doing
>
> cp /serialize /backup/20040826
>
> This has two potential problems.  One is security -- I want to be able
> to serialize foo.mp3 without being root, but root doesn't want me to be
> able to serialize /etc and thus get access to shadow.
>
> The second problem is that in order to actually be used for backup, we
> need snapshots, which are not done yet*.  Currently, it'd have to lock
> the file/directory (recursively), which you don't want to do to entire
> live filesystems...  So, no massive backups of live systems yet, but
> definitely useful for sending around mp3s and such.
>
> | that can happen is people start writing plugins for every existing
> | compound format out there. It should be the other way around, agree on a
> | simple compound format and encourage applications to use this one if the
> | want to use this advantage.
>
> For the format, I vote for whatever format we're using at the storage
> layer.  It'd be a lot faster that way, both in execution time (I think)
> and in development time (I'm sure).  Plus, imagine the restore:
>
> cat /backup/20040826 > /dev/hda5
> resizefs_reiser4 /dev/hda5
>

one of the virtual metatags should be something about the method to 
serialize the data

if you are viewing a tarfile as a directory the VFS/Filesystem shoud know 
that the link between the whole thing and the contents is tar, and it 
should be possible for userspace programs to find this out by reading teh 
appropriate thing inside the virtual directory (and eventually change it 
as well, which would trigger regeneration of the base object, or at least 
noting that the current version is wrong and needs to be regenerated)

David Lang

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
