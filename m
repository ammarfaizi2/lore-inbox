Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUEVPQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUEVPQi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 11:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUEVPQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 11:16:37 -0400
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:44724 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S261563AbUEVPQ1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 11:16:27 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
Date: Sat, 22 May 2004 12:10:58 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Jakub Jelinek <jakub@redhat.com>,
       mingo@redhat.com
References: <20040520093817.GX30909@devserv.devel.redhat.com> <20040521160510.4214c7a3.akpm@osdl.org>
In-Reply-To: <20040521160510.4214c7a3.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200405221211.00938.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 22 May 2004 01:05, Andrew Morton wrote:
> You've added an smp_mb().  These things are becoming like lock_kernel() -
> hard for the reader to discern what it's protecting against.
> 
> Please always include a comment when adding a barrier like this.

What about including this in the API?

sth. like 

#define smp_mb(why) do { \
	static __debugdata__ char __lock_reason[] = why; \
	} while(0)


would be sufficient. __debugdata__ section
will then be stripped from compressed image but not vmlinux.


Is there another way to force developers to comment? ;-)


Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFArycyU56oYWuOrkARAljxAKDNE04H2/zr+rZcu1SAR3x19rUtHgCgwqKV
+Mpszd42hQ7hDQjphDobNRk=
=gh0g
-----END PGP SIGNATURE-----

