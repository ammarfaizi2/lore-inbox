Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbTDYOPY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 10:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbTDYOPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 10:15:24 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:55727 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S263204AbTDYOPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 10:15:21 -0400
Subject: Re: Linux 2.4.21-rc1
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Andreas Metzler <lkml-2003-03@downhill.at.eu.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b8bfuk$g1$1@main.gmane.org>
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
	 <b8bfuk$g1$1@main.gmane.org>
Content-Type: multipart/mixed; boundary="=-Hic5hc/+6f2aDGzRzjzB"
Organization: 
Message-Id: <1051280848.5939.61.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 Apr 2003 16:27:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Hic5hc/+6f2aDGzRzjzB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2003-04-25 at 16:15, Andreas Metzler wrote:
> Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> > Here goes the first candidate for 2.4.21.
>  
> > Please test it extensively.
> 
> I'd love to, but the problem reported in 
> 
> Subject: [2.4.21-pre5] compile error in ip_conntrack_ftp.c:440:
> Date: Wed, 5 Mar 2003 12:56:37 +0000 (UTC)
> Message-ID: <b44s65$pdl$1@main.gmane.org>
> http://www.ussg.iu.edu/hypermail/linux/kernel/0303.0/1008.html
> 
> still applies - I cannot compile the kernel.

I have a fix for this. I just have to get it approved before I can
submit it. It should make it possible for you to compile with your
config.

It's attached.

-- 
/Martin

--=-Hic5hc/+6f2aDGzRzjzB
Content-Disposition: attachment; filename=netfilter-ipv4-config-fix
Content-Type: text/x-patch; name=netfilter-ipv4-config-fix; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

diff -urN linux-2.4.21-pre7-bk.orig/net/ipv4/netfilter/Makefile linux-2.4.2=
1-pre7-bk/net/ipv4/netfilter/Makefile
--- linux-2.4.21-pre7-bk.orig/net/ipv4/netfilter/Makefile	2003-04-14 02:42:=
11.000000000 +0200
+++ linux-2.4.21-pre7-bk/net/ipv4/netfilter/Makefile	2003-04-14 02:42:44.00=
0000000 +0200
@@ -31,27 +31,25 @@
 # connection tracking
 obj-$(CONFIG_IP_NF_CONNTRACK) +=3D ip_conntrack.o
=20
-# Amanda protocol support
+# connection tracking helpers
 obj-$(CONFIG_IP_NF_AMANDA) +=3D ip_conntrack_amanda.o
-obj-$(CONFIG_IP_NF_NAT_AMANDA) +=3D ip_nat_amanda.o
-ifdef CONFIG_IP_NF_NAT_AMANDA
+ifdef CONFIG_IP_NF_AMANDA
 	export-objs +=3D ip_conntrack_amanda.o
 endif
=20
-
-# connection tracking helpers
 obj-$(CONFIG_IP_NF_TFTP) +=3D ip_conntrack_tftp.o
 obj-$(CONFIG_IP_NF_FTP) +=3D ip_conntrack_ftp.o
-ifdef CONFIG_IP_NF_NAT_FTP
+ifdef CONFIG_IP_NF_FTP
 	export-objs +=3D ip_conntrack_ftp.o
 endif
=20
 obj-$(CONFIG_IP_NF_IRC) +=3D ip_conntrack_irc.o
-ifdef CONFIG_IP_NF_NAT_IRC
+ifdef CONFIG_IP_NF_IRC
 	export-objs +=3D ip_conntrack_irc.o
 endif
=20
 # NAT helpers=20
+obj-$(CONFIG_IP_NF_NAT_AMANDA) +=3D ip_nat_amanda.o
 obj-$(CONFIG_IP_NF_NAT_TFTP) +=3D ip_nat_tftp.o
 obj-$(CONFIG_IP_NF_NAT_FTP) +=3D ip_nat_ftp.o
 obj-$(CONFIG_IP_NF_NAT_IRC) +=3D ip_nat_irc.o
diff -urN linux-2.4.21-pre7-bk.orig/net/ipv4/netfilter/ip_conntrack_amanda.=
c linux-2.4.21-pre7-bk/net/ipv4/netfilter/ip_conntrack_amanda.c
--- linux-2.4.21-pre7-bk.orig/net/ipv4/netfilter/ip_conntrack_amanda.c	2003=
-04-14 02:42:11.000000000 +0200
+++ linux-2.4.21-pre7-bk/net/ipv4/netfilter/ip_conntrack_amanda.c	2003-04-1=
4 02:42:44.000000000 +0200
@@ -229,5 +229,7 @@
 	return 0;
 }
=20
+EXPORT_SYMBOL(ip_amanda_lock);
+
 module_init(init);
 module_exit(fini);
diff -urN linux-2.4.21-pre7-bk.orig/net/ipv4/netfilter/ip_conntrack_ftp.c l=
inux-2.4.21-pre7-bk/net/ipv4/netfilter/ip_conntrack_ftp.c
--- linux-2.4.21-pre7-bk.orig/net/ipv4/netfilter/ip_conntrack_ftp.c	2003-04=
-14 02:42:02.000000000 +0200
+++ linux-2.4.21-pre7-bk/net/ipv4/netfilter/ip_conntrack_ftp.c	2003-04-14 0=
2:42:44.000000000 +0200
@@ -436,9 +436,7 @@
 	return 0;
 }
=20
-#ifdef CONFIG_IP_NF_NAT_NEEDED
 EXPORT_SYMBOL(ip_ftp_lock);
-#endif
=20
 MODULE_LICENSE("GPL");
 module_init(init);
diff -urN linux-2.4.21-pre7-bk.orig/net/ipv4/netfilter/ip_conntrack_irc.c l=
inux-2.4.21-pre7-bk/net/ipv4/netfilter/ip_conntrack_irc.c
--- linux-2.4.21-pre7-bk.orig/net/ipv4/netfilter/ip_conntrack_irc.c	2002-11=
-29 00:53:15.000000000 +0100
+++ linux-2.4.21-pre7-bk/net/ipv4/netfilter/ip_conntrack_irc.c	2003-04-14 0=
2:42:44.000000000 +0200
@@ -305,9 +305,7 @@
 	}
 }
=20
-#ifdef CONFIG_IP_NF_NAT_NEEDED
 EXPORT_SYMBOL(ip_irc_lock);
-#endif
=20
 module_init(init);
 module_exit(fini);

--=-Hic5hc/+6f2aDGzRzjzB--
