Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266527AbUGMVyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266527AbUGMVyW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266898AbUGMVyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:54:22 -0400
Received: from mail020.syd.optusnet.com.au ([211.29.132.131]:16013 "EHLO
	mail020.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266527AbUGMVxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:53:10 -0400
Message-ID: <40F459AF.1040501@kolivas.org>
Date: Wed, 14 Jul 2004 07:52:47 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: Preempt Threshold Measurements
References: <200407121943.25196.devenyga@mcmaster.ca>	<20040713024051.GQ21066@holomorphy.com>	<200407122248.50377.devenyga@mcmaster.ca>	<cone.1089687290.911943.12958.502@pc.kolivas.org>	<20040712210107.1945ac34.akpm@osdl.org>	<cone.1089697919.186986.12958.502@pc.kolivas.org> <20040712231406.427caa2a.akpm@osdl.org>
In-Reply-To: <20040712231406.427caa2a.akpm@osdl.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig61F45D7A991DB24C4B604764"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig61F45D7A991DB24C4B604764
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> This can run under one of two depths of lock_kernel.  filemap_fdatawrite()
> and filemap_fdatawait() both do cond_resched(), so this is odd.
> 
> Try this:
> 
> --- 25/mm/truncate.c~truncate_inode_pages-latency-fix	2004-07-12 23:12:53.871816320 -0700
> +++ 25-akpm/mm/truncate.c	2004-07-12 23:13:00.993733624 -0700
> @@ -155,6 +155,7 @@ void truncate_inode_pages(struct address
>  
>  	next = start;
>  	for ( ; ; ) {
> +		cond_resched();
>  		if (!pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
>  			if (next == start)
>  				break;
> _

I had a few of these with this patch. Is it cond_resched'ing twice?

Con

2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at flush_commit_list+0x11d/0x3ee and ending at schedule+0x216/0x841
  [<c011d769>] dec_preempt_count+0x14f/0x151
  [<c031d716>] schedule+0x216/0x841
  [<c031d716>] schedule+0x216/0x841
  [<c01085c7>] do_IRQ+0x176/0x1eb
  [<c01040b3>] cpu_idle+0x3a/0x3c
  [<c040094c>] start_kernel+0x19c/0x1e8
  [<c0400402>] unknown_bootoption+0x0/0x15e

2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at do_journal_end+0x539/0xae8 and ending at schedule+0x216/0x841
  [<c011d769>] dec_preempt_count+0x14f/0x151
  [<c031d716>] schedule+0x216/0x841
  [<c031d716>] schedule+0x216/0x841
  [<c0116284>] smp_apic_timer_interrupt+0x97/0x166
  [<c01040b3>] cpu_idle+0x3a/0x3c
  [<c0120659>] call_console_drivers+0xcd/0xea
  [<c01209da>] release_console_sem+0xa3/0x101
  [<c012088a>] printk+0x13d/0x19c

2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at flush_async_commits+0x1b/0xf7 and ending at schedule+0x216/0x841
  [<c011d769>] dec_preempt_count+0x14f/0x151
  [<c031d716>] schedule+0x216/0x841
  [<c031d716>] schedule+0x216/0x841
  [<c011b88c>] load_balance+0x147/0x1ff
  [<c0116284>] smp_apic_timer_interrupt+0x97/0x166
  [<c010604e>] work_resched+0x5/0x16

--------------enig61F45D7A991DB24C4B604764
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA9FmyZUg7+tp6mRURAiQyAKCUuMIdq4Ezp4d/rTQaSiP1g4OOfACggujA
vkb90s7mPett568Gqa+/3Vc=
=dlP+
-----END PGP SIGNATURE-----

--------------enig61F45D7A991DB24C4B604764--
