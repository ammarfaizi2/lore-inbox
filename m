Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268980AbUIHC0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268980AbUIHC0k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 22:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268977AbUIHC0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 22:26:37 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:55999 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S268975AbUIHC0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 22:26:18 -0400
Message-Id: <200409080007.i880745c002997@localhost.localdomain>
To: David Lang <david.lang@digitalinsight.com>
cc: Christer Weinigel <christer@weinigel.se>, Hans Reiser <reiser@namesys.com>,
       David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Spam <spam@tnonline.net>,
       Tonnerre <tonnerre@thundrix.ch>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from David Lang <david.lang@digitalinsight.com> 
   of "Tue, 07 Sep 2004 15:36:27 MST." <Pine.LNX.4.60.0409071528200.10789@dlang.diginsite.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 07 Sep 2004 20:07:04 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <david.lang@digitalinsight.com> said:
> so far the best answer that I've seen is a slight varient of what Hans is 
> proposing for the 'file-as-a-directory'

> make the base file itself be a serialized version of all the streams and 
> if you want the 'main' stream open file/. (or some similar varient)

Serialized how? cpio(1), tar(1), cat(1)ed together, ...? Ship it via FTP or
something, how do you unpack on a traditional filesystem? On a wacky
filesystem?

Note that this has the same performance implications as the targzfilesystem
concept, just the other way around: Instead of unpacking on the fly it is
packing on the fly. And paying a (possibly huge) cost for "simple, everyday
operations" in some cases that can't be distinguished from ones where there
is no such cost is very wrong to me.

> this doesn't address the hard-link issue,

It has to be solved!

>                                           but it should handle the backup 
> problems (your backup software just goes through the files and what it 
> gets is suitable for backups).

But how do you recreate the original "files" later? You only get the
serialized version back. Even worse, if you unpack on top of the original
wacky file, you'd get a wacky file, where the main stream is the serialized
version of the original... Rinse and repeat. [Shudder]

> you will ask what serializer to user, and my answer is to let one of the 
> streams tell you, and have the kernel make a call out to userspace to 
> execute the appropriate program (note that this means that tar is not put 
> into the kernel)

If I want to see it serialized via tar(1), and you via cpio(1), and
somebody else via "take the icon stream, discard everything else", how do
you handle that?

> in fact it may make sense to just open file/file to get at the 'main' 
> stream of the file (there may be cases where the concept of a single main 
> stream may not make sense)

What do you do then?

> so if this solves the tool/backup problem

It makes it much worse, AFAICS.

>                                            then we can look and figure out 
> if there's a reasonable way to solve the hard-link problem

Right. And if none is found, can we drop this madness?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
