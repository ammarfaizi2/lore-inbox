Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269691AbUHZV3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269691AbUHZV3R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269679AbUHZV1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:27:42 -0400
Received: from mail.shareable.org ([81.29.64.88]:16327 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269680AbUHZVVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:21:04 -0400
Date: Thu, 26 Aug 2004 22:19:18 +0100
From: Jamie Lokier <jamie@shareable.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: Christophe Saout <christophe@saout.de>, Rik van Riel <riel@redhat.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826211918.GF5733@mail.shareable.org>
References: <Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com> <1093536282.5482.6.camel@leto.cs.pocnet.net> <Pine.LNX.4.60.0408261348370.27825@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0408261348370.27825@dlang.diginsite.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> I also don't see why the VFS/Filesystem can't decide that (for example) 
> this tar.gz is so active that instead of storing it as a tar.gz and 
> providing a virtual directory of the contents that it instead stores the 
> directory of the contents and makes the tar.gz virtual (regenerating it as 
> needed or as extra system resources are available)

Absolutely.  It could keep both views, if they're both actively being
used.  Or more than both, if there are more.  (You could think of
compression being an alternate view, and both compressed and
uncompressed may as well remain on disk if there's space and it's
being actively accessed.

> implementation wise I see headaches in doing this, but conceptually this 
> is just an optimization that could take place in the future if we fine 
> that it's needed.

untarring a big source tree takes ages.  I wouldn't like to do it
after every reboot, if there was a .tar.bz2 tree I looked at often.
That's why I have things like glibc untarred in my home directory.

With good cacheing, I could cd into the .tar.bz2 files and
_effectively_ have the performance of untarred source trees for the
ones I look at often on my disk -- automatically cleaned if the space
if needed for something else, too.  It would be quite nice.

-- Jamie
