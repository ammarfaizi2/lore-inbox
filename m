Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269698AbUHZXeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269698AbUHZXeb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269764AbUHZXeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:34:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:45992 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269698AbUHZX3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:29:38 -0400
Date: Thu, 26 Aug 2004 16:27:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hans Reiser <reiser@namesys.com>
cc: Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <412E69D2.50503@namesys.com>
Message-ID: <Pine.LNX.4.58.0408261625180.2304@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0408261315110.2304@ppc970.osdl.org> <412E69D2.50503@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, Hans Reiser wrote:
>
> Linus Torvalds wrote:
> >
> >For example, it's likely that most filesystems would _not_ allow linking 
> >of a named stream anywhere else.
>
> Why?  It is just a file that inherits its stat data and is referenced by 
> a concatenation method of its parent directory.  The link will also 
> inherit its stat data from the original parent directory.

In reiser4, maybe. Not in general. Look at what other filesystems do for 
attributes..

> > And you might not be able to change the 
> >permissions or date on the named stream either, since it may or may not 
> >have a separate date/permission thing from the container.
>
> You should be able to change the permission and data, but when you 
> change it, you change it for the whole container.

Why? I'd much rather disallow it, than allow it and then have "nonlocal" 
effects.

I can also see a filesystem validly having _extra_ permissions (ie apart
from the container) on it too.

Not all the world is reiser4. 

		Linus
