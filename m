Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284728AbRLPRXA>; Sun, 16 Dec 2001 12:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284729AbRLPRWv>; Sun, 16 Dec 2001 12:22:51 -0500
Received: from mx2.elte.hu ([157.181.151.9]:61828 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S284728AbRLPRWn>;
	Sun, 16 Dec 2001 12:22:43 -0500
Date: Sun, 16 Dec 2001 20:20:13 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][OOPS] loop block device induced on 2.5.1-pre11+HIGHMEM
In-Reply-To: <Pine.LNX.4.33.0112161017550.4185-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.33.0112162010140.12126-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-758653423-1008530413=:12126"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-758653423-1008530413=:12126
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Sun, 16 Dec 2001, Zwane Mwaikambo wrote:

> 	Due to some mixture of late night hacking and weak coffee i
> managed to build a HIGHMEM (4G) kernel on a P2-192M box. I then tried
> to create some loopback filesystems (ext2 on ext3) and mount them.
> mounting caused the oops attached. I noticed the highmem option was
> enabled when i saw create_bounce. It seems like create_bounce is
> sending mempool_alloc a NULL pointer in the form of the pool argument
> [...]

it looks like the BLK_BOUNCE_HIGH definition is wrong, it's off by 1.
Please try the attached patch, does it fix the oops? (the patch also fixes
BLK_BOUNCE_ANY - which is off by one as well.) In both cases, we created a
bounce page for the very last page in the system.

	Ingo

--8323328-758653423-1008530413=:12126
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="bouncefix-2.5.1-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0112162020130.12126@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="bouncefix-2.5.1-A0"

LS0tIGxpbnV4L2luY2x1ZGUvbGludXgvYmxrZGV2Lmgub3JpZwlTdW4gRGVj
IDE2IDE4OjA1OjI0IDIwMDENCisrKyBsaW51eC9pbmNsdWRlL2xpbnV4L2Js
a2Rldi5oCVN1biBEZWMgMTYgMTg6MDk6MzkgMjAwMQ0KQEAgLTIwMCw4ICsy
MDAsOCBAQA0KIA0KIGV4dGVybiB1bnNpZ25lZCBsb25nIGJsa19tYXhfbG93
X3BmbiwgYmxrX21heF9wZm47DQogDQotI2RlZmluZSBCTEtfQk9VTkNFX0hJ
R0gJKGJsa19tYXhfbG93X3BmbiA8PCBQQUdFX1NISUZUKQ0KLSNkZWZpbmUg
QkxLX0JPVU5DRV9BTlkJKGJsa19tYXhfcGZuIDw8IFBBR0VfU0hJRlQpDQor
I2RlZmluZSBCTEtfQk9VTkNFX0hJR0gJKChibGtfbWF4X2xvd19wZm4gKyAx
KSA8PCBQQUdFX1NISUZUKQ0KKyNkZWZpbmUgQkxLX0JPVU5DRV9BTlkJKChi
bGtfbWF4X3BmbiArIDEpIDw8IFBBR0VfU0hJRlQpDQogDQogI2lmZGVmIENP
TkZJR19ISUdITUVNDQogDQo=
--8323328-758653423-1008530413=:12126--
