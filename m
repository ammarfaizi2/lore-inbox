Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSEQLok>; Fri, 17 May 2002 07:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314454AbSEQLoj>; Fri, 17 May 2002 07:44:39 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:51123 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S314451AbSEQLoj>; Fri, 17 May 2002 07:44:39 -0400
Date: Fri, 17 May 2002 12:47:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix BUG macro 
In-Reply-To: <E178eGc-0008MY-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.21.0205171220480.986-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002, Rusty Russell wrote:
> In message <Pine.LNX.4.21.0205170839240.1369-100000@localhost.localdomain> you 
> write:
> > On Fri, 17 May 2002, Rusty Russell wrote:
> > > 
> > > Um, show me where sizeof(KBUILD_BASENAME) + sizeof(__FUNCTION__) >
> > > sizeof(__FILENAME__).
> > 
> > If you're talking about kbuild2.5
> 
> No.  It's the include files, which makes up the majority of strings.

If they do make up the majority of strings, that's partly because
you don't have Andrew's out_of_line_bug work in your tree, partly
because your linker isn't combining strings (mine neither, does any?),
partly because (I suspect) you're overlooking the vast number of BUG
__FILE__ strings which are just leafnames, to each of which you're
now proposing to add one or more __FUNCTION__ strings.

And note that __LINE__ number is of __FILE__, not of KBUILD_BASENAME,
nor of __FUNCTION__; so __INCLUDE_LEVEL__ may be necessary to make
sensible messages (if you insist on proceeding without out_of_line_bug:
which Andrew didn't push to Linus, in belief that a string-combining
linker is on the way).

> See reply to Andrew Morton.

I did see your exchanges with Andrew, but you don't seem to be
understanding one another, so I'm trying to be more explicit.

__HUGH__

