Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVATOYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVATOYS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 09:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVATOYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 09:24:18 -0500
Received: from ns1.coraid.com ([65.14.39.133]:41057 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S262088AbVATOYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 09:24:10 -0500
To: 7eggert@gmx.de
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH] aoe: add documentation for udev users
References: <fa.gl94rva.1tkib28@ifi.uio.no>
	<E1CrSfr-0001l2-Et@be1.7eggert.dyndns.org>
From: Ed L Cashin <ecashin@coraid.com>
Date: Thu, 20 Jan 2005 09:19:17 -0500
In-Reply-To: <E1CrSfr-0001l2-Et@be1.7eggert.dyndns.org> (Bodo Eggert's
 message of "Thu, 20 Jan 2005 04:07:54 +0100")
Message-ID: <877jm8kwt6.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

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


--=-=-=
Content-Disposition: inline; filename=patch-eggbert

diff -uprN a/Documentation/aoe/udev-install.sh b/Documentation/aoe/udev-install.sh
--- a/Documentation/aoe/udev-install.sh	2005-01-20 09:14:58.000000000 -0500
+++ b/Documentation/aoe/udev-install.sh	2005-01-20 09:13:38.000000000 -0500
@@ -8,11 +8,15 @@ me="`basename $0`"
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

--=-=-=



-- 
  Ed L Cashin <ecashin@coraid.com>

--=-=-=--

