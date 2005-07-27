Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVG0Nfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVG0Nfm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 09:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVG0Nfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 09:35:42 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:56881 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262218AbVG0Nfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 09:35:40 -0400
Date: Wed, 27 Jul 2005 15:35:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm2
Message-ID: <20050727133547.GA23358@mars.ravnborg.org>
References: <fa.gdh870p.1pmsr31@ifi.uio.no> <42E77A86.6010308@reub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E77A86.6010308@reub.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A few more warnings in mostly the reiser4 code in this one compared to -mm1:
> 
> 
>   LD      fs/ramfs/ramfs.o
>   LD      fs/ramfs/built-in.o
>   LD      fs/reiser4/built-in.o
>   CC [M]  fs/reiser4/debug.o
> In file included from fs/reiser4/plugin/plugin.h:26,
>                  from fs/reiser4/jnode.h:19,
>                  from fs/reiser4/lock.h:16,
>                  from fs/reiser4/context.h:15,
>                  from fs/reiser4/debug.c:32:
> fs/reiser4/plugin/node/node40.h:83:5: warning: "GUESS_EXISTS" is not defined
>   CC [M]  fs/reiser4/jnode.o
> 
> 
> about 20 or so times during this part of the compilation, however it never 
> quite bombs out.

All these are caused by the stricter -Wundef
So if reiserfs uses:
#if GUESS_EXISTS
and GUESS_EXISTS are not defined then gcc will flag this warning.
The fix is easy - us:
#ifdef GUESS_EXISTS

Same goes for the other warnings you included in your post.

	Sam
