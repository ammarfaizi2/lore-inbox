Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132196AbRCVVo7>; Thu, 22 Mar 2001 16:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132201AbRCVVou>; Thu, 22 Mar 2001 16:44:50 -0500
Received: from rm05-24-167-185-21.ce.mediaone.net ([24.167.185.21]:28288 "EHLO
	calvin.localdomain") by vger.kernel.org with ESMTP
	id <S132196AbRCVVod>; Thu, 22 Mar 2001 16:44:33 -0500
Date: Thu, 22 Mar 2001 15:43:45 -0600
From: Tim Walberg <tewalberg@mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Bug report
Message-ID: <20010322154345.A18622@mediaone.net>
Reply-To: Tim Walberg <tewalberg@mediaone.net>
Mail-Followup-To: Tim Walberg <tewalberg@mediaone.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.31.0103221257390.10736-100000@cmgm.stanford.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.31.0103221257390.10736-100000@cmgm.stanford.edu> from Craig Cummings on 03/22/2001 14:58
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

"User does not understand how *NIX systems utilize memory" is
not the same thing as "bug". What you are seeing is the kernel
using memory for file system cache.

On 03/22/2001 12:58 -0800, Craig Cummings wrote:
>>	Hi there,
>>=09
>>	I think this qualifies as a bug but let me know if this could be a
>>	configuration or hardware issue.
>>=09
>>	I've been having problems with memory leaks when I run programs on
>>	large--up to 250MB text files.  (I know this is huge, but that's the 3
>>	billion base human genome for you.)  At first I though it was a Perl
>>	problem but I later found that a completely unrelated C program also
>>	caused memory leaks.  I recently upgraded to the 2.4 kernel, hoping to
>>	solve these problems (see below).  However, the memory leaks are still
>>	happening and this time I know the problem is at a deeper level than my
>>	programs.  Some standard UNIX programs are leaking a lot of memory.  I
>>	would appreciate some advice and ultimately, a fix.  Unfortunately, My
>>	programming skills are not sufficient for tinkering with the kernel
>>	source.  Thank you, in advance for your help.  Details follow.
>>=09
>>	Regards,
>>=09
>>	Craig Cummings
>>=09
>>=09
>>	Here are the specs for my system:
>>		Dell Precision XPSt700, Pentium III, 512 MB RAM
>>		I've recently upgraded from Red Hat 6.2 with the 2.2.14 kernel to
>>		Red Hat 7, then built the 2.4.2 kernel on my own.
>>=09
>>	Here's what happens with grep:
>>=09
>>	Output of free, freshly booted system:
>>=09
>>	             total       used       free     shared    buffers     cached
>>	Mem:        513616      47516     466100          0       2476      27048
>>	-/+ buffers/cache:      17992     495624
>>	Swap:       128480          0     128480
>>=09
>>	Output of free after grep 'NT_005289' Data/hs_chr12.fa:
>>=09
>>	             total       used       free     shared    buffers     cached
>>	Mem:        513616     183548     330068          0       2624     159616
>>	-/+ buffers/cache:      21308     492308
>>	Swap:       128480          0     128480
>>=09
>>	Output of grep 'NT_005289' Data/hs_chr2.fa:
>>=09
>>	>gi|12728771|ref|NT_005289.2|Hs2_5446 Homo sapiens chromosome 2 working =
draft sequence segment
>>=09
>>	Output of free after this grep:
>>=09
>>	             total       used       free     shared    buffers     cached
>>	Mem:        513616     424272      89344          0       2860     394232
>>	-/+ buffers/cache:      27180     486436
>>	Swap:       128480          0     128480
>>=09
>>	Output of grep 'NT_005289' Data/hs_chr2.fa:
>>=09
>>	>gi|12728771|ref|NT_005289.2|Hs2_5446 Homo sapiens chromosome 2 working =
draft sequence segment
>>=09
>>	Output of free after this grep:
>>=09
>>	             total       used       free     shared    buffers     cached
>>	Mem:        513616     424272      89344          0       2860     394232
>>	-/+ buffers/cache:      27180     486436
>>	Swap:       128480          0     128480
>>=09
>>	File sizes of the two files grep'ed:
>>=09
>>	-rw-rw-r--    1 cummings genomics 135744469 Mar 12 22:09 Data/hs_chr12.fa
>>	-rw-rw-r--    1 cummings genomics 240244039 Mar 12 22:24 Data/hs_chr2.fa
>>=09
>>	Note that these file sizes are equivalent to the amount of memory leaked
>>	when grep is called on that file.
>>=09
>>	When I grep the same file a second time, very little additional memory is
>>	leaked.
>>=09
>>=09
>>	This same phenomenon occurs when I run a different UNIX program, e.g. wc:
>>=09
>>	Output of wc -l Data/hs_chr3.fa:
>>=09
>>	2915465 Data/hs_chr3.fa
>>=09
>>	Output of free:
>>=09
>>	             total       used       free     shared    buffers     cached
>>	Mem:        513616     511520       2096          0       1252     481020
>>	-/+ buffers/cache:      29248     484368
>>	Swap:       128480          0     128480
>>=09
>>	Interestingly, after running wc a second time on the same file, it goes
>>	very fast and very little additional memory is leaked:
>>=09
>>	             total       used       free     shared    buffers     cached
>>	Mem:        513616     510732       2884          0       1204     480948
>>	-/+ buffers/cache:      28580     485036
>>	Swap:       128480         40     128440
>>=09
>>=09
>>	-------------------------------------------
>>	Craig Cummings, Ph.D.
>>=09
>>	Relman Laboratory
>>	Stanford University School of Medicine
>>	Department of Microbiology and Immunology
>>=09
>>	e-mail: cummings@cmgm.stanford.edu
>>	phone:  650-498-5998
>>	fax:    650-852-3291
>>=09
>>	-
>>	To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>>	the body of a message to majordomo@vger.kernel.org
>>	More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>	Please read the FAQ at  http://www.tux.org/lkml/
End of included message



--=20
+--------------------------+------------------------------+
| Tim Walberg              | tewalberg@mediaone.net       |
| 828 Marshall Ct.         | www.concentric.net/~twalberg |
| Palatine, IL 60074       |                              |
+--------------------------+------------------------------+

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBOrpyDsPlnI9tqyVmEQLRtQCfVYZ7E773WmqDv5t/e+DlDBwBivoAmgPp
wEmZUwBXNWhnmreNOkY5cprp
=/cm/
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
