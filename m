Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269240AbUHZREO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269240AbUHZREO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269233AbUHZQ7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:59:50 -0400
Received: from mail.shareable.org ([81.29.64.88]:34758 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269232AbUHZQ4N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:56:13 -0400
Date: Thu, 26 Aug 2004 17:53:51 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rik van Riel <riel@redhat.com>
Cc: Christophe Saout <christophe@saout.de>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826165351.GM5733@mail.shareable.org>
References: <20040826154446.GG5733@mail.shareable.org> <Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> And if an unaware application reads the compound file
> and then writes it out again, does the filesystem
> interpret the contents and create the other streams ?

Yes, exactly that.  The streams are created on demand of course, and
by userspace helpers when that's appropriate which I suspect it almost
always is.

> Unless I overlook something (please tell me what), the
> scheme just proposed requires filesystems to look at
> the content of files that is being written out, in
> order to make the streams work.

Yes.  Hence the idea of coherent views between two files: writing to
one affects the content of the other, although the calcalation is only
done on demand (or when the fs wants to migrate the representation --
for example, creating the flat container prior to deleting the
regeneratable pieces in order to save space).

I haven't seen anything from Namesys that says they'll do that.  I
have the impression the streams are just generated in memory on the
fly, not stored on disk with a cacheing policy, but that's just an
impression.  (We've all seen the Namesys white papers, they're not
_that_ revealing). :)

I'm just pointing out how to do it _right_.  I think it will turn out
like this eventually, either next year or some time over the next
decade after some iterations.  Inevitable.  Mark my words, etc. :)

-- Jamie
