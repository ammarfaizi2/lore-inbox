Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUHYOmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUHYOmJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 10:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266262AbUHYOmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 10:42:08 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:55020 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S266193AbUHYOl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 10:41:58 -0400
Message-ID: <412CA52E.3000907@suse.cz>
Date: Wed, 25 Aug 2004 16:41:50 +0200
From: Michal Ludvig <mludvig@suse.cz>
Organization: SuSE CR, s.r.o.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040606
X-Accept-Language: cs, cz, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Michael Halcrow <mahalcro@us.ibm.com>,
       CryptoAPI List <cryptoapi@lists.logix.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /dev/crypto for Linux
References: <412BB517.4040204@suse.cz> <20040824215351.GA9272@halcrow.us> <412C41BC.8020607@suse.cz> <412C9F89.7000901@pobox.com>
In-Reply-To: <412C9F89.7000901@pobox.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Garzik told me that:
>
>> What is it good for? One can build really light-weigth programs
>> with crypto support that don't need any external libraries (e.g.
>> OpenSSL) or built-in algorithms. Easier testing of new CryptoAPI
>> ciphers (later also hashes and maybe asymmetric ciphers as well).
>> Once, maybe, userspace access to crypto accelerators through kernel
>>  drivers.
>
> Let's see...
>
> 1) This increases context switches over a solution that links with
> libcrypto and libssl.

Indeed. It is not ment to replace libcrypto - just a possibility if needed.

> 2) "build really lightweight programs with crypto support" implies
> that you think it's a benefit to use the kernel as your crypto lib.

Yes, I think it may come handy in some scenarios. The algorithm is there
in the kernel so why not use it from the userspace?

Also (a wild guess) similar interface could provide access to some
key-management done in the kernel.

> 3) Your proposal actually avoids existing, working hardware crypto
> support such as Broadcom's hwcrypto driver which is fully supported
> by openssh.

Why avoids? I don't force OpenSSH to use it and I agree that typically
the everything-in-the-userspace is better/faster. This is just an option
for situations where no other cryptolib is available.

On my todo list is adding a module option for selecting allowed
algorithms. Something like "allow=-ALL:+aes:+sha1".

> 4) "open it and use ioctls to transfer data" is typically a bad idea.
>  ioctl(2) is a historical Unix mistake, to be avoided where possible.
>  read(2)/write(2) are to be used to transfer data.

Well yes, my driver actually reuses the API from OpenBSD. I have no
problem in changing (or extending) it but for now I did it this way for
easier testing with the OpenSSL cryptodev engine. This can definitely
evolve...

Michal Ludvig
- --
SUSE Labs                    mludvig@suse.cz
(+420) 296.542.396        http://www.suse.cz
Personal homepage http://www.logix.cz/michal
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBLKUoDDolCcRbIhgRApyzAKDYFtdhhDWgGeOtivbzPqsLbFT4ZACaA4H0
rdxbrN0z31pNtMomjMevbZU=
=6XVI
-----END PGP SIGNATURE-----
