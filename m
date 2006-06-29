Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWF2D6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWF2D6K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 23:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWF2D6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 23:58:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:60468 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932137AbWF2D6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 23:58:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NQRZSw7mkb39Y1K6GlDblnKPL4BGHsf1KMxkpW2kc9vIMfcX3UZIj9E92PazeS2P7GiobUhmVuhmEpmmxGroWm4Z3HyoB2FJd/w4T0ysFwtLM2gGojjROsNQCt5vrjCB2GqKPRm4Acfie27Jh5L7Wj0MIui6SQmhSvzBZb6toPE=
Message-ID: <3e1162e60606282058w74fac5c0oc8f4e34716ce8884@mail.gmail.com>
Date: Wed, 28 Jun 2006 20:58:06 -0700
From: "David Leimbach" <leimy2k@gmail.com>
To: "Eric Sesterhenn / Snakebyte" <snakebyte@gmx.de>
Subject: Re: [V9fs-developer] [Patch] Dead code in fs/9p/vfs_inode.c
Cc: "Russ Cox" <rsc@swtch.com>, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net
In-Reply-To: <20060628231627.GA28463@alice>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1151535167.28311.1.camel@alice>
	 <ee9e417a0606281555k3d954236y82b11336098762be@mail.gmail.com>
	 <20060628231627.GA28463@alice>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/06, Eric Sesterhenn / Snakebyte <snakebyte@gmx.de> wrote:
> * Russ Cox (rsc@swtch.com) wrote:
> > >coverity (id #971) found some dead code. In all error
> > >cases ret is NULL, so we can remove the if statement.
> > >
> > >Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> > >
> > >--- linux-2.6.17-git11/fs/9p/vfs_inode.c.orig   2006-06-29
> > >00:50:53.000000000 +0200
> > >+++ linux-2.6.17-git11/fs/9p/vfs_inode.c        2006-06-29
> > >00:51:11.000000000 +0200
> > >@@ -386,9 +386,6 @@ v9fs_inode_from_fid(struct v9fs_session_
> > >
> > > error:
> > >        kfree(fcall);
> > >-       if (ret)
> > >-               iput(ret);
> > >-
> > >        return ERR_PTR(err);
> > > }
> >
> > What about when someone changes the code and does have ret != NULL here?
> > This seems like reasonable defensive programming to me.
> >
> > Is the official LK policy that we can't have code that trips coverity
> > checks like this?
>
> If this is whats agreed upon I will no longer send patches for
> such bugs, and mark them as ignore in the coverity system.
> But I guess it makes also sense to remove unused code, because I
> am not sure if gcc can figure out to remove it. In this case
> the generated object file is 10 bytes smaller.
>
> Eric
>

I wonder if anyone cares about those 10 bytes more than the fact that
the code that generates them is written in a defensive manner. :-)

I'd be willing to give up 10 bytes to know that if things changed in
the future that check is still there :-)

Seems like a fairly meaningless optimization to me.  No offense
intended toward Eric/Snakebyte, just that sometimes things that seem
like they are optimizations and fixes end up not being either.
