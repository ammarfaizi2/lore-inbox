Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbTLDSXO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTLDSXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:23:14 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:23819 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S263402AbTLDSXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:23:06 -0500
Message-ID: <3FCF7AD5.4050501@lougher.demon.co.uk>
Date: Thu, 04 Dec 2003 18:20:05 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.2.1) Gecko/20030228
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem
References: <1070485676.4855.16.camel@nucleon> <20031203214443.GA23693@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0312031600460.2055@home.osdl.org> <20031204141725.GC7890@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0312040712270.2055@home.osdl.org> <20031204172653.GA12516@wohnheim.fh-wedel.de>
In-Reply-To: <20031204172653.GA12516@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> 
> So - as sick as it sounds - jffs2 may actually be the fs of choice
> when doing encryption, even though working on a hard drive and not
> flash.  Cool. :)
> 

Considering that Jffs2 is the only writeable compressed filesystem, yes. 
  What should be borne in mind is compressed filesystems never expect 
the data after compression to be bigger than the original data.  In the 
case where the compressed data is bigger, the original data is used 
instead, which is hardy ideal for an encrypted filesystem, and so more 
than a direct substitution of compression function for encrypt function 
is needed - this is of course only relevant if the encryption algorithm 
used could return more data...


> 
> Depends on how much security you really care about.  If you really
> don't mind the pain involved, some metadata should explicitly *not* be
> encrypted, to avoid known plaintext attacks.  To a serious attacker,
> this could be a death stroke for ext[23] over cryptoloop, actually.
> 

You're assuming the metadata (inodes, indexes and directory entries), 
are encrypted with the same key, and therefore decrypting the directory 
data using plaintext attacks will give the attacker the key to the 
entire metadata?  There is nothing preventing the directory data being 
encrypted separately with a different key, and therefore a plaintext 
attack would get nothing more than the directory information.

As you say, you highlight a drawback with cryptoloop and cloop, because 
they cannot distinquish between different types of data.  This sort of 
thing should always be done at the fs level rather than the block level...

> In real life, though, the humans are usually the weakest link, so this
> doesn't matter anyway.
> 

Hmmm, why not give give up completely then?

Phillip

