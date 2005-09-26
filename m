Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVIZWH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVIZWH2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 18:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVIZWH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 18:07:28 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:19702 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932088AbVIZWH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 18:07:28 -0400
Message-ID: <4338731B.4020301@stesmi.com>
Date: Tue, 27 Sep 2005 00:15:55 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have synced
 TSCs (resend)
References: <1127764012.8195.138.camel@cog.beaverton.ibm.com>
In-Reply-To: <1127764012.8195.138.camel@cog.beaverton.ibm.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi John.

> 	This patch should resolve the issue seen in bugme bug #5105, where it
> is assumed that dualcore x86_64 systems have synced TSCs. This is not
> the case, and alternate timesources should be used instead.
> 
> For more details, see:
> http://bugzilla.kernel.org/show_bug.cgi?id=5105
> 
> Andi's earlier concerns that the TSCs should be synced on dualcore
> systems have been resolved by confirmation from AMD folks that they can
> be unsynced.
> 
> Please consider for inclusion in your tree.

Wouldn't it be a good idea to change the comment following
the code you removed as well?

Why have a comment saying "multi socket systems" if there is no
distinction anymore?

> 
> diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
> --- a/arch/x86_64/kernel/time.c
> +++ b/arch/x86_64/kernel/time.c
> @@ -959,9 +959,6 @@ static __init int unsynchronized_tsc(voi
>   	   are handled in the OEM check above. */
>   	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>   		return 0;
> - 	/* All in a single socket - should be synchronized */
> - 	if (cpus_weight(cpu_core_map[0]) == num_online_cpus())
> - 		return 0;
>  #endif
>   	/* Assume multi socket systems are not synchronized */
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   	return num_online_cpus() > 1;

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFDOHMbBrn2kJu9P78RAnSlAKCE2NSTYbi553i0OGadmRfuMdD3hgCgwedE
blCF8zdC+fuTOgIuBy1Af60=
=T4tA
-----END PGP SIGNATURE-----
