Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVITWkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVITWkg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbVITWkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:40:36 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:32290 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750701AbVITWkf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:40:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oE4xXrE6XS/kkvuKJJ4HeNfQZc8hbclR1zAGTFjb6vXiKOL2FlT2L+9IMpd164SHQ7LhcgmrRKzpwdWg3CvoPxQtYIFK9V9vmBxk2d4vBgPHGcNtOHj61ZiT1nOz/2CZA2OX0BJ6DO7mRq2F7Tu8BxpHnf2yLZnIETPRCDXpB3U=
Message-ID: <aa4c40ff05092015405a23f33a@mail.gmail.com>
Date: Tue, 20 Sep 2005 15:40:30 -0700
From: James Lamanna <jlamanna@gmail.com>
Reply-To: James Lamanna <jlamanna@gmail.com>
To: stephen.pollei@gmail.com
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Cc: vonbrand@inf.utfsm.cl, nikita@clusterfs.com, vda@ilport.com.ua,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/05, Stephen Pollei <stephen.pollei@gmai.com> wrote:
>On 9/20/05, Hans Reiser <reiser@namesys.com> wrote:
> > Horst von Brand wrote:
> > >Nikita Danilov <nikita@clusterfs.com> wrote:
> > >It is supposed to go into the kernel, which is not exactly warning-free.

> > Is that what this thread boils down to, that you guys think the compile
> > should fail not warn?

> > I don't care if it fails or warns at compile time, but you shouldn't
> > misuse/abuse a warning by potentialily introducing an unrelated bug.
>
> So if you had
>#if defined(DEBUG_THIS) || defined(DEBUG_THAT)
>int znode_is_loaded(const struct znode *z);
> #else
> int znode_is_loaded(const struct znode *z)
>  __attribute__((__warn_broken__("unavailible when not debuging")));
> #endif
> That would be great with me.. except __warn_broken__ or the like
> doesn't exist AFAIK :-<
> Closest thing is __attribute((__deprecated__)) but thats not quite right.
> > > As was said before: It it is /really/ wrong, arrange for it not to compile
> > > or not to link. If it isn't, well... then it wasn't that wrong anyway.

What about #warning / #error in this case?

#if defined(DEBUG_THIS) || defined(DEBUG_THAT)
    int znode_is_loaded(const struct znode *z);
#else
    #error znode_is_loaded is unavailable when not debugging
#endif

That would certainly break the compile.

-- James Lamanna
