Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265606AbSKAEgB>; Thu, 31 Oct 2002 23:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265607AbSKAEgB>; Thu, 31 Oct 2002 23:36:01 -0500
Received: from thunk.org ([140.239.227.29]:40327 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S265606AbSKAEf7>;
	Thu, 31 Oct 2002 23:35:59 -0500
Date: Thu, 31 Oct 2002 23:41:53 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Matthew J. Fanto" <mattf@mattjf.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The Ext3sj Filesystem
Message-ID: <20021101044153.GB12031@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"Matthew J. Fanto" <mattf@mattjf.com>, linux-kernel@vger.kernel.org
References: <200210301434.17901.mattf@mattjf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210301434.17901.mattf@mattjf.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 02:34:17PM -0500, Matthew J. Fanto wrote:
> 
> I am annoucing the development of the ext3sj filesystem. Ext3sj is a
> new encrypted filesystem based off ext3. Ext3sj is an improvement
> over the current loopback solution because we do not in fact require
> a loopback device. Encryption/decryption is transparent to the user,
> so the only thing they will need to know is their key, and how to
> mount a device.

Couple of points here.   

First of all, have you considered trying to do this as a stacking
filesystem?  Talk to the Intermezzo and Luster folks; they've gotten
quite good at stacking their value-added filesystem on top ext2/3.
This avoids code duplication, since now you don't have to track bug
fixes in the core ext2/3 code.  It also enforces functional
separation, and should your filesystem smaller and easier to maintain.
It also means that you can potentially use your code to provide crypto
services to other filesystems besides just ext3.

Secondly, the really critical question is key management.  What
happens if the user gets the key wrong?  Will he/she know?  Or will
they just get garbage if the read from the file, and be able to trash
the file if they write to the file with the incorrect key?  Using some
kind of key-ID and some way of validating that the key is correct
before the user does start accessing files would probably be a really
good idea.

Finally, if you do want to allocate some additional fields in the ext2
inode, superblock, etc., please coordinate with me, so we can avoid
conflicts as much as possible.  Thanks!!

					- Ted
