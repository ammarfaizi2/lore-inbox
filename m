Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUDBTfo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 14:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264163AbUDBTfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 14:35:44 -0500
Received: from mproxy.gmail.com ([216.239.56.244]:23197 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S264129AbUDBTfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 14:35:36 -0500
Message-ID: <2B32499D.222B761B@mail.gmail.com>
Date: Fri, 2 Apr 2004 11:28:55 -0800
From: Ross Biro <ross.biro@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] cowlinks v2
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	=?ISO-8859-1?Q?=20=22J=F6rn?= Engel" <joern@wohnheim.fh-wedel.de>, mj@ucw.cz, jack@ucw.cz, "Patrick J.LoPresti" <patl@users.sourceforge.net>, linux-kernel@vger.kernel.org"
			^												     ^	      ^-missing closing '"' in token
		|												      \-missing end of address
		\-extraneous tokens in address
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040320083411.GA25934@wohnheim.fh-wedel.de> <s5gznab4lhm.fsf@patl=users.sf.net> <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2004 20:23:58 +0200, Pavel Machek <pavel@ucw.cz> wrote:
> > > > If you really want cowlinks and hardlinks to be intermixed freely, I'd
> > > > happily agree with you as soon as you can define the behaviour for all
> > > > possible cases in a simple document and none of them make me scared
> > > > again.  Show me that it is possible and makes sense.

Maybe it's easiest to view the proposed copyfile() as being
semantically equivalent to cp from the point of view of anything above
the actual file system (modulo running out of space at weird times)

Then all the questions are easy to answer, and it would also be
possible to implement copyfile at the VFS layer as cp for file systems
that don't support it.

Of course, it gets more interesting if you try to do it at the block
level instead of at the file level.  For ext2, you could just reserve
a block #, say -1, to mean take the data from the master cow file, and
anything else is treated normally.  You would need a deamon to make
sure you were still saving space though.
