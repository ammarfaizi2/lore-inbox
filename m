Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276522AbRI2PXL>; Sat, 29 Sep 2001 11:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276523AbRI2PXB>; Sat, 29 Sep 2001 11:23:01 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:8481 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S276522AbRI2PWw>; Sat, 29 Sep 2001 11:22:52 -0400
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: RFC (patch below) Re: ide drive problem?
Date: Sat, 29 Sep 2001 17:21:16 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Hahn <hahn@physics.mcmaster.ca>
In-Reply-To: <E15myH3-00076i-00@the-village.bc.nu>
In-Reply-To: <E15myH3-00076i-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_GZJFKS4YND8PISU5IZVZ"
Message-Id: <E15nLxO-0001yx-00@mrvdom00.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_GZJFKS4YND8PISU5IZVZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi List, Hi Andre,

as Mark Hahn made a FAQ entry for the =20

hde: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=3D0x84 { DriveStatusError BadCRC }

message, I think we should point all users to this FAQ. I saw this messag=
e
and questions about it very often in this list, so we should help the use=
rs=20
to find a fast solution. You know, only a few people read a manual, even =
in=20
error case.

Now the output looks like:

hde: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=3D0x84 { DriveStatusError BadCRC }

For further Informations please check: http://www.tux.org/lkml/#s13-3



This patch applies correct for 2.4.9ac14 and 2.4.10

diff -r -u linux/drivers/ide/ide.c linux-new/drivers/ide/ide.c
--- linux/drivers/ide/ide.c     Fri Sep 28 17:36:54 2001
+++ linux-new/drivers/ide/ide.c Sat Sep 29 17:03:36 2001
@@ -935,6 +935,9 @@
                                        printk(", sector=3D%ld", HWGROUP(=
drive)->rq->sector);
                        }
                }
+               if ((stat & READY_STAT) && (stat & SEEK_STAT) && (stat & =
ERR_STAT)
+                && (err & ABRT_ERR) && (err & ICRC_ERR))
+                       printk("\nFor further Informations please check: =
http://www.tux.org/lkml/#s13-3\n");
 #endif /* FANCY_STATUS_DUMPS */
                printk("\n");
        }


greetings

Christian Borntr=E4ger
--------------Boundary-00=_GZJFKS4YND8PISU5IZVZ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="m.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="m.patch"

ZGlmZiAtciAtdSBsaW51eC9kcml2ZXJzL2lkZS9pZGUuYyBsaW51eC1uZXcvZHJpdmVycy9pZGUv
aWRlLmMKLS0tIGxpbnV4L2RyaXZlcnMvaWRlL2lkZS5jCUZyaSBTZXAgMjggMTc6MzY6NTQgMjAw
MQorKysgbGludXgtbmV3L2RyaXZlcnMvaWRlL2lkZS5jCVNhdCBTZXAgMjkgMTc6MDM6MzYgMjAw
MQpAQCAtOTM1LDYgKzkzNSw5IEBACiAJCQkJCXByaW50aygiLCBzZWN0b3I9JWxkIiwgSFdHUk9V
UChkcml2ZSktPnJxLT5zZWN0b3IpOwogCQkJfQogCQl9CisJCWlmICgoc3RhdCAmIFJFQURZX1NU
QVQpICYmIChzdGF0ICYgU0VFS19TVEFUKSAmJiAoc3RhdCAmIEVSUl9TVEFUKQorCQkgJiYgKGVy
ciAmIEFCUlRfRVJSKSAmJiAoZXJyICYgSUNSQ19FUlIpKQorCQkgICAgICAgIHByaW50aygiXG5G
b3IgZnVydGhlciBJbmZvcm1hdGlvbnMgcGxlYXNlIGNoZWNrOiBodHRwOi8vd3d3LnR1eC5vcmcv
bGttbC8jczEzLTNcbiIpOwogI2VuZGlmCS8qIEZBTkNZX1NUQVRVU19EVU1QUyAqLwogCQlwcmlu
dGsoIlxuIik7CiAJfQo=

--------------Boundary-00=_GZJFKS4YND8PISU5IZVZ--
