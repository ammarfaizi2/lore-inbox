Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266986AbUBGRXT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 12:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266987AbUBGRXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 12:23:19 -0500
Received: from zeus.kernel.org ([204.152.189.113]:7073 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266986AbUBGRXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 12:23:17 -0500
Date: Sat, 7 Feb 2004 18:22:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: the grugq <grugq@hcunix.net>, Hans Reiser <reiser@namesys.com>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
Message-ID: <20040207172222.GA318@elf.ucw.cz>
References: <20040207002010.GF12503@mail.shareable.org> <40243C24.8080309@namesys.com> <40243F97.3040005@hcunix.net> <40247A63.1030200@namesys.com> <4024B618.2070202@hcunix.net> <20040207104712.GA16093@mail.shareable.org> <4024C5DF.40609@hcunix.net> <20040207110912.GB16093@mail.shareable.org> <4024D019.2080402@hcunix.net> <20040207120121.GE16093@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207120121.GE16093@mail.shareable.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > As I now understand, you are proposing a file system which has per file 
> > encryption where the key is stored in the inode. The inode is then the 
> > only location with senstive data which needs to be removed.
> 
> Yes.
> 
> > Also, this proposal seems to me more related to how to implement an 
> > encrypted file system, than how to implement secure deletion on existing 
> > file systems.
> 
> Not really, this is pointing out an alternative means of secure
> deletion _if_ you have encryption.  The points I wanted to make were,
> most important first:
> 
>    - Overwriting data does not always do what you think it does.
>      Several block devices _do not_ overwrite the same storage blocks.
>      Thus it is dangerous to call something "secure deletion"
>      when it might not do anything at all.

But you have same vulnerability, crypto does not help here. If your
i-node happens to be put on other place, attacker still gets the key
intact etc.

There's not much you can do. [It may be even worse with that
crypto... If you kick the table while your top-secret .mpg.tgz collection
is accessed, you are likely to cause bad sector within i-node,
attacker can get the key, and decrypt it all. With on-place
overwriting he only gets one block.] 
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
