Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266812AbUBGLFc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 06:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266814AbUBGLFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 06:05:32 -0500
Received: from www.trustcorps.com ([213.165.226.2]:34821 "EHLO raq1.nitrex.net")
	by vger.kernel.org with ESMTP id S266812AbUBGLF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 06:05:26 -0500
Message-ID: <4024C5DF.40609@hcunix.net>
Date: Sat, 07 Feb 2004 11:02:55 +0000
From: the grugq <grugq@hcunix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Hans Reiser <reiser@namesys.com>, Valdis.Kletnieks@vt.edu,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <200402040320.i143KCaD005184@turing-police.cc.vt.edu> <20040207002010.GF12503@mail.shareable.org> <40243C24.8080309@namesys.com> <40243F97.3040005@hcunix.net> <40247A63.1030200@namesys.com> <4024B618.2070202@hcunix.net> <20040207104712.GA16093@mail.shareable.org>
In-Reply-To: <20040207104712.GA16093@mail.shareable.org>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the allocation of the inode and data blocks should be randomized 
for security, but that would lead to performance impacts. Implementing 
that should definately be a compile time option.

I would advocate erasing all meta-data on a file, and also erasing the 
data. The end-user can be responsible for erasing the data, they can 
access it with write(), but they can't access the meta-data (not without 
directly accessing the file system). Thats why I'm putting these patches 
forward. The file system should be responsible for removing meta-data 
when a file is deleted. This secure deletion doesn't have to incorporate 
data block erasure (although my implemenation does).

Your suggestion would certainly work, but I think the performance impact 
of using random inodes and data blocks would dissuade many from having 
it enabled by default. Simple secure deletion of the data and meta-data 
would have a lower impact, and be more likely to be used on more file 
systems.


peace,

--gq

> 
> This is how to implement secure deletion cryptographically:
> 
>    - Each time a file is created, choose a random number.
> 
>    - Encrypt the number with your filesystem key and store the
>      encrypted version in the inode.
> 
>    - The number is used for encrypting that file.
> 
> Secure deletion is then a matter of securely deleting the inode.
> The file data does not have to be overwritten.
> 
> This is secure against many attacks that "secure deletion" by
> overwriting is weak against.  This includes electron microscopes
> looking at the data, and UK law.  (The police can demand your
> filesystem key, but nobody knows the random number that belonged to a
> new-deleted inode).
> 
> There is a chance the electron microscope may recover the number from
> the securely deleted inode.  That is the weakness of this system,
> therefore the inode data should be very thoroughly erased or itself
> subject to careful cryptographic hding.

