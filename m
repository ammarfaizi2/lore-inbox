Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbTH1BK3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 21:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbTH1BK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 21:10:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:37004 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262787AbTH1BK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 21:10:26 -0400
Date: Wed, 27 Aug 2003 18:05:27 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: kj <kernel-janitor-discuss@lists.sourceforge.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [announce] checkversion.pl script
Message-Id: <20030827180527.509ae6b4.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__27_Aug_2003_18:05:27_-0700_09c3e060"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Wed__27_Aug_2003_18:05:27_-0700_09c3e060
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I modified scripts/checkconfig.pl to make checkversion.pl.
It checks for cases of <linux/version.h> #included but not
needed (which makes for more rebuilds than required) and for
cases of <linux/version.h> not #included when macros from it
are used.  (Thanks for Randy Hron for some updates to it.)

You can get it from (for future updates; also attached)
  http://developer.osdl.org/rddunlap/scripts/checkversion.pl

Sample from linux-2.6.0-test3, fs/ only:

[rddunlap@dragon fs]$ find . -name \*\.c | xargs checkversion.pl | more
./afs/cmservice.c: 12 linux/version.h not needed.
./afs/kafstimod.c: 12 linux/version.h not needed.
./afs/kafsasyncd.c: 19 linux/version.h not needed.
./cifs/file.c: 26 linux/version.h not needed.
./cifs/transport.c: 26 linux/version.h not needed.
./cifs/cifsfs.c: 31 linux/version.h not needed.
./nls/nls_base.c: 11 linux/version.h not needed.
./jffs2/super.c: 17 linux/version.h not needed.
./jffs2/fs.c: 356: need linux/version.h
./jffs2/file.c: 435: need linux/version.h
./coda/coda_linux.c: 10 linux/version.h not needed.
./adfs/super.c: 10 linux/version.h not needed.
./adfs/dir_fplus.c: 10 linux/version.h not needed.
./adfs/inode.c: 10 linux/version.h not needed.
./adfs/map.c: 10 linux/version.h not needed.
./adfs/dir_f.c: 12 linux/version.h not needed.
./adfs/dir.c: 13 linux/version.h not needed.
./adfs/file.c: 22 linux/version.h not needed.
./udf/super.c: 49 linux/version.h not needed.
./befs/datastream.c: 14 linux/version.h not needed.
./lockd/svc.c: 24 linux/version.h not needed.
./devfs/base.c: 677 linux/version.h not needed.
./jffs/intrep.c: 67 linux/version.h not needed.

--
~Randy

--Multipart_Wed__27_Aug_2003_18:05:27_-0700_09c3e060
Content-Type: application/octet-stream;
 name="checkversion.pl"
Content-Disposition: attachment;
 filename="checkversion.pl"
Content-Transfer-Encoding: base64

