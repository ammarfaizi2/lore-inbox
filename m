Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUAJPTo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 10:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbUAJPTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 10:19:44 -0500
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:45214 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S265232AbUAJPTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 10:19:41 -0500
Date: Sat, 10 Jan 2004 16:19:36 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: John Reiser <jreiser@BitWagon.com>
Subject: Re: Linux 2.2. ELF loader mystery
Message-Id: <20040110161936.57954de8@argon.inf.tu-dresden.de>
In-Reply-To: <4000135C.4060008@BitWagon.com>
References: <20040110145329.36ecaa38@argon.inf.tu-dresden.de>
	<4000135C.4060008@BitWagon.com>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__10_Jan_2004_16_19_36_+0100_qq4Ug9pbBCDj.TYi"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__10_Jan_2004_16_19_36_+0100_qq4Ug9pbBCDj.TYi
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sat, 10 Jan 2004 06:59:40 -0800 John Reiser (JR) wrote:

JR> Please give the complete kernel version number: 2.2.19, 2.4.23, 2.6.0, etc.
JR> binfmt_elf has had bugs that were introduced/fixed/re-introduced/re-fixed
JR> within the 2.4 series, for example.

I've seen this effect on 2.2. kernels from 2.2.20 to 2.2.25 (not tested
earlier 2.2 kernels). Things work fine on all recent 2.4 and 2.6 kernels
including 2.4.24 and 2.6.1.

JR> Yes, there was an interpretation of ELF that p_filesz < p_memsz implied .bss
JR> only for the last PT_LOAD in the array of Elf32_Phdr.  Later this was changed
JR> so that .bss applied only on the PT_LOAD with the highest p_vaddr, regardless
JR> of position in Elf32_Phdr.  [In your example this accounts for the missing
JR> .bss from 0x000a6468 to 0x000b8818, because the p_paddr is 0x00001000 but
JR> the other p_vaddr is 0x000ba000 which is greater.] 

Where did this interpretation come from? The ELF standard (1.2) I'm looking at
from: http://x86.ddj.com/ftp/manuals/tools/elf.pdf says for PT_LOAD sections
(page 41 of that document).

PT_LOAD
The array element specifies a loadable segment, described by p_filesz
and p_memsz. The bytes from the file are mapped to the beginning of the memory
segment. If the segment's memory size (p_memsz) is larger than the file size
(p_filesz), the "extra'' bytes are defined to hold the value 0 and to follow the
segment's initialized area. The file size may not be larger than the memory
size. Loadable segment entries in the program header table appear in ascending
order, sorted on the p_vaddr member.

JR> The best interpretation
JR> is that p_filesz < p_memsz implies ".bss" [kernel-supplied, zeroed bytes
JR> and/or pages] separately for _each_ PT_LOAD.

Yes, that is how I read the standard, too - and how 2.4 and 2.6 do it. 
 
JR> [Note that binfmt_elf ignores Sections.  binfmt_elf pays attention only to
JR> PT_LOAD.  Aggregating from Elf32_Shdr into ELf32_Phdr is the job of /bin/ld.]

Of course. I only posted the section headers in case the program headers
didn't give enough information to some people.

-Udo.

--Signature=_Sat__10_Jan_2004_16_19_36_+0100_qq4Ug9pbBCDj.TYi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAABgJnhRzXSM7nSkRAj2ZAJ9mBwXZ42GprPVncscodCr6JgFE4wCdHvbq
P31zOpIVUZ2nqxMy2Vo0Uco=
=0SXK
-----END PGP SIGNATURE-----

--Signature=_Sat__10_Jan_2004_16_19_36_+0100_qq4Ug9pbBCDj.TYi--
