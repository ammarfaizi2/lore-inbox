Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272586AbRHaCDd>; Thu, 30 Aug 2001 22:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272585AbRHaCDX>; Thu, 30 Aug 2001 22:03:23 -0400
Received: from mail100.mail.bellsouth.net ([205.152.58.40]:37113 "EHLO
	imf00bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S272586AbRHaCDO>; Thu, 30 Aug 2001 22:03:14 -0400
Message-ID: <3B8EF06D.24BAB4AF@bellsouth.net>
Date: Thu, 30 Aug 2001 22:03:25 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [Patch]: incorrect e2fsprog data from ver_linux script
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan/Linus,
Ted suggested I pass this onto your for 2.2 and 2.4
Please apply small patch to both releases.
Thanks,
Albert


-------- Original Message --------
Subject: incorrect e2fsprog data from ver_linux script
Date: Thu, 30 Aug 2001 10:08:27 -0400
From: Albert Cranford <ac9410@bellsouth.net>
To: tytso@valinux.com, tytso@mit.edu

Hello Ted,
I'm not sure when incorrect e2fsprog info started popping
up from the linux/scripts/ver_linux script, but what do
you think about submitting this patch to Linus?
Later,
Albert


---BEFORE------------------------------
home1:~ /usr/src/linux/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux home1 2.4.10-pre2 #1 Thu Aug 30 00:17:13 EDT 2001 i686 AuthenticAMD

Gnu C                  3.0.1
Gnu make               3.79
binutils               2.11.2
util-linux             2.11h
mount                  2.11h
modutils               2.4.8
e2fsprogs              tune2fs
PPP                    2.4.0
----AFTER-----------------------------
home1:~ /usr/local/bin/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux home1 2.4.10-pre2 #1 Thu Aug 30 00:17:13 EDT 2001 i686 AuthenticAMD

Gnu C                  3.0.1
Gnu make               3.79
binutils               2.11.2
util-linux             2.11h
modutils               2.4.8
e2fsprogs              1.23
PPP                    2.4.0
----BEFORE-----------------------------
home1:/usr/src/e2fsprogs-1.23/misc# tune2fs 2>&1 | grep tune2fs | sed 's/,//' |
awk 'NR==1 {print "e2fsprogs             ", $2}'
e2fsprogs              tune2fs
----AFTER------------------------------
home1:/usr/src/e2fsprogs-1.23/misc# tune2fs 2>&1 | grep tune2fs | sed 's/,//' |
awk 'NR==2 {print "e2fsprogs             ", $2}'
e2fsprogs              1.23
----PATCH-----------------------------
--- linux/scripts/ver_linux.orig        Thu Aug 30 09:56:39 2001
+++ linux/scripts/ver_linux     Thu Aug 30 09:56:49 2001
@@ -27,7 +27,7 @@
 insmod -V  2>&1 | awk 'NR==1 {print "modutils              ",$NF}'
 
 tune2fs 2>&1 | grep tune2fs | sed 's/,//' |  awk \
-'NR==1 {print "e2fsprogs             ", $2}'
+'NR==2 {print "e2fsprogs             ", $2}'
 
 reiserfsck 2>&1 | grep reiserfsprogs | awk \
 'NR==1{print "reiserfsprogs         ", $NF}'
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net

