Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268798AbUHZM2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268798AbUHZM2H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268824AbUHZMSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 08:18:47 -0400
Received: from mail.shareable.org ([81.29.64.88]:5318 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S263001AbUHZMOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 08:14:46 -0400
Date: Thu, 26 Aug 2004 13:12:23 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rik van Riel <riel@redhat.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Matt Mackall <mpm@selenic.com>, Nicholas Miell <nmiell@gmail.com>,
       Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
       Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826121223.GG30449@mail.shareable.org>
References: <200408261034.38509.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.44.0408260736080.23532-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408260736080.23532-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> > cat <a >b does not preserve following file properties even on standard
> > UNIX filesystems: name,owner,group,permissions.
> 
> Losing permissions is one thing.  Annoying, mostly.

I find losing mtime annoying.  That's why I don't use Mozilla's
download manager (and Navigator's before it) because they presumed
that mtime isn't worth copying.  ncftp and wget do the right thing,
but it's annoying that I can't use the fancy tools and get the
metadata _I_ want transferred by them.

> However, actual losing file data during such a copy is
> nothing short of a disaster, IMHO.  

Note that file-as-directory doesn't imply that you can store just
anything into those directories.

Is it a problem to decree that "file data MUST NOT be stored in a
metadata directory; only non-essential metadata and data computed from
the file data may be stored"?

> In my opinion we shouldn't merge file-as-a-directory
> semantics into the kernel until we figure out how to
> fix the backup/restore problem and keep standard unix
> utilities work.

Same as xattrs, for data that should be stored.

But, unlike xattrs, while permissions and C-source-encoding should be
stored, some of this metadata should _not_ be stored when making an
archive and perhaps not when making a backup either.

Personally I wouldn't want an archive containing a file to save and
restore recomputable metadata like cached, extracted-on-demand MP3 id
tags and email headers-as-metadata.  I'd rather they were recalculated
when needed, implying a stronger guarantee about their relationship to
the data from which they're extracted - and implying that a user
program might not be allowed to set them to inconsistent values.

-- Jamie
