Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbVICN3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbVICN3z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 09:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbVICN3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 09:29:55 -0400
Received: from xproxy.gmail.com ([66.249.82.195]:38246 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751455AbVICN3y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 09:29:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NdbA5cAtAecPK3cMkeL+hnjP3AJBq0Ett0QMqeJpEtWsBrd5qyOoWO5TjgH46cSXmZ2S6WsM2q4zRTXIAN/Prg03wo+B3Z1UBWe+M72p0swhReJoTGytyRaZvMs2u1rFKmgI0C1mif1wdthvvbKIHDr1ee72953hy+pSKBYzD0Q=
Message-ID: <a4e6962a050903062941d46389@mail.gmail.com>
Date: Sat, 3 Sep 2005 08:29:51 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: ericvh@gmail.com
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: FUSE merging?
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       fuse-devel@lists.sourceforge.net, torvalds@osdl.org,
       V9FS Developers <v9fs-developer@lists.sourceforge.net>,
       Linux FS Devel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <E1EBQco-0006qr-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1EBJc2-0006J0-00@dorka.pomaz.szeredi.hu>
	 <20050902153440.309d41a5.akpm@osdl.org>
	 <E1EBQco-0006qr-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/05, Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> > I agree that lots of people would like the functionality.  I regret that
> > although it appears that v9fs could provide it,
> 
> I think you are wrong there.  You don't appreciate all the complexity
> FUSE _lacks_ by not being network transparent.  Just look at the error
> text to errno conversion muck that v9fs has.  And their problems with
> trying to do generic uid/gid mappings.
>

While FUSE doesn't handle it directly, doesn't it have to punt it to
its network file systems, how to the sshfs and what not handle this
sort of mapping?  Not really a criticism, just curious.  This doesn't
so much relate to FUSE, but I've been wrestling with what to do about
this chunk of (mapping) code -- it seems like it might be a good idea
to have some common code shared amongst the networked file systems to
handle this sort of thing.  The NFS idmapd service seems
overcomplicated, but something like that in the common code could
provide the same level of service.  What do folks think? Should
someone (me?) take a whack at a common id mapping service for the
kernel (or just extract idmapd from NFS) -- or is this something
better implemented filesystem-to-filesystem?
 
> > there seems to be no interest in working on that.
> 
> It would mean adding a plethora of extensions to the 9P protocol, that
> would take away all it's beauty.  I think you should realize that
> these are different interfaces for different purposes. There may be
> some overlap, but not enough to warrant trying to massage them into
> one big ball.
> 

A very good point.  I toyed with the idea of looking at creating a
FUSE-API-compatible v9fs file server library - but there are a good
deal of features (like extended attributes) that we don't have
provisions for in the protocol -- and most likely a good deal of
complexity supporting some of these features  that we may not want to
deal with just yet.

Miklos is right, for the moment FUSE and v9fs have some overlap, but
they remain very different things.  FUSE is far more focused on
delivering user-space file servers, and as such has a better solution
for developing user-space file servers.  We are still focusing on
getting the core of v9fs worked out, when we eventually have that
working smoothly, I like to think we'd be able to spend some time
developing a file server SDK as rich as FUSE (perhaps something
API-compatible as I mentioned before) -- but we want to focus on
getting the core protocol implementation right first - since it has
uses beyond user-space file servers.

         -eric
