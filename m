Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269022AbUICDPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269022AbUICDPP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 23:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269076AbUICDOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 23:14:53 -0400
Received: from scrat.hensema.net ([62.212.82.150]:44718 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S269022AbUIBUgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:36:02 -0400
From: Erik Hensema <erik@hensema.net>
Subject: Re: The argument for fs assistance in handling archives
Date: Thu, 2 Sep 2004 20:35:58 +0000 (UTC)
Message-ID: <slrncjf11e.6pa.erik@bender.home.hensema.net>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org> <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org> <4136E0B6.4000705@namesys.com> <14260000.1094149320@flay> <1094154744.12730.64.camel@voyager.localdomain>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.8.0 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Bergman (steve@rueb.com) wrote:
> However, a few things are becoming clear to me:
>
> 1. The file as directory thing adds complexity that the administrator
> has to deal with.  Symlinks are useful, but it's still aggravating to
> tar off a directory structure, take it somewhere, and then realize that
> all you have is links to something not in the archive because you didn't
> get your tar switches just right.  Now we're talking about adding
> another set of "files which are not really files" to the semantics.
> More complexity.  I'll take simplicity over some ivory tower ideal of
> "unified name space" any day.

As with any addition of complexity we have to ask ourselves: do
the advantages outweigh the disadvantages?

Adding complexity into the kernel may simplify userspace. Adding
the complexity of an IP layer into the kernel simplifies
networking applications, for example (they won't have to talk IP
to the kernel).

In this case it's hard to imagine what advantages a multistream
file will bring, simply because we aren't used to working with
them. Or maybe there aren't any advantages at all. Point is: we
don't know yet. Maybe we have to toy with the idea for some years
before we really learn why multistream files are so great.

I do realize that this isn't how Linux development is done. First
we need a problem, then somebody sits down and codes a solution.
With reiser4 we've got a solution but we haven't figured out what
the problem is yet.

> 2. The use of multiple streams within files by Linux apps would make
> Linux as cross-platform unfriendly as MS is trying to be.  Say these
> features start getting used and you copy an OO.org document from a Linux
> box to a BSD box.  It's broken.  Of course, OO.org wouldn't use the
> streams in the first place because it would destroy their cross platform
> portability.  So what's the point?  No one who cares about cross
> platform portability can use it.  Everyone who doesn't care about cross
> platform portability please raise your hand.

But do we really want to be the lowest common denominator? If you
want to lead, you can't be compatible (in some cases).
Also, if the reiser4 ideas catch on, they may spark the
development of other, similar, filesystems. Maybe we'll end up
with a ext4 in the 2.8 kernel...

> 3. MS does require attributes and multiple streams, which makes these
> features important (even essential) to Samba, and Samba alone.  Samba is
> important to Linux, so this can't be ignored. (Here I am implicitly
> assuming that Samba will need kernel support for this to do it right.)
>
> So it seems to me that the only real consideration is giving Samba what
> it needs without making the semantics one bit more complex than
> absolutely necessary.  It might even be wise to discourage use of these
> ambiguous new objects by the casual application programmer.
>
> Then again, maybe I just have tunnel vision... 

Not tunnel vision. You're just looking at what we need *now*, and
that happens to be exactly what we *have* now.

One possible use for multistream files that I see, is storage of
'not so important' data alongside of the real data of a file.
Think: the mimetype of a file; some metadata like author,
keywords, etc.

When you copy the file and lose all metadata except the file
itself, no real harm is done.

This could be used by the new mime system Gnome uses, for
example. On regular filesystems, the mimetype of a file is
determined by its extension. On reiser4(-like filesystems), the
mimetype is determined by the 'mimetype' stream.
This would clearly simplify the gnome userspace, as there is no
need anymore for a seperate extension<->mimetype conversion
anymore. It would also be compatible with other tools or desktop
environements, we only have to agree on what stream we're going
to use for what metadata.

IMHO reiser4 is a toy we should give the Linux users to play
with. Let's see what they can come up with. With the talented
hackers in the community, it should be great.

-- 
Erik Hensema <erik@hensema.net>
(attempting to write english while drinking beer)
