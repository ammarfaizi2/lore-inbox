Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVCJDYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVCJDYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 22:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbVCJBJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:09:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:50591 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262620AbVCJAm2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:28 -0500
Cc: ecashin@coraid.com
Subject: [PATCH] aoe: update documentation for udev users
In-Reply-To: <1110413963113@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:19:23 -0800
Message-Id: <1110413963858@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2037, 2005/03/09 10:21:15-08:00, ecashin@coraid.com

[PATCH] aoe: update documentation for udev users

Bodo Eggert <7eggert@gmx.de> writes:

> Ed L Cashin <ecashin@coraid.com> wrote:
>
>> +if=A0test=A0-z=A0"$conf";=A0then
>> +=A0=A0=A0=A0=A0=A0=A0=A0conf=3D"`find=A0/etc=A0-type=A0f=A0-name=A0udev=
.conf=A02>=A0/dev/null`"
>> +fi
>> +if=A0test=A0-z=A0"$conf"=A0||=A0test=A0!=A0-r=A0$conf;=A0then
>> +=A0=A0=A0=A0=A0=A0=A0=A0echo=A0"$me=A0Error:=A0could=A0not=A0find=A0rea=
dable=A0udev.conf=A0in=A0/etc"=A01>&2
>> +=A0=A0=A0=A0=A0=A0=A0=A0exit=A01
>> +fi
>
> This will fail and print
> ---
> bash: test: etc/udev.conf: binary operator expected
> ---
> if there is more than one udev.conf.
>
> Fix: Always put quotes around variables.

Thanks.  With the changes below, it still will complain if it finds
more than one udev.conf, but only if /etc/udev/udev.conf doesn't
exist.

Quote all shell variables, and use /etc/udev/udev.conf if available.

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 Documentation/aoe/udev-install.sh |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)


diff -Nru a/Documentation/aoe/udev-install.sh b/Documentation/aoe/udev-install.sh
--- a/Documentation/aoe/udev-install.sh	2005-03-09 16:16:00 -08:00
+++ b/Documentation/aoe/udev-install.sh	2005-03-09 16:16:00 -08:00
@@ -8,11 +8,15 @@
 # (or environment can specify where to find udev.conf)
 #
 if test -z "$conf"; then
-	conf="`find /etc -type f -name udev.conf 2> /dev/null`"
-fi
-if test -z "$conf" || test ! -r $conf; then
-	echo "$me Error: could not find readable udev.conf in /etc" 1>&2
-	exit 1
+	if test -r /etc/udev/udev.conf; then
+		conf=/etc/udev/udev.conf
+	else
+		conf="`find /etc -type f -name udev.conf 2> /dev/null`"
+		if test -z "$conf" || test ! -r "$conf"; then
+			echo "$me Error: no udev.conf found" 1>&2
+			exit 1
+		fi
+	fi
 fi
 
 # find the directory where udev rules are stored, often

