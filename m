Return-Path: <linux-kernel-owner+w=401wt.eu-S1753721AbWLRKSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721AbWLRKSF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 05:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753722AbWLRKSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 05:18:05 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:38574 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721AbWLRKSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 05:18:03 -0500
X-Originating-Ip: 24.148.236.183
Date: Mon, 18 Dec 2006 05:14:01 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove logically superfluous comparisons from Kconfig files.
Message-ID: <Pine.LNX.4.64.0612180509010.22527@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.754, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Remove Kconfig comparisons of the form FUBAR || FUBAR=n, since they
appear to be superfluous.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  based on what i read in kconfig-language.txt, it would *appear* that
those comparisons are redundant, but i'm willing to be convinced
otherwise.  (unless the developer specifically wanted the case of
"!=m", which i'm fairly sure is not the same thing, yes?)



 drivers/char/drm/Kconfig   |    2 +-
 fs/dlm/Kconfig             |    1 -
 net/ipv4/netfilter/Kconfig |    1 -
 net/sctp/Kconfig           |    1 -
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/drm/Kconfig b/drivers/char/drm/Kconfig
index ef833a1..d681e68 100644
--- a/drivers/char/drm/Kconfig
+++ b/drivers/char/drm/Kconfig
@@ -6,7 +6,7 @@
 #
 config DRM
 	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
-	depends on (AGP || AGP=n) && PCI
+	depends on && PCI
 	help
 	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
 	  introduced in XFree86 4.0. If you say Y here, you need to select
diff --git a/fs/dlm/Kconfig b/fs/dlm/Kconfig
index b5654a2..7cf868a 100644
--- a/fs/dlm/Kconfig
+++ b/fs/dlm/Kconfig
@@ -3,7 +3,6 @@ menu "Distributed Lock Manager"

 config DLM
 	tristate "Distributed Lock Manager (DLM)"
-	depends on IPV6 || IPV6=n
 	select CONFIGFS_FS
 	select IP_SCTP if DLM_SCTP
 	help
diff --git a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
index f6026d4..92b1bba 100644
--- a/net/ipv4/netfilter/Kconfig
+++ b/net/ipv4/netfilter/Kconfig
@@ -78,7 +78,6 @@ config IP_NF_CONNTRACK_NETLINK
 	tristate 'Connection tracking netlink interface (EXPERIMENTAL)'
 	depends on EXPERIMENTAL && IP_NF_CONNTRACK && NETFILTER_NETLINK
 	depends on IP_NF_CONNTRACK!=y || NETFILTER_NETLINK!=m
-	depends on IP_NF_NAT=n || IP_NF_NAT
 	help
 	  This option enables support for a netlink-based userspace interface

diff --git a/net/sctp/Kconfig b/net/sctp/Kconfig
index 9cba49e..4edf997 100644
--- a/net/sctp/Kconfig
+++ b/net/sctp/Kconfig
@@ -7,7 +7,6 @@ menu "SCTP Configuration (EXPERIMENTAL)"

 config IP_SCTP
 	tristate "The SCTP Protocol (EXPERIMENTAL)"
-	depends on IPV6 || IPV6=n
 	select CRYPTO if SCTP_HMAC_SHA1 || SCTP_HMAC_MD5
 	select CRYPTO_HMAC if SCTP_HMAC_SHA1 || SCTP_HMAC_MD5
 	select CRYPTO_SHA1 if SCTP_HMAC_SHA1

