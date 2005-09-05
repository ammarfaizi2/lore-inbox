Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbVIEHtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbVIEHtp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 03:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVIEHtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 03:49:45 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:59332 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S932279AbVIEHto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 03:49:44 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: rc5 seemed to kill a disk that rc4-mm1 likes. Also some X trouble.
Date: Mon, 5 Sep 2005 09:49:31 +0200
User-Agent: KMail/1.8.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Dave Airlie <airlied@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Michael Ellerman <michael@ellerman.id.au>,
       Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> <Pine.LNX.4.58.0508221034090.3317@g5.osdl.org> <200508301007.11554@bilbo.math.uni-mannheim.de>
In-Reply-To: <200508301007.11554@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1454242.8FTKg1DQok";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509050949.38842@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1454242.8FTKg1DQok
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Dienstag, 30. August 2005 10:07 schrieb Rolf Eike Beer:
>Linus Torvalds wrote:
>>On Mon, 22 Aug 2005, Rolf Eike Beer wrote:
>>> >It's a PII-350 with more or less SuSE 9.3. The machine has no net
>>> > access, so I can only try to narrow it down to one rc at the weekend.
>>>
>>> 2.6.12 works fine, everything since 2.6.13-rc1 breaks it.
>>
>>Gaah. I don't see anything really obvious in that range. However, I notice
>>that pci_mmap_resource() (in drivers/pci/pci-sysfs.c) now has
>>
>>+       if (i >= PCI_ROM_RESOURCE)
>>+               return -ENODEV;
>>
>>which seems a big bogus. Why wouldn't we allow the ROM resource to be
>>mapped? I could imagine that the X server would very much like to mmap it,
>>although I don't know if modern X actually does that. The fact that it
>>works when root runs the X server and causes problems for normal users
>>does seem like there's something that root can do that users can't do, and
>>doing a mmap() on /dev/mem might be just that.
>>
>>Eike, maybe you could change the ">=" to just ">" instead?
>>
>>PS. The patch that introduced this was billed as "no change for anything
>>but ppc". Tssk.
>
>This does not fix the problem. I'll narrow it down to one git snapshot next
>weekend (forgot the tarball on friday).

The problem appeared between 2.6.12-git3 and 2.6.12-git4.

Eike

--nextPart1454242.8FTKg1DQok
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDG/iSXKSJPmm5/E4RAjN5AKCNGmipf/kbTBVaPoZNiAzRPpMz/QCgo5rL
ldM9sGpkmqw/e37SJabwEJQ=
=DT9u
-----END PGP SIGNATURE-----

--nextPart1454242.8FTKg1DQok--
