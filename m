Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276052AbRI1NuC>; Fri, 28 Sep 2001 09:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276056AbRI1Ntx>; Fri, 28 Sep 2001 09:49:53 -0400
Received: from mail.gmx.de ([213.165.64.20]:62513 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S276053AbRI1Ntk>;
	Fri, 28 Sep 2001 09:49:40 -0400
From: Martin =?iso-8859-1?q?R=F6der?= <m-roeder@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: ACPI processor throttling problem in 2.4.10
Date: Fri, 28 Sep 2001 15:50:01 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_D3LDPHLKQPGMJSJVIQ0N"
Message-Id: <20010928134942Z276053-760+18150@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_D3LDPHLKQPGMJSJVIQ0N
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

with the 2.4.10 kernel my processor doesn't enter the C2 power state any 
more. I found the reason to be the state promotion part of pr_power_idle() 
which actually does no state promotion if bm_control is 0.
As far as I understand, the bm_control flag should only disable the C3 state 
on machines where busmastering can't be controlled and not disable state 
changing completely.
The attached patch should correct this problem.

  Martin
--------------Boundary-00=_D3LDPHLKQPGMJSJVIQ0N
Content-Type: text/plain;
  charset="iso-8859-1";
  name="prpower.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="prpower.diff"

LS0tIGxpbnV4L2RyaXZlcnMvYWNwaS9vc3BtL3Byb2Nlc3Nvci9wcnBvd2VyLmMub3JpZwlTdW4g
U2VwIDIzIDE4OjQyOjMyIDIwMDEKKysrIGxpbnV4L2RyaXZlcnMvYWNwaS9vc3BtL3Byb2Nlc3Nv
ci9wcnBvd2VyLmMJRnJpIFNlcCAyOCAxMzowMTo0NSAyMDAxCkBAIC0yNzQsNyArMjc0LDcgQEAK
IAkJCSAqIGJ5IHRoaXMgc3RhdGUncyBwcm9tb3Rpb24gcG9saWN5LCBwcmV2ZW50cwogCQkJICog
cHJvbW90aW9ucyBmcm9tIG9jY3VyaW5nLgogCQkJICovCi0JCQlpZiAoYm1fY29udHJvbCAmJiAh
KHByb2Nlc3Nvci0+cG93ZXIuYm1fYWN0aXZpdHkgJgorCQkJaWYgKCFibV9jb250cm9sIHx8ICEo
cHJvY2Vzc29yLT5wb3dlci5ibV9hY3Rpdml0eSAmCiAJCQkJY19zdGF0ZS0+cHJvbW90aW9uLmJt
X3RocmVzaG9sZCkpIHsKIAkJCQluZXh0X3N0YXRlID0gY19zdGF0ZS0+cHJvbW90aW9uLnRhcmdl
dF9zdGF0ZTsKIAkJCX0K

--------------Boundary-00=_D3LDPHLKQPGMJSJVIQ0N--
