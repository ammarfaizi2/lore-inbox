Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268515AbUHYHhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268515AbUHYHhm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 03:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268518AbUHYHhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 03:37:42 -0400
Received: from ns.suse.cz ([82.119.242.84]:22029 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id S268515AbUHYHhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 03:37:36 -0400
Message-ID: <412C41BC.8020607@suse.cz>
Date: Wed, 25 Aug 2004 09:37:32 +0200
From: Michal Ludvig <mludvig@suse.cz>
Organization: SuSE CR, s.r.o.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040606
X-Accept-Language: cs, cz, en
MIME-Version: 1.0
To: Michael Halcrow <mahalcro@us.ibm.com>
Cc: CryptoAPI List <cryptoapi@lists.logix.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /dev/crypto for Linux
References: <412BB517.4040204@suse.cz> <20040824215351.GA9272@halcrow.us>
In-Reply-To: <20040824215351.GA9272@halcrow.us>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Michael Halcrow told me that:
> On Tue, Aug 24, 2004 at 11:37:27PM +0200, Michal Ludvig wrote:
>
>>attached is a driver for OpenBSD-like /dev/crypto device (aka
>>CryptoDev) that makes a way for userspace processes to access
>>ciphers provided by in-kernel CryptoAPI modules.
>
> Cool!  Now if I'm interpreting this right, this is only good for
> working on up to one page worth of data at a time, right?

Of course the userspace can request encrypting any amount of data (well,
multiple of blocksize), but only at most one page at a time is copied
into the kernel, encrypted and returned back to the process' memory.

IMHO It is faster than allocating e.g. 4 MB in the kernel, copying all
of this from userspace, encrypting and returning back. That wouldn't use
the CPU cache too efficiently.

> In cryptfs, I have written some functions that essentially do what
> your FILL_SG() macro does, only it spreads across multiple sg's, if
> necessary.  Do you think this might be appropriate for /dev/crypto?

As I'm currently working only on one kernel page at a time I think
FILL_SG() is sufficient. But I'm definitely interested how to use
multiple sg's at once (although I don't immediately ned it). Where can I
see these functions? Maybe thay could go to some library directly in
linux/crypto/...?

Michal Ludvig
- --
SUSE Labs                    mludvig@suse.cz
(+420) 296.542.396        http://www.suse.cz
Personal homepage http://www.logix.cz/michal
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBLEGhDDolCcRbIhgRApPrAJ9ghoyWXhxnk+wUQL9evde3o5uDqgCfdde8
OsMo/MlzKifupt1+pbNovYk=
=yKGK
-----END PGP SIGNATURE-----
