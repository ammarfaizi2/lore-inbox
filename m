Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbQLJMhG>; Sun, 10 Dec 2000 07:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129874AbQLJMg5>; Sun, 10 Dec 2000 07:36:57 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:61700 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129830AbQLJMgo>;
	Sun, 10 Dec 2000 07:36:44 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Checking for incorrect MODULE_PARM
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Dec 2000 23:06:10 +1100
Message-ID: <18434.976449970@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

modutils 2.3.22 does more rigorous checking of MODULE_PARM entries and
has already found several cases where MODULE_PARM(x) is used but the
corresponding variable 'x' is not defined.  These are module coding
bugs that were previously hidden.  Run this script to do a quick check
of all your modules against modutils 2.3.22.  Run as any user, does not
have not be root.

for i in $(/sbin/modprobe -l)
do
	(echo -e "\n" $i ; /sbin/modinfo -p $i) > /var/tmp/modinfo
	grep warning /var/tmp/modinfo > /dev/null && cat /var/tmp/modinfo
done

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
