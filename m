Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbVIZXXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbVIZXXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 19:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVIZXXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 19:23:00 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:65462 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932523AbVIZXW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 19:22:59 -0400
Message-ID: <433884C8.9050905@stesmi.com>
Date: Tue, 27 Sep 2005 01:31:20 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have	synced
 TSCs (resend)
References: <1127764012.8195.138.camel@cog.beaverton.ibm.com>	 <4338731B.4020301@stesmi.com> <1127773707.8195.145.camel@cog.beaverton.ibm.com>
In-Reply-To: <1127773707.8195.145.camel@cog.beaverton.ibm.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

john stultz wrote:
> On Tue, 2005-09-27 at 00:15 +0200, Stefan Smietanowski wrote:
> 
> 
>>Wouldn't it be a good idea to change the comment following
>>the code you removed as well?
>>
>>Why have a comment saying "multi socket systems" if there is no
>>distinction anymore?
>>

> Yea, good point, that should probably be "SMP systems". 
> 
> Do you want to send the patch to Andrew? :)

Sure. Something like this should suffice.

Signed-off-by: Stefan Smietanowski <stesmi@stesmi.com>

diff --git old/arch/x86_64/kernel/time.c new/arch/x86_64/kernel/time.c
- --- old/arch/x86_64/kernel/time.c
+++ new/arch/x86_64/kernel/time.c
@@ -959,11 +959,8 @@ static __init int unsynchronized_tsc(voi
  	   are handled in the OEM check above. */
  	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
  		return 0;
- - 	/* All in a single socket - should be synchronized */
- - 	if (cpus_weight(cpu_core_map[0]) == num_online_cpus())
- - 		return 0;
 #endif
- - 	/* Assume multi socket systems are not synchronized */
+ 	/* Assume SMP systems are not synchronized */
  	return num_online_cpus() > 1;
 }

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFDOITIBrn2kJu9P78RAopLAJ0anLvWElwgW+vmxJ7jPWehWF0F3gCfUXv8
2ORxa8Jfj9o4LE3P0A+dSTE=
=AGkR
-----END PGP SIGNATURE-----
