Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUGKO37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUGKO37 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 10:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266607AbUGKO37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 10:29:59 -0400
Received: from mail014.syd.optusnet.com.au ([211.29.132.160]:1417 "EHLO
	mail014.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266603AbUGKO3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 10:29:54 -0400
Message-ID: <40F14ECB.909@kolivas.org>
Date: Mon, 12 Jul 2004 00:29:31 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, ck kernel mailing list <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: [announce] [patch] Voluntary Kernel Preemption Patch
References: <20040709182638.GA11310@elte.hu>	<20040709195105.GA4807@infradead.org>	<20040710124814.GA27345@elte.hu> <40F0075C.2070607@kolivas.org>	<40F016D9.8070300@kolivas.org> <20040711064730.GA11254@elte.hu> <40F14E53.2030300@kolivas.org>
In-Reply-To: <40F14E53.2030300@kolivas.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig593A728307397E5EAC091219"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig593A728307397E5EAC091219
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:
> Ingo Molnar wrote:
> 
>> * Con Kolivas <kernel@kolivas.org> wrote:
>>
>>
>>> Ooops forgot to mention this was running reiserFS 3.6 on software
>>> raid0 2x IDE with cfq elevator.
>>
>>
>>
>> ok, reiserfs (and all journalling fs's) definitely need a look - as you
>> can see from the ext3 mods in the patch. Any chance you could try ext3
>> based tests? Those are the closest to my setups.
>>
> 
> Ok I've done one better than that ;) I had wli help make some 
> instrumentation for me to help find the remaining non preemptible kernel 
> portions and set the cutoff to 2ms. Here is what I found:
> 
> 7ms non-preemptible critical section violated 2 ms preempt threshold 
> starting at reiserfs_sync_fs+0x2d/0xc2 and ending at reiser
> fs_lookup+0xe2/0x221
> 
> 9ms non-preemptible critical section violated 2 ms preempt threshold 
> starting at reiserfs_dirty_inode+0x37/0x10e and ending at r
> eiserfs_dirty_inode+0xb0/0x10e
> 
> 
> These seem to be the two offenders. Hope this helps.

Oh and here are two different ones:

5ms non-preemptible critical section violated 2 ms preempt threshold 
starting at add_wait_queue+0x21/0x82 and ending at add_wait
_queue+0x4a/0x82

3ms non-preemptible critical section violated 2 ms preempt threshold 
starting at exit_mmap+0x1c/0x188 and ending at exit_mmap+0x
118/0x188

Con


--------------enig593A728307397E5EAC091219
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA8U7LZUg7+tp6mRURAg99AKCTR8J5GbwIKIMLCife7/m38sgP/gCffEAE
ISZaO/ZtxV0X8aHX5oKd4TM=
=qSN7
-----END PGP SIGNATURE-----

--------------enig593A728307397E5EAC091219--
