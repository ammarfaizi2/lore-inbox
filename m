Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267335AbTA2VQ1>; Wed, 29 Jan 2003 16:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263991AbTA2VQ1>; Wed, 29 Jan 2003 16:16:27 -0500
Received: from [212.156.4.132] ([212.156.4.132]:15855 "EHLO fep02.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S267335AbTA2VQ0>;
	Wed, 29 Jan 2003 16:16:26 -0500
Date: Wed, 29 Jan 2003 23:25:16 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: Mauricio Martinez <mauricio@coe.neu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS in read_cd... what to do?
Message-ID: <20030129212516.GA2489@ttnet.net.tr>
Mail-Followup-To: Mauricio Martinez <mauricio@coe.neu.edu>,
	linux-kernel@vger.kernel.org
References: <Pine.GSO.4.33.0301270937370.18209-100000@Amps.coe.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0301270937370.18209-100000@Amps.coe.neu.edu>
User-Agent: Mutt/1.4i
X-PGP-Fingerprint: 15 C0 AA 31 59 F9 DE 4F 7D A6 C7 D8 A0 D5 67 73
X-PGP-Key-ID: 0x5C447959
X-PGP-Key-Size: 2048 bits
X-Editor: GNU Emacs 21.2.1
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I reported twice (Jan 15 the last time) to this list a kernel oops when
> reading a CD in a SONY CDU-31A unit with kernels 2.4.18 - 2.4.20 (and
> probably all the 2.4 series), which works fine on 2.2.x (and even
> 1.2.x!!), maybe the maintainer of this part os the code is offline... Are
> there any alternatives to fix this problem? Thank you.

There is something wrong here. This should help.

--- linux-2.4.20/drivers/cdrom/cdu31a.c.orig    Fri Nov 29 01:53:12 2002
+++ linux-2.4.20/drivers/cdrom/cdu31a.c Wed Jan 29 23:12:39 2003
@@ -1384,9 +1384,9 @@
                               readahead_buffer + (2048 -
                                                   readahead_dataleft),
                               readahead_dataleft);
-                       readahead_dataleft = 0;
                        bytesleft -= readahead_dataleft;
                        offset += readahead_dataleft;
+                       readahead_dataleft = 0;
                } else {
                        /* The readahead will fill the whole buffer, get the data
                           and return. */


