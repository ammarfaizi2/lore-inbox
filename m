Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266604AbUGKO23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266604AbUGKO23 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 10:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUGKO22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 10:28:28 -0400
Received: from mail007.syd.optusnet.com.au ([211.29.132.55]:10907 "EHLO
	mail007.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266604AbUGKO2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 10:28:02 -0400
Message-ID: <40F14E53.2030300@kolivas.org>
Date: Mon, 12 Jul 2004 00:27:31 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: ck kernel mailing list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ck] Re: [announce] [patch] Voluntary Kernel Preemption Patch
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040710124814.GA27345@elte.hu> <40F0075C.2070607@kolivas.org> <40F016D9.8070300@kolivas.org> <20040711064730.GA11254@elte.hu>
In-Reply-To: <20040711064730.GA11254@elte.hu>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4F1A8EAD7BDA06E1F70F7083"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4F1A8EAD7BDA06E1F70F7083
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
> 
>>Ooops forgot to mention this was running reiserFS 3.6 on software
>>raid0 2x IDE with cfq elevator.
> 
> 
> ok, reiserfs (and all journalling fs's) definitely need a look - as you
> can see from the ext3 mods in the patch. Any chance you could try ext3
> based tests? Those are the closest to my setups.
> 

Ok I've done one better than that ;) I had wli help make some 
instrumentation for me to help find the remaining non preemptible kernel 
portions and set the cutoff to 2ms. Here is what I found:

7ms non-preemptible critical section violated 2 ms preempt threshold 
starting at reiserfs_sync_fs+0x2d/0xc2 and ending at reiser
fs_lookup+0xe2/0x221

9ms non-preemptible critical section violated 2 ms preempt threshold 
starting at reiserfs_dirty_inode+0x37/0x10e and ending at r
eiserfs_dirty_inode+0xb0/0x10e


These seem to be the two offenders. Hope this helps.

Con

--------------enig4F1A8EAD7BDA06E1F70F7083
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA8U5VZUg7+tp6mRURAgYJAJ9S/lAwadkgqu2MM29Jje/e5rA8EACffg6p
FaSyE8UZX/nmQLHDt0QMn5Y=
=e4ap
-----END PGP SIGNATURE-----

--------------enig4F1A8EAD7BDA06E1F70F7083--
