Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266874AbUBGMB1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 07:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266875AbUBGMB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 07:01:27 -0500
Received: from mail.shareable.org ([81.29.64.88]:56272 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266874AbUBGMBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 07:01:25 -0500
Date: Sat, 7 Feb 2004 12:01:21 +0000
From: Jamie Lokier <jamie@shareable.org>
To: the grugq <grugq@hcunix.net>
Cc: Hans Reiser <reiser@namesys.com>, Valdis.Kletnieks@vt.edu,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
Message-ID: <20040207120121.GE16093@mail.shareable.org>
References: <200402040320.i143KCaD005184@turing-police.cc.vt.edu> <20040207002010.GF12503@mail.shareable.org> <40243C24.8080309@namesys.com> <40243F97.3040005@hcunix.net> <40247A63.1030200@namesys.com> <4024B618.2070202@hcunix.net> <20040207104712.GA16093@mail.shareable.org> <4024C5DF.40609@hcunix.net> <20040207110912.GB16093@mail.shareable.org> <4024D019.2080402@hcunix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4024D019.2080402@hcunix.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the grugq wrote:
> As I now understand, you are proposing a file system which has per file 
> encryption where the key is stored in the inode. The inode is then the 
> only location with senstive data which needs to be removed.

Yes.

> Also, this proposal seems to me more related to how to implement an 
> encrypted file system, than how to implement secure deletion on existing 
> file systems.

Not really, this is pointing out an alternative means of secure
deletion _if_ you have encryption.  The points I wanted to make were,
most important first:

   - Overwriting data does not always do what you think it does.
     Several block devices _do not_ overwrite the same storage blocks.
     Thus it is dangerous to call something "secure deletion"
     when it might not do anything at all.

   - Filesystems on top of encrypted block devices _do_ need
     overwriting-based secure deletion, if they are of the type where
     the block encryption key is derived from the block offset and device
     key only.

   - Eraseable per-file keys may be a more secure way of destroying
     data than overwriting data on a magnetic medium.

-- Jamie
