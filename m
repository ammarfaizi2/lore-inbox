Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbTEAHBB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 03:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbTEAHBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 03:01:01 -0400
Received: from [211.167.76.68] ([211.167.76.68]:26782 "HELO soulinfo")
	by vger.kernel.org with SMTP id S262263AbTEAHA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 03:00:58 -0400
Date: Thu, 1 May 2003 15:05:57 +0800
From: hugang <hugang@soulinfo.com>
To: hugang <hugang@soulinfo.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-Id: <20030501150557.6dc913f7.hugang@soulinfo.com>
In-Reply-To: <20030501133307.158c7e10.hugang@soulinfo.com>
References: <200304300446.24330.dphillips@sistina.com>
	<20030430135512.6519eb53.akpm@digeo.com>
	<20030501130318.459a4776.hugang@soulinfo.com>
	<20030430221129.11595e2e.akpm@digeo.com>
	<20030501133307.158c7e10.hugang@soulinfo.com>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= hugang <hugang@soulinfo.com>
 =?ISO-8859-1?Q?=B3=AD=CB=CD=A3=BA:?= akpm@digeo.com
 =?ISO-8859-1?Q?=B3=AD=CB=CD=A3=BA:?= linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Here is the table version of fls. Before version of it is wrong.
-------
static inline int fls_table_fls(unsigned n)
{
	switch (n) {
	case 0: return 0;
	case 1 ... 1: return 1;
	case 2 ... 3: return 2;
	case 4 ... 7: return 3;
	case 8 ... 15: return 4;
	case 16 ... 31: return 5;
	case 32 ... 63: return 6;
	case 64 ... 127: return 7;
	case 128 ... 255: return 8;
	case 256 ... 511: return 9;
	case 512 ... 1023: return 10;
	case 1024 ... 2047: return 11;
	case 2048 ... 4095: return 12;
	case 4096 ... 8191: return 13;
	case 8192 ... 16383: return 14;
	case 16384 ... 32767: return 15;
	case 32768 ... 65535: return 16;
	case 65536 ... 131071: return 17;
	case 131072 ... 262143: return 18;
	case 262144 ... 524287: return 19;
	case 524288 ... 1048575: return 20;
	case 1048576 ... 2097151: return 21;
	case 2097152 ... 4194303: return 22;
	case 4194304 ... 8388607: return 23;
	case 8388608 ... 16777215: return 24;
	case 16777216 ... 33554431: return 25;
	case 33554432 ... 67108863: return 26;
	case 67108864 ... 134217727: return 27;
	case 134217728 ... 268435455: return 28;
	case 268435456 ... 536870911: return 29;
	case 536870912 ... 1073741823: return 30;
	case 1073741824 ... 2147483647: return 31;
	default:return 32;
	}
}
--here is the test log-----
model name	: Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)
==== -march=i686 -O3 ====
4294967295 iterations of nil... checksum = 4294967295

real	0m15.548s
user	0m15.500s
sys	0m0.010s
4294967295 iterations of old... checksum = 4294967265

real	0m34.778s
user	0m34.690s
sys	0m0.020s
4294967295 iterations of new... checksum = 4294967265

real	0m56.330s
user	0m56.190s
sys	0m0.000s
4294967295 iterations of new2... checksum = 4294967265

real	0m40.755s
user	0m40.680s
sys	0m0.000s
4294967295 iterations of table... checksum = 4294967265

real	0m49.928s
user	0m49.770s
sys	0m0.050s
------------------
==== -march=i686 -O2 ====
4294967295 iterations of nil... checksum = 4294967295

real	0m28.350s
user	0m28.280s
sys	0m0.020s
4294967295 iterations of old... checksum = 4294967265

real	0m48.199s
user	0m48.100s
sys	0m0.000s
4294967295 iterations of new... checksum = 4294967265

real	0m50.986s
user	0m50.890s
sys	0m0.000s
4294967295 iterations of new2... checksum = 4294967265

real	1m5.356s
user	1m5.210s
sys	0m0.010s
4294967295 iterations of table... checksum = 4294967265

real	0m45.238s
user	0m45.150s
sys	0m0.000s
------------------
==== -O2 ====
4294967295 iterations of nil... checksum = 4294967295

real	0m33.503s
user	0m33.410s
sys	0m0.020s
4294967295 iterations of old... checksum = 4294967265

real	0m50.571s
user	0m50.450s
sys	0m0.020s
4294967295 iterations of new... checksum = 4294967265

real	0m53.324s
user	0m53.200s
sys	0m0.010s
4294967295 iterations of new2... checksum = 4294967265

real	0m56.360s
user	0m56.250s
sys	0m0.000s
4294967295 iterations of table... checksum = 4294967265

real	0m46.524s
user	0m46.440s
sys	0m0.000s
------------------
==== -O3 ====
4294967295 iterations of nil... checksum = 4294967295

real	0m5.421s
user	0m5.410s
sys	0m0.000s
4294967295 iterations of old... checksum = 4294967265

real	0m29.744s
user	0m29.670s
sys	0m0.010s
4294967295 iterations of new... checksum = 4294967265

real	0m53.160s
user	0m53.050s
sys	0m0.000s
4294967295 iterations of new2... checksum = 4294967265

real	0m31.464s
user	0m31.400s
sys	0m0.010s
4294967295 iterations of table... checksum = 4294967265

real	0m46.546s
user	0m46.440s
sys	0m0.000s
------------------

-- 
Hu Gang / Steve
Email        : huagng@soulinfo.com, steve@soulinfo.com
GPG FinePrint: 4099 3F1D AE01 1817 68F7  D499 A6C2 C418 86C8 610E
ICQ#         : 205800361
Registered Linux User : 204016
