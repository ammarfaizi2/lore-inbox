Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267628AbUGWLDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267628AbUGWLDy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 07:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267627AbUGWLDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 07:03:54 -0400
Received: from reptilian.maxnet.nu ([212.209.142.131]:41735 "EHLO
	reptilian.maxnet.nu") by vger.kernel.org with ESMTP id S267628AbUGWLDq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 07:03:46 -0400
From: Thomas Habets <thomas@habets.pp.se>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Delete cryptoloop
Date: Fri, 23 Jul 2004 12:59:25 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200407231259.34844.thomas@habets.pp.se>
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

So in addition to making sure that everything on your systems works when 
switching from 2.4 to 2.6, we now have to hope that working APIs don't change 
(or disappear) in an incompatible way between minor versions? Is that right? 

Is there some kind of hidden motive behind this? For example, does the 
presence of cryptoloop force some other ugly part of the kernel to be in a 
certain way? If cryptoloop is removed, will you think "finally, I can change 
this other old crappy code"?

I will move to dm-crypt eventually if it's so much better, but cryptoloop 
works in practice *now* (mount knows about it etc..).

James Morris said:
>Part of the reason for dropping cryptoloop is to help dm-crypt mature more 
>quickly.

Reminds me of the futurama quote:
Fry: "Now that you mention it, I do have trouble breathing underwater 
sometimes. I'll take the gills."
Man: "Yes, gills. Then you don't need lungs anymore, is right?"
Fry: "Can't imagine why I would."
Man: "Lie down on table. I take lungs now, gills come next week."

(except that, well, lungs are better in both the short and long run for most 
humans, while dm-crypt may be better in the long run for secret things)

And I can't say I really see what's so horrible about cryptoloop. Dictionary 
attack being possible? Uhm, yeah, I kind of assumed that from the beginning. 
And I don't see how *any* mishandling of IV can matter to me. The block 
crypto (AES in this case) should have been (and I assume is) designed against 
all kinds of chosen-plaintext, chosen-ciphertext, differential cryptanalysis, 
etc... This *will* stop every offline attack from everyone who's interested 
in my data. In the actual real world. (If this assertion is wrong, I'd 
*really* like to know about it. But everything I've read on the insecurity of 
cryptoloop has convinced me that this is the case.[0])

If dm-crypt fixes some things, that's good. Now make it practical. And I'm 
growing old, I fear changes, I need time to adjust. I'm scared, where am I?

Also, being able to boot 2.4 and still have a compatible cryptoloop is nice 
while moving everything to 2.6. (and when everything is 2.6-perfect, one can 
switch to dm-crypt).

Mark it deprecated? Sure, whatever. But don't take away my cryptoloop!

from http://seclists.org/lists/linux-kernel/2004/Mar/0719.html:
>Sequential IV's aren't a good choice with CBC -- they can leak a little
>bit of information about the first block of plaintext, in some cases. 

Ah, this is interesting. The way I'm reading it this could only leak some 
"information" about maybe my superblock.
If this is what cryptoloop uses then it's bad. Still, it's not big-red-switch 
bad, just "try to find the time to switch this year" bad. At least for me.

[0] I'd be interested in both if non-NSA kan read it and if NSA is actually 
interested in my data. If you know of either, tell me. :-)

- ---------
typedef struct me_s {
  char name[]      = { "Thomas Habets" };
  char email[]     = { "thomas@habets.pp.se" };
  char kernel[]    = { "Linux 2.4" };
  char *pgpKey[]   = { "http://www.habets.pp.se/pubkey.txt" };
  char pgp[] = { "A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854" };
  char coolcmd[]   = { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBAO+WKGrpCq1I6FQRAn/SAKCyx20hCdEGzY58ZQeocIScDTk73QCeI+gq
ZZn1/PFtwOwldIZ9Xm8ekvY=
=kKqs
-----END PGP SIGNATURE-----