IyEgL3Vzci9iaW4vcGVybAojCiMgY2hlY2t2ZXJzaW9uIGZpbmQgdXNlcyBvZiBMSU5VWF9WRVJT
SU9OX0NPREUsIEtFUk5FTF9WRVJTSU9OLCBvcgojIFVUU19SRUxFQVNFIHdpdGhvdXQgaW5jbHVk
aW5nIDxsaW51eC92ZXJzaW9uLmg+LCBvciBjYXNlcyBvZgojIGluY2x1ZGluZyA8bGludXgvdmVy
c2lvbi5oPiB0aGF0IGRvbid0IG5lZWQgaXQuCiMgQ29weXJpZ2h0IChDKSAyMDAzLCBSYW5keSBE
dW5sYXAgPHJkZHVubGFwQG9zZGwub3JnPgoKJHwgPSAxOwoKbXkgJGRlYnVnZ2luZyA9IDA7Cgpm
b3JlYWNoICRmaWxlIChAQVJHVikKewogICAgIyBPcGVuIHRoaXMgZmlsZS4KICAgIG9wZW4oRklM
RSwgJGZpbGUpIHx8IGRpZSAiQ2FuJ3Qgb3BlbiAkZmlsZTogJCFcbiI7CgogICAgIyBJbml0aWFs
aXplIHZhcmlhYmxlcy4KICAgIG15ICRmSW5Db21tZW50ICAgPSAwOwogICAgbXkgJGZJblN0cmlu
ZyAgICA9IDA7CiAgICBteSAkZlVzZVZlcnNpb24gICA9IDA7CiAgICBteSAkaUxpbnV4VmVyc2lv
biA9IDA7CgogICAgTElORTogd2hpbGUgKCA8RklMRT4gKQogICAgewoJIyBTdHJpcCBjb21tZW50
cy4KCSRmSW5Db21tZW50ICYmIChzK14uKj9cKi8rICtvID8gKCRmSW5Db21tZW50ID0gMCkgOiBu
ZXh0KTsKCW0rL1wqK28gJiYgKHMrL1wqLio/XCovKyArZ28sIChzKy9cKi4qJCsgK28gJiYgKCRm
SW5Db21tZW50ID0gMSkpKTsKCgkjIFBpY2sgdXAgZGVmaW5pdGlvbnMuCglpZiAoIG0vXlxzKiMv
byApIHsKCSAgICAkaUxpbnV4VmVyc2lvbiAgICAgID0gJC4gaWYgbS9eXHMqI1xzKmluY2x1ZGVc
cyoibGludXhcL3ZlcnNpb25cLmgiL287Cgl9CgoJIyBTdHJpcCBzdHJpbmdzLgoJJGZJblN0cmlu
ZyAmJiAocyteLio/IisgK28gPyAoJGZJblN0cmluZyA9IDApIDogbmV4dCk7CgltKyIrbyAmJiAo
cysiLio/IisgK2dvLCAocysiLiokKyArbyAmJiAoJGZJblN0cmluZyA9IDEpKSk7CgoJIyBQaWNr
IHVwIGRlZmluaXRpb25zLgoJaWYgKCBtL15ccyojL28gKSB7CgkgICAgJGlMaW51eFZlcnNpb24g
ICAgICA9ICQuIGlmIG0vXlxzKiNccyppbmNsdWRlXHMqPGxpbnV4XC92ZXJzaW9uXC5oPi9vOwoJ
fQoKCSMgTG9vayBmb3IgdXNlczogTElOVVhfVkVSU0lPTl9DT0RFLCBLRVJORUxfVkVSU0lPTiwg
VVRTX1JFTEVBU0UKCWlmICgoJF8gPX4gL0xJTlVYX1ZFUlNJT05fQ09ERS8pIHx8ICgkXyA9fiAv
XFdLRVJORUxfVkVSU0lPTi8pIHx8CgkJKCRfID1+IC9VVFNfUkVMRUFTRS8pKSB7CgkgICAgJGZV
c2VWZXJzaW9uID0gMTsKCSAgICBsYXN0IExJTkUgaWYgJGlMaW51eFZlcnNpb247Cgl9CiAgICB9
CgogICAgIyBSZXBvcnQgdXNlZCB2ZXJzaW9uIElEcyB3aXRob3V0IGluY2x1ZGU/CiAgICBpZiAo
JGZVc2VWZXJzaW9uICYmICEgJGlMaW51eFZlcnNpb24pIHsKCXByaW50ICIkZmlsZTogJC46IG5l
ZWQgbGludXgvdmVyc2lvbi5oXG4iOwogICAgfQoKICAgICMgUmVwb3J0IHN1cGVyZmx1b3VzIGlu
Y2x1ZGVzLgogICAgaWYgKCRpTGludXhWZXJzaW9uICYmICEgJGZVc2VWZXJzaW9uKSB7Cglwcmlu
dCAiJGZpbGU6ICRpTGludXhWZXJzaW9uIGxpbnV4L3ZlcnNpb24uaCBub3QgbmVlZGVkLlxuIjsK
ICAgIH0KCiAgICAjIGRlYnVnOiByZXBvcnQgT0sgcmVzdWx0czoKICAgIGlmICgkZGVidWdnaW5n
KSB7CiAgICAgICAgaWYgKCRpTGludXhWZXJzaW9uICYmICRmVXNlVmVyc2lvbikgewoJICAgIHBy
aW50ICIkZmlsZTogdmVyc2lvbiB1c2UgaXMgT0sgKCRpTGludXhWZXJzaW9uKVxuIjsKICAgICAg
ICB9CiAgICAgICAgaWYgKCEgJGlMaW51eFZlcnNpb24gJiYgISAkZlVzZVZlcnNpb24pIHsKCSAg
ICBwcmludCAiJGZpbGU6IHZlcnNpb24gdXNlIGlzIE9LIChub25lKVxuIjsKICAgICAgICB9CiAg
ICB9CgogICAgY2xvc2UoRklMRSk7Cn0K

--Multipart_Wed__27_Aug_2003_18:05:27_-0700_09c3e060--
