Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268207AbUIGPC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268207AbUIGPC6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUIGOyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:54:16 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:45253 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S268186AbUIGOvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:51:42 -0400
Date: Tue, 7 Sep 2004 16:51:18 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve French <smfltc@us.ibm.com>
Subject: Re: [PATCH 4/4] copyfile: copyfile
Message-ID: <20040907145118.GA29993@wohnheim.fh-wedel.de>
References: <20040907120908.GB26630@wohnheim.fh-wedel.de> <20040907121118.GA27297@wohnheim.fh-wedel.de> <20040907121235.GB27297@wohnheim.fh-wedel.de> <20040907121520.GC27297@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0409070656150.2299@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0409070656150.2299@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 September 2004 07:06:00 -0700, Linus Torvalds wrote:
> 
> Then you could (and should) make a "generic_file_copy()" function that
> takes that pathname format, and then uses sendfile() to do the copy for
> regular disk-based filesystems.

Does that mean that you're ok with the first three patches?

> I think you should be able to copy the "sys_link()" code for almost all of 
> the top-level stuff. The only real difference being
> 
> -	error = dir->i_op->link(old_dentry, dir, new_dentry);
> +	error = dir->i_op->copy(old_dentry, dir, new_dentry);
> 
> or something.

ok.

> And no, I don't know how to handle interruptability.

How about the loop in 3/4?

> I think the right
> answer may be that filesystems that don't support this as a "native op"  
> and can't do it quickly should just return an error, and then users can
> copy their multi-gigabyte files by hand, like they used to.
> 
> So if we do this, we do this _right_. We also make sure that we error out 
> "too much" rather than "too little", so that people don't start depending 
> on behaviour that we don't want them to depend on. 

Makes sense, as long as any disk filesystem can decide to add a
one-liner like
	.copy = generic_file_copy;
to their operations and explicitly allow this.  Cowlinks remain my pet
project, even if I get distracted by Real Work sometimes.  Without
some form of in-kernel copy, they'd be dead in the water.

Jörn

-- 
Fantasy is more important than knowledge. Knowledge is limited,
while fantasy embraces the whole world.
-- Albert Einstein
