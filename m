Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSFCTzu>; Mon, 3 Jun 2002 15:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315459AbSFCTzt>; Mon, 3 Jun 2002 15:55:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8454 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315457AbSFCTzs>; Mon, 3 Jun 2002 15:55:48 -0400
Date: Mon, 3 Jun 2002 12:55:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Mason <mason@suse.com>
cc: Andrew Morton <akpm@zip.com.au>, Alexander Viro <aviro@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] iput() cleanup (was Re: [patch 12/16] fix race between
 writeback and unlink)
In-Reply-To: <1023133764.22608.1867.camel@tiny>
Message-ID: <Pine.LNX.4.33.0206031252270.11914-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 3 Jun 2002, Chris Mason wrote:
> 
> I'm talking a very limited set of operations followed by calling the
> generic functions.  I might not do it at all if I can't get them safe
> when called under the spin lock.

Ok, that should be reasonably "portable" (ie it won't break horribly and
silently in the future when something changes in inode-land). Just doing a
few ops (knowing you're under the inode lock) and then calling
"generic_drop_inode()" should be fine.

[ Except right now only the "generic_delete_inode()" thing is exported, so
  you'd need to export the other generic stuff, but that was kind of my
  plan anyway, I just don't wan tto do it until there is some real need. ]

		Linus

