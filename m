Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269612AbUICRT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269612AbUICRT6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 13:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269708AbUICRRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 13:17:52 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:56768 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S269679AbUICRQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 13:16:36 -0400
Message-Id: <200409031712.i83HCmEN027415@laptop11.inf.utfsm.cl>
To: =?UTF-8?B?R3J6ZWdvcnogSmHFm2tpZXdpY3o=?= <gj@pointblue.com.pl>
cc: Jamie Lokier <jamie@shareable.org>, Rik van Riel <riel@redhat.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Matt Mackall <mpm@selenic.com>, Nicholas Miell <nmiell@gmail.com>,
       Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
       Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from =?UTF-8?B?R3J6ZWdvcnogSmHFm2tpZXdpY3o=?= <gj@pointblue.com.pl> 
   of "Fri, 03 Sep 2004 06:36:41 +0200." <4137F4D9.7040206@pointblue.com.pl> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 03 Sep 2004 13:12:47 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?UTF-8?B?R3J6ZWdvcnogSmHFm2tpZXdpY3o=?= <gj@pointblue.com.pl> said:
> Jamie Lokier wrote:
> >Note that file-as-directory doesn't imply that you can store just
> >anything into those directories.

> >Is it a problem to decree that "file data MUST NOT be stored in a
> >metadata directory; only non-essential metadata and data computed from
> >the file data may be stored"?

> That's exactly what folks seem to lost in this debate.
> We (developers) want to have files as dirs to:
> * be able to extract/modify file part on fly. For instance, simple .iso 
> file, without need to mount it over loop (btw, if someone is going to 
> redesign VFS, can we handle that kinda case too please?), .tar, or 
> unzipped (kernel can handle zips) "streams". File is a stream, why 
> shouldn't I have a chance to grab a stream out of archive/image than ?

ISO9660 is designed for read-only, i.e., modifying something in the middle
is probably as hard to do as just unpack/modify/repack. Same for tar, cpio,
and compressed versions of same. No gain, for a major hassle implementing
this.

> * be able to store metadata, that doesn't matter on copy, and even 
> should not be copied sometimes. Things like thumbnails, metainformation 
> (used for search). All of these extracted from acctual file (either by 
> VFS 'plugins', or by userspace application), and saved there so that it 
> can be used later on. So we save some time on extracting it.

You save iff the resources spent updating this stuff is less than
recomputing on the fly each time. Also, placing random stuff in the kernel
is _not_ "zero cost", it is _very_ expensive (kernel memory is always
resident, kernel code is _extremely_ critical, once it is in the kernel it
is very hard to change interfaces). Besides, this kind of "metadata" will
most probably be different for each user, and a user should also be able to
associate it to files she has no write right on. I.e., keep it in a
per-user directory, managed by whatever GUI tools she uses.

What you (developer) wish for and what kernel hackers are able to deliver
aren't the same. As it stands this is a badly-thought-through proposal,
with very complex ramifications that few here are aware of (see Al Viro's
and Linus' posts about locking; it breaks the fundamental principle that
something is a file or a directory, so this would break many applications),
and no clean solutions as of now.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
