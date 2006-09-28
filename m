Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751922AbWI1Q6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbWI1Q6s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbWI1Q6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:58:47 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36505 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751922AbWI1Q6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:58:46 -0400
X-Sasl-enc: HFhStMFfIiqOzIGcoYCeE1EkWrsr70q/7kfzKgPMWdaS 1159462727
Message-ID: <451BFFA9.4030000@imap.cc>
Date: Thu, 28 Sep 2006 19:00:25 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Andy Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [2.6.18-rc7-mm1] slow boot
References: <4516B966.3010909@imap.cc> <20060924145337.ae152efd.akpm@osdl.org>
In-Reply-To: <20060924145337.ae152efd.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC1C690158FF66F670492E75A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC1C690158FF66F670492E75A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 24.09.2006 23:53, Andrew Morton wrote:
> Do you have the time to go through the
> http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt
> process?

Phew, it's done. And the winner is:

x86_64-mm-i386-stacktrace-unwinder.patch
--------8<--------8<--------8<--------8<--------8<--------8<--------
i386: Do stacktracer conversion too

Following x86-64 patches. Reuses code from them in fact.

Convert the standard backtracer to do all output using
callbacks.   Use the x86-64 stack tracer implementation
that uses these callbacks to implement the stacktrace interface.

This allows to use the new dwarf2 unwinder for stacktrace
and get better backtraces.

Cc: mingo@elte.hu

Signed-off-by: Andi Kleen <ak@suse.de>
-------->8-------->8-------->8-------->8-------->8-------->8--------

Backing out just this patch from 2.6.18-mm1 (and resolving conflicts
manually the obvious way) gets the boot time back to normal (ie. as
fast as 2.6.18 mainline) on my
Linux gx110 2.6.18-mm1-noinitrd #2 PREEMPT Thu Sep 28 18:48:32 CEST 2006 =
i686 i686 i386 GNU/Linux
machine.

Thanks
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enigC1C690158FF66F670492E75A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFG/+xMdB4Whm86/kRAuNFAJ9Y2qPpQzA7R3QVu3L6bqtmEETjKQCeOTa6
6yKLGPGJlGNXPCYRN+5IUPw=
=Ma+i
-----END PGP SIGNATURE-----

--------------enigC1C690158FF66F670492E75A--
