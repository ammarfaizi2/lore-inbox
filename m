Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSLFPWn>; Fri, 6 Dec 2002 10:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbSLFPWn>; Fri, 6 Dec 2002 10:22:43 -0500
Received: from mail022.mail.bellsouth.net ([205.152.58.62]:3228 "EHLO
	imf22bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S263246AbSLFPWj>; Fri, 6 Dec 2002 10:22:39 -0500
Date: Fri, 6 Dec 2002 10:29:30 -0500 (EST)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix problem with ver_linux script and procps version
Message-ID: <Pine.LNX.4.43.0212061014550.10336-200000@morpheus>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1448587471-1039188570=:10336"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1448587471-1039188570=:10336
Content-Type: TEXT/PLAIN; charset=US-ASCII

With the current 2.5 Linux kernel, the ver_linux script prints bad version
info in the Procps line:

Procps                 100.


This is because
razor:/giant/linux/scripts# ps --version
Unknown HZ value! (85) Assume 100.
procps version 2.0.7
razor:/giant/linux/scripts# ps --version 2>&1 | awk 'NR==1{print "Procps         , $NF}'
Procps                 100.


This patch fixes this.

--- linux/scripts/ver_linux.orig        2002-12-06 10:18:05.000000000 -0500
+++ linux/scripts/ver_linux     2002-12-06 10:18:19.000000000 -0500
@@ -61,7 +61,7 @@
 ls -l /usr/lib/lib{g,stdc}++.so  2>/dev/null | awk -F. \
        '{print "Linux C++ Library      " $4"."$5"."$6}'

-ps --version 2>&1 | awk 'NR==1{print "Procps                ", $NF}'
+ps --version 2>&1 | grep version | awk 'NR==1{print "Procps
", $NF}'

 ifconfig --version 2>&1 | grep tools | awk \
 'NR==1{print "Net-tools             ", $NF}'



With the patch, ver_linux looks sane again.
Linux razor 2.5.50bk5 #1 Thu Dec 5 17:28:23 EST 2002 i686 Pentium II (Klamath) GenuineIntel GNU/Linux

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.19
e2fsprogs              1.30-WIP
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.2
Modules Loaded



--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461


--8323328-1448587471-1039188570=:10336
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ver_linux.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.43.0212061029300.10336@morpheus>
Content-Description: patch to fix procps in ver_linux
Content-Disposition: attachment; filename="ver_linux.patch"

LS0tIGxpbnV4L3NjcmlwdHMvdmVyX2xpbnV4Lm9yaWcJMjAwMi0xMi0wNiAx
MDoxODowNS4wMDAwMDAwMDAgLTA1MDANCisrKyBsaW51eC9zY3JpcHRzL3Zl
cl9saW51eAkyMDAyLTEyLTA2IDEwOjE4OjE5LjAwMDAwMDAwMCAtMDUwMA0K
QEAgLTYxLDcgKzYxLDcgQEANCiBscyAtbCAvdXNyL2xpYi9saWJ7ZyxzdGRj
fSsrLnNvICAyPi9kZXYvbnVsbCB8IGF3ayAtRi4gXA0KICAgICAgICAne3By
aW50ICJMaW51eCBDKysgTGlicmFyeSAgICAgICIgJDQiLiIkNSIuIiQ2fScN
CiANCi1wcyAtLXZlcnNpb24gMj4mMSB8IGF3ayAnTlI9PTF7cHJpbnQgIlBy
b2NwcyAgICAgICAgICAgICAgICAiLCAkTkZ9Jw0KK3BzIC0tdmVyc2lvbiAy
PiYxIHwgZ3JlcCB2ZXJzaW9uIHwgYXdrICdOUj09MXtwcmludCAiUHJvY3Bz
ICAgICAgICAgICAgICAgICIsICRORn0nDQogDQogaWZjb25maWcgLS12ZXJz
aW9uIDI+JjEgfCBncmVwIHRvb2xzIHwgYXdrIFwNCiAnTlI9PTF7cHJpbnQg
Ik5ldC10b29scyAgICAgICAgICAgICAiLCAkTkZ9Jw0K
--8323328-1448587471-1039188570=:10336--
