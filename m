Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266895AbUHZA3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266895AbUHZA3i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 20:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267231AbUHZA3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 20:29:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:16876 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266895AbUHZA1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 20:27:31 -0400
Date: Wed, 25 Aug 2004 17:27:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <Pine.LNX.4.58.0408260204050.22259@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.58.0408251723540.17766@ppc970.osdl.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
 <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
 <Pine.LNX.4.58.0408260204050.22259@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, Mikulas Patocka wrote:
> 
> Stupid question: who will use it? And why?
> 
> Anyone can write an userspace library, that implements function
> set_attribute(char *file, char *attribute, char *value), that creates
> directory ".attr/file" in file's directory and stores attribute there.
> (and you can get list of attributes from shell too:
> ls `echo "$filename" |sed 's/\/\([^\/]*\)$/\/\.attr\/\1/'`
> ). There's no need to add extra functionality to kernel and filesystem.

..and the above is, roughly, what I understand samba etc falls back on.

The problem ends up being that the above isn't in any way safe from people 
moving files around (oops, where did those attributes go?) nor does it 
have any consistency guarantees. So it only works well if _one_ 
application does this, and that application follows all the locking rules.

Is it enough? It may have to be.

> The only way xattrs are useful is that backup/restore software doesn't
> have to know about every filesystem with it's specific attributes and
> every magic ioctl for setting them. Instead it can save/restore
> filesystem-specific attributes without understanding what do they mean.
> However there's no need why application should use them. And no
> application does.

If no application does, then why back them up? Why implement them in the 
first place?

In other words - some apps obviously do want to use the. Sadly.

		Linus
