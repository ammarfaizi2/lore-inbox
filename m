Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266757AbUBGKrR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 05:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266775AbUBGKrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 05:47:17 -0500
Received: from mail.shareable.org ([81.29.64.88]:49872 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266757AbUBGKrQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 05:47:16 -0500
Date: Sat, 7 Feb 2004 10:47:12 +0000
From: Jamie Lokier <jamie@shareable.org>
To: the grugq <grugq@hcunix.net>
Cc: Hans Reiser <reiser@namesys.com>, Valdis.Kletnieks@vt.edu,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
Message-ID: <20040207104712.GA16093@mail.shareable.org>
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <200402040320.i143KCaD005184@turing-police.cc.vt.edu> <20040207002010.GF12503@mail.shareable.org> <40243C24.8080309@namesys.com> <40243F97.3040005@hcunix.net> <40247A63.1030200@namesys.com> <4024B618.2070202@hcunix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4024B618.2070202@hcunix.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the grugq wrote:
> If, on the other hand, we have a threat model of, say, the police, then 
> things are very different. In the UK, there is a law which requires you 
> to turn over your encryption keys when the court demands them. The 
> police have a tactic for extracting keys which involves physical 
> violence and intimidation. These are very effective against encryption. 

This is how to implement secure deletion cryptographically:

   - Each time a file is created, choose a random number.

   - Encrypt the number with your filesystem key and store the
     encrypted version in the inode.

   - The number is used for encrypting that file.

Secure deletion is then a matter of securely deleting the inode.
The file data does not have to be overwritten.

This is secure against many attacks that "secure deletion" by
overwriting is weak against.  This includes electron microscopes
looking at the data, and UK law.  (The police can demand your
filesystem key, but nobody knows the random number that belonged to a
new-deleted inode).

There is a chance the electron microscope may recover the number from
the securely deleted inode.  That is the weakness of this system,
therefore the inode data should be very thoroughly erased or itself
subject to careful cryptographic hding.

-- Jamie
