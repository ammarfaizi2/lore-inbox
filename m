Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261308AbSJPSyo>; Wed, 16 Oct 2002 14:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261299AbSJPSyo>; Wed, 16 Oct 2002 14:54:44 -0400
Received: from ns0.cobite.com ([208.222.80.10]:4877 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S261308AbSJPSyF>;
	Wed, 16 Oct 2002 14:54:05 -0400
Date: Wed, 16 Oct 2002 14:59:30 -0400 (EDT)
From: David Mansfield <david@cobite.com>
X-X-Sender: david@admin
To: Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] (quickfix) allow md devices to be used in 2.5.43
Message-ID: <Pine.LNX.4.44.0210161451090.30777-200000@admin>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-556791216-928028080-1034794770=:30777"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---556791216-928028080-1034794770=:30777
Content-Type: TEXT/PLAIN; charset=US-ASCII


Al, list,

In order to accessing my md devices in 2.5.43, i needed the attached
patch to fs/block_dev.c.  WARNING: it's probably very broken, because I
don't know what I'm doing.  I essentially reverted most of the changes to
the do_open function, allowing the open() method of a device without an
attached gendisk to be called.

In the md scheme of things, the gendisk is created in the md_run stage, 
which is only possible via ioctl after a successful open of the block 
device.

However, something else is broken with the change to md.c, which detects
whether the disk is idle by checking the number of sectors read/written to
the disk.

I'm going to take a look at that now.

David

-- 
/==============================\
| David Mansfield              |
| david@cobite.com             |
\==============================/

---556791216-928028080-1034794770=:30777
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="00-bd-open.patch"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename="00-bd-open.patch"

LS0tIGxpbnV4LTIuNS40My9mcy9ibG9ja19kZXYuYwlNb24gU2VwIDE2IDA3
OjI1OjU5IDIwMDINCisrKyBsaW51eC1jdXJyZW50aXNoLXZhbmlsbGEvZnMv
YmxvY2tfZGV2LmMJTW9uIFNlcCAxNiAxMDo1NDo1OSAyMDAyDQpAQCAtNjEy
LDEyICs2MTIsMTIgQEANCiAJCWlmIChvd25lcikNCiAJCQlfX01PRF9ERUNf
VVNFX0NPVU5UKG93bmVyKTsNCiAJfQ0KKw0KIAlkaXNrID0gZ2V0X2dlbmRp
c2soYmRldi0+YmRfZGV2LCAmcGFydCk7DQotCWlmICghZGlzaykNCi0JCWdv
dG8gb3V0MTsNCisNCiAJaWYgKCFiZGV2LT5iZF9jb250YWlucykgew0KIAkJ
YmRldi0+YmRfY29udGFpbnMgPSBiZGV2Ow0KLQkJaWYgKHBhcnQpIHsNCisJ
CWlmIChkaXNrICYmIHBhcnQpIHsNCiAJCQlzdHJ1Y3QgYmxvY2tfZGV2aWNl
ICp3aG9sZTsNCiAJCQl3aG9sZSA9IGJkZ2V0KE1LREVWKGRpc2stPm1ham9y
LCBkaXNrLT5maXJzdF9taW5vcikpOw0KIAkJCXJldCA9IC1FTk9NRU07DQpA
QCAtNjMwLDggKzYzMCw2IEBADQogCQl9DQogCX0NCiAJaWYgKGJkZXYtPmJk
X2NvbnRhaW5zID09IGJkZXYpIHsNCi0JCWlmICghYmRldi0+YmRfb3BlbmVy
cykNCi0JCQliZGV2LT5iZF9kaXNrID0gZGlzazsNCiAJCWlmICghYmRldi0+
YmRfcXVldWUpIHsNCiAJCQlzdHJ1Y3QgYmxrX2Rldl9zdHJ1Y3QgKnAgPSBi
bGtfZGV2ICsgbWFqb3IoZGV2KTsNCiAJCQliZGV2LT5iZF9xdWV1ZSA9ICZw
LT5yZXF1ZXN0X3F1ZXVlOw0KQEAgLTY0NSw4ICs2NDMsMTIgQEANCiAJCX0N
CiAJCWlmICghYmRldi0+YmRfb3BlbmVycykgew0KIAkJCXN0cnVjdCBiYWNr
aW5nX2Rldl9pbmZvICpiZGk7DQorCQkJc2VjdG9yX3Qgc2VjdCA9IDA7DQor
DQogCQkJYmRldi0+YmRfb2Zmc2V0ID0gMDsNCi0JCQliZF9zZXRfc2l6ZShi
ZGV2LCAobG9mZl90KWdldF9jYXBhY2l0eShkaXNrKSA8PCA5KTsNCisJCQlp
ZiAoZGlzaykNCisJCQkJc2VjdCA9IGdldF9jYXBhY2l0eShkaXNrKTsNCisJ
CQliZF9zZXRfc2l6ZShiZGV2LCAobG9mZl90KXNlY3QgPDwgOSk7DQogCQkJ
YmRpID0gYmxrX2dldF9iYWNraW5nX2Rldl9pbmZvKGJkZXYpOw0KIAkJCWlm
IChiZGkgPT0gTlVMTCkNCiAJCQkJYmRpID0gJmRlZmF1bHRfYmFja2luZ19k
ZXZfaW5mbzsNCg==
---556791216-928028080-1034794770=:30777--
