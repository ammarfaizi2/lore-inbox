Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbTLDSoP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTLDSoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:44:11 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:1182 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263460AbTLDSn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:43:57 -0500
Date: Thu, 4 Dec 2003 19:40:34 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem
Message-ID: <20031204184033.GA14029@wohnheim.fh-wedel.de>
References: <1070485676.4855.16.camel@nucleon> <20031203214443.GA23693@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0312031600460.2055@home.osdl.org> <20031204141725.GC7890@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0312040712270.2055@home.osdl.org> <20031204172653.GA12516@wohnheim.fh-wedel.de> <3FCF7AD5.4050501@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3FCF7AD5.4050501@lougher.demon.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 December 2003 18:20:05 +0000, Phillip Lougher wrote:
> Jörn Engel wrote:
> >
> >So - as sick as it sounds - jffs2 may actually be the fs of choice
> >when doing encryption, even though working on a hard drive and not
> >flash.  Cool. :)
> >
> 
> Considering that Jffs2 is the only writeable compressed filesystem, yes. 
>  What should be borne in mind is compressed filesystems never expect 
> the data after compression to be bigger than the original data.  In the 
> case where the compressed data is bigger, the original data is used 
> instead, which is hardy ideal for an encrypted filesystem, and so more 
> than a direct substitution of compression function for encrypt function 
> is needed - this is of course only relevant if the encryption algorithm 
> used could return more data...

Correct.  But this requirement can easily be weakened a enough for
encryption to work.  A couple ALIGN(..., encrypt_blocksize) at two or
three places should do the trick.

> >Depends on how much security you really care about.  If you really
> >don't mind the pain involved, some metadata should explicitly *not* be
> >encrypted, to avoid known plaintext attacks.  To a serious attacker,
> >this could be a death stroke for ext[23] over cryptoloop, actually.
> 
> You're assuming the metadata (inodes, indexes and directory entries), 
> are encrypted with the same key, and therefore decrypting the directory 
> data using plaintext attacks will give the attacker the key to the 
> entire metadata?  There is nothing preventing the directory data being 
> encrypted separately with a different key, and therefore a plaintext 
> attack would get nothing more than the directory information.

True, although that barely makes a difference.  In either case you
have to seperate known-plaintext data from the rest and either not
encrypt it or use a different key.  The hard part is seperating the
data.

> As you say, you highlight a drawback with cryptoloop and cloop, because 
> they cannot distinquish between different types of data.  This sort of 
> thing should always be done at the fs level rather than the block level...

If it is done, yes.  "fsck it, who cares" may also be a valid design.

> >In real life, though, the humans are usually the weakest link, so this
> >doesn't matter anyway.
> 
> Hmmm, why not give give up completely then?

Because it is fun doing so or someone pays for it.  And - more to the
point - the humans should be the weakest link, that is bad enough
already.  No reason to make/leave things worse.

Jörn

-- 
To recognize individual spam features you have to try to get into the
mind of the spammer, and frankly I want to spend as little time inside
the minds of spammers as possible.
-- Paul Graham
