Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129042AbRBGDq5>; Tue, 6 Feb 2001 22:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129026AbRBGDqh>; Tue, 6 Feb 2001 22:46:37 -0500
Received: from d245.as5200.mesatop.com ([208.164.122.245]:1672 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S129027AbRBGDq1>; Tue, 6 Feb 2001 22:46:27 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
Date: Tue, 6 Feb 2001 20:49:11 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, reiser@namesys.com
Subject: [PATCH] Modify scripts/ver_linux to display reiserfsprogs version 
MIME-Version: 1.0
Message-Id: <01020620491101.00881@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch to the linux/scripts/ver_linux script which adds
the reiserfsprogs utils to the items checked.  If the reiserfsprogs
have not been installed, the modified script outputs nothing for
the Reiserfsprogs line (output looks the same as now).

The current version of reiserfsck does not have a "-V" or "--version"
option, but the version number is printed on the same line as "reiserfsprogs",
like this:

[root@localhost scripts]# reiserfsck --somethingbogus

<-------------reiserfsck, 2000------------->
reiserfsprogs 3.x.0b
reiserfsck: unrecognized option `--somethingbogus'
[the rest of the response snipped]

If reiserfsprogs reiserfsck is modified someday to respond to a
version option, then these two new lines in ver_linux can be simplified.

I'm sure that someone else can code something more elegantly, but
the following output was provided with the patched ver_linux script:

[root@localhost scripts]# ./ver_linux
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux localhost.localdomain 2.4.1-ac4 #1 Tue Feb 6 17:16:08 MST 2001 i686 unknown
Kernel modules         2.4.2
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.10.0.24
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.7
Mount                  2.10o
Net-tools              1.57
Console-tools          0.2.3
Reiserfsprogs          3.x.0b
Sh-utils               2.0
Modules Loaded     

Here is the patch, against 2.4.1-ac4.

Steven

--- linux/scripts/ver_linux.orig        Tue Feb  6 14:28:34 2001
+++ linux/scripts/ver_linux     Tue Feb  6 14:34:24 2001
@@ -29,6 +29,8 @@
 # while console-tools needs 'loadkeys -V'.
 loadkeys -V 2>&1 | awk \
 '(NR==1 && ($2 ~ /console-tools/)) {print "Console-tools         ", $3}'
+reiserfsck --bogusarg 2>&1 | grep reiserfsprogs | awk \
+'NR==1{print "Reiserfsprogs         ", $NF}'
 expr --v 2>&1 | awk 'NR==1{print "Sh-utils              ", $NF}'
 X=`cat /proc/modules | sed -e "s/ .*$//"`
 echo "Modules Loaded         "$X

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
