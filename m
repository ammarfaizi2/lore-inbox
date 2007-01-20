Return-Path: <linux-kernel-owner+w=401wt.eu-S965382AbXATUVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965382AbXATUVe (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 15:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965381AbXATUVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 15:21:34 -0500
Received: from [139.30.44.16] ([139.30.44.16]:26317 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965377AbXATUVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 15:21:33 -0500
Date: Sat, 20 Jan 2007 21:21:32 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: Abysmal disk performance, how to debug?
In-Reply-To: <200701202216.16637.ismail@pardus.org.tr>
Message-ID: <Pine.LNX.4.63.0701202118170.23674@gockel.physik3.uni-rostock.de>
References: <200701201920.54620.ismail@pardus.org.tr> <200701201952.54714.ismail@pardus.org.tr>
 <Pine.LNX.4.63.0701202105210.23674@gockel.physik3.uni-rostock.de>
 <200701202216.16637.ismail@pardus.org.tr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="512430124-2011241176-1169324492=:23674"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--512430124-2011241176-1169324492=:23674
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 20 Jan 2007, Ismail D=C3=B6nmez wrote:

> 20 Oca 2007 Cts 22:10 tarihinde, Tim Schmielau =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:=20
> >
> > Note that these dd "benchmarks" are completely bogus, because the data=
=3D20
> > doesn't actually get written to disk in that time. For some enlightenin=
g=3D20
> > data, try
> >
> >   time dd if=3D3D/dev/zero of=3D3D/tmp/1GB bs=3D3D1M count=3D3D1024; ti=
me sync
                                                                 ^^^^
> >
> > The dd returns as soon as all data could be buffered in RAM. Only sync=
=3D20
> > will show how long it takes to actually write out the data to disk.
> > also explains why you see better results is writeout starts earlier.
>=20
> Still not that bad:
>=20
> [~]> time dd if=3D/dev/zero of=3D/tmp/1GB bs=3D1M count=3D1024;sync
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1,1 GB) copied, 53,3194 s, 20,1 MB/s
>=20
> real    0m53.517s
> user    0m0.003s
> sys     0m3.193s
>=20

That's not the point, you still measured the same as before (but you might=
=20
have noticed that, after printing the results, the shell prompt took some=
=20
time to appear). I appended "time sync" to the command to show that=20
(depending on the amount of available memory) actually most of the time=20
is spent in the "sync", not the "dd".

Tim
--512430124-2011241176-1169324492=:23674--
