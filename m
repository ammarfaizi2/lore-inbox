Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264897AbTGGX6t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 19:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbTGGX6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 19:58:49 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:9311 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S264897AbTGGX6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 19:58:46 -0400
Subject: circular dependency in netfilter headers (ip_conntrack.h)
From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb@netcabo.pt>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-2J9LU/g1ag4oovWEJBjN"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 08 Jul 2003 01:12:53 +0100
Message-Id: <1057623173.1447.54.camel@darkstar.portugal>
Mime-Version: 1.0
X-OriginalArrivalTime: 08 Jul 2003 00:09:17.0047 (UTC) FILETIME=[2BDAE070:01C344E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2J9LU/g1ag4oovWEJBjN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,
with Red Hat Linux 7.3 and gcc 2.96-113=20
I have this error that prevents networking works=20
make[2]: Circular
/usr/src/linux-2.4.22-pre3/include/linux/netfilter_ipv4/ip_conntrack_helper=
.h <- /usr/src/linux-2.4.22-pre3/include/linux/netfilter_ipv4/ip_conntrack.=
h dependency dropped.

I found this patch in this email=20
http://www.ussg.iu.edu/hypermail/linux/kernel/0211.3/1059.html
thats works for me.=20

This circular dependency problem is in almost kernel version, pr=E9
version and RCs since 2.4.20 at least.
please CC me
thanks
--=20
S=E9rgioMB
email: sergiomb@netcabo.pt

Who gives me one shell, give me everything.

--=-2J9LU/g1ag4oovWEJBjN
Content-Disposition: attachment; filename=netfilter.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=netfilter.diff; charset=ISO-8859-1

--- 2.4.20/include/linux/netfilter_ipv4/ip_conntrack.h.orig	Sat May 31 23:2=
2:01 2003
+++ 2.4.20+/include/linux/netfilter_ipv4/ip_conntrack.h	Sun Jun  1 00:11:03=
 2003
@@ -156,7 +156,8 @@
 	union ip_conntrack_expect_help help;
 };
=20
-#include <linux/netfilter_ipv4/ip_conntrack_helper.h>
+struct ip_conntrack_helper;
+
 struct ip_conntrack
 {
 	/* Usage count in here is 1 for hash table/destruct timer, 1 per skb,

--=-2J9LU/g1ag4oovWEJBjN--

