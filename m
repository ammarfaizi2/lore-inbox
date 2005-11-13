Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbVKMCQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbVKMCQB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 21:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVKMCQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 21:16:01 -0500
Received: from smtp3.hushmail.com ([65.39.178.135]:60944 "EHLO
	smtp3.hushmail.com") by vger.kernel.org with ESMTP id S1750812AbVKMCQA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 21:16:00 -0500
Message-Id: <200511130215.jAD2Fn2H020249@mailserver2.hushmail.com>
Date: Sat, 12 Nov 2005 18:15:46 -0800
To: <linux-kernel@vger.kernel.org>
Subject: linux/fs/binfmt_elf.c removal of check
From: <sigint@hush.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Attached is a small patch that deletes an unneccesary check in
binfmt_elf.c load_elf_binary().

'end_code' is initialized to 0 on line 602 but 'k' is initialized
to 'k = elf_ppnt->p_vaddr + elf_ppnt->p_filesz' on line 880. This
check (may) not be neccessary because on line 614 elf_ppnt-
>p_filesz is checked against PATH_MAX and the integer 2. elf_ppnt-
>p_filesz does not appear to be altered before the check. Please
double check the change, but I do not think the comparison is
needed on line 881. I am not on the list please CC me on any
replies. Thanks

patch produced with 'diff -Npur'

- --- a/fs/binfmt_elf.c   2005-11-12 22:19:08.000000000 -0500
+++ b/fs/binfmt_elf.c   2005-11-12 22:17:54.000000000 -0500
@@ -878,7 +878,7 @@ static int load_elf_binary(struct linux_

                if (k > elf_bss)
                        elf_bss = k;
- -               if ((elf_ppnt->p_flags & PF_X) && end_code < k)
+               if ((elf_ppnt->p_flags & PF_X))
                        end_code = k;
                if (end_data < k)
                        end_data = k;
-----BEGIN PGP SIGNATURE-----
Note: This signature can be verified at https://www.hushtools.com/verify
Version: Hush 2.4

wkYEARECAAYFAkN2slwACgkQ8+KJMsQVzCE42gCgiYrs5iWz95OlcZRgYGxJh7XeZd8A
n3pGiikzdQh2RJe/GLJbyy/Q427/
=TTTY
-----END PGP SIGNATURE-----




Concerned about your privacy? Instantly send FREE secure email, no account required
http://www.hushmail.com/send?l=480

Get the best prices on SSL certificates from Hushmail
https://www.hushssl.com?l=485

