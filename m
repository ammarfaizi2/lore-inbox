Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269839AbUJHL2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269839AbUJHL2l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269864AbUJHL0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:26:15 -0400
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:23435 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S269841AbUJHLX7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:23:59 -0400
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: __init poisoning for i386, too
Date: Fri, 8 Oct 2004 04:23:53 -0700
User-Agent: KMail/1.7
References: <20041006221854.GA1622@elf.ucw.cz> <ck4b39$fmp$1@terminus.zytor.com> <20041008110845.GC9106@holomorphy.com>
In-Reply-To: <20041008110845.GC9106@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4959269.RQhaGkp06d";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410080423.57685.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4959269.RQhaGkp06d
Content-Type: multipart/mixed;
  boundary="Boundary-01=_KjnZBuYF+StSVYC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_KjnZBuYF+StSVYC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 08 October 2004 04:08, you wrote:
> On Thu, Oct 07, 2004 at 09:05:45PM +0000, H. Peter Anvin wrote:
> > What's wrong with using 0xCC (breakpoint instruction)?
> > If you want an illegal instruction, 0xFF 0xFF is an illegal
> > instruction, so filling memory with 0xFF will do what you want.
>
> That sounds better than what I suggested.
>

Here's the trivial patch against 2.4.9-rc3-mm3

-Ryan

--Boundary-01=_KjnZBuYF+StSVYC
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="trivial-initmem-tweak.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="trivial-initmem-tweak.diff"

--- linux-2.6.9-rc3-mm3/arch/i386/mm/init.c	2004-10-08 04:19:46.645395667 -0700
+++ linux-2.6.9-rc3-mm3-new/arch/i386/mm/init.c	2004-10-08 04:21:51.933318774 -0700
@@ -723,7 +723,7 @@
 	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));
 		set_page_count(virt_to_page(addr), 1);
-		memset((void *)(addr & ~(PAGE_SIZE-1)), 0xcc, PAGE_SIZE);
+		memset((void *)(addr & ~(PAGE_SIZE-1)), 0xff, PAGE_SIZE);
 		free_page(addr);
 		totalram_pages++;
 	}

--Boundary-01=_KjnZBuYF+StSVYC--

--nextPart4959269.RQhaGkp06d
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBZnjNW4yVCW5p+qYRAotlAJwOm976mQjgBvyXx6FoQ33F9KMz6wCeLYoP
1NQ6MUl7jSUHl3fkrX/8k8E=
=3SbU
-----END PGP SIGNATURE-----

--nextPart4959269.RQhaGkp06d--
