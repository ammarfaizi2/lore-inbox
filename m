Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264876AbUDWQ6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264876AbUDWQ6o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 12:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUDWQ6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 12:58:43 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:33474 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264876AbUDWQ5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 12:57:51 -0400
Date: Fri, 23 Apr 2004 18:57:39 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Guillaume =?iso-8859-1?Q?Lac=F4te?= <Guillaume@lacote.name>
Cc: linux-kernel@vger.kernel.org, Linux@glacote.com
Subject: Re: Using compression before encryption in device-mapper
Message-ID: <20040423165739.GB16000@wohnheim.fh-wedel.de>
References: <200404131744.40098.Guillaume@Lacote.name> <200404221506.43017.Guillaume@Lacote.name> <20040422160033.GB23746@wohnheim.fh-wedel.de> <200404231716.53481.Guillaume@Lacote.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200404231716.53481.Guillaume@Lacote.name>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 April 2004 17:16:53 +0200, Guillaume Lacôte wrote:
> 
> Feel free to ignore all of my reply; please note that I am not trying to "be 
> right" or to "be wrong" but I still do not understand ... Thank you still for 
> your time and pedagogy.

No need to mention this.  I'll stop whenever I feel like it.

> > Yeah, sure, the attacker has no idea what the plaintext of those
> > blocks is, but if they appear often enough, it has to be something
> > quite common.  Something like, say, all ones or all zeros.  Or like
> > one of those 48 common huffman encodings thereof.
> > [...]
> > So what!  You end up with maybe three bits per zero (assuming all
> > zeros).  Depending on the size of random data up front, they start
> > with bit 1, 2 or 3.  Makes 3*2^3 or 24 possibilities.  Same for all
> > ones, give a total of 48.  Great, a dictionary attack is 48x slower
> > now!
> > [...]
> > Still, towards the end of all-ones or all-zeros, each byte will be
> > encoded with the same 1-3bit value.
> The point I fail to understand is the following : you know the enciphered 
> value of these 1-3bits. But how can you know what is 
> compressed-but-deciphered 1-3bit value ? Ok my text contains only 0s. OK 
> these 0s appear to be "011" once encrypted. How do you launch your 
> dictionnary attack ? You do _not_ (?) know what the 3bit deciphered code for 
> "0" is. Or maybe you do ?

I know the encrypted text and I know it is common, so the uncompressed
decrypted text is likely 0x00,...  Now, what may the compressed
decyphered text be?  It could be:
000,000,...
001,001,...
010,010,...
011,011,...
.
.
.

Actually, the 000 and 111 cases don't even have three variants
depending on when they start, so the 48 above comes down to 40.  And
since I honestly don't case whether it was 0x00 or 0xff, that was
encrypted to 001,001,..., it even comes down to 20.

You are right, I don't know which one of those 20 it is, but I am
quite sure it is one of them.

> > In that case, what's your point.  If the key is strong and the
> > encryption is strong (I sure hope, AES is), nothing short of brute
> > force can be successful.  What are you protecting against?
> Maybe my "endless" story is absurd, but I am _not_ protecting against weak 
> keys; I am trying to protected against weak _data_ , which is the basis for 
> dictionnary attacks even in the case of perfectly random keys.

Show me the paper.  Since when is AES weak against known plaintext
attacks?

Jörn

-- 
The grand essentials of happiness are: something to do, something to
love, and something to hope for.
-- Allan K. Chalmers
