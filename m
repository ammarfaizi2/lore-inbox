Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVJaK0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVJaK0Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 05:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbVJaK0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 05:26:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59141 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750752AbVJaK0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 05:26:24 -0500
Date: Mon, 31 Oct 2005 11:26:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: [2.6 patch] fix the "QoS and/or fair queueing" menu
Message-ID: <20051031102621.GF8009@stusta.de>
References: <Pine.LNX.4.61.0510280902470.6910@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510280902470.6910@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 09:04:31AM +0200, Jan Engelhardt wrote:

> Hi,

Hi Jan,

> When CONFIG_NET_CLS is enabled, then "Firewall based classifier", "U32 
> classifier" and some more appear under the "Network options" menu rather 
> than "QoS and/or fair queueing" menu.
> This bug is in the recently released 2.6.14. (And earlier).

thanks for this report, a patch is below.

> Jan Engelhardt

cu
Adrian


<--  snip  -->


This patch adjust some dependencies in net/sched/Kconfig for getting all 
options that belong there under "QoS and/or fair queueing".

There is no actual semantic change in any dependency, the additional 
dependencies are added for helping kconfig to figure out what belongs to 
that menu.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/sched/Kconfig |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- linux-2.6.14-rc5-mm1-full/net/sched/Kconfig.old	2005-10-31 11:08:50.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/net/sched/Kconfig	2005-10-31 11:18:48.000000000 +0100
@@ -343,6 +343,7 @@
 
 config NET_CLS_ROUTE
 	bool
+	depends on NET_CLS
 	default n
 
 config NET_CLS_FW
@@ -375,7 +376,7 @@
 
 config NET_CLS_IND
 	bool "classify input device (slows things u32/fw) "
-	depends on NET_CLS_U32 || NET_CLS_FW
+	depends on NET_CLS && (NET_CLS_U32 || NET_CLS_FW)
 	help
 	  This option will be killed eventually when a 
           metadata action appears because it slows things a little
@@ -552,13 +553,6 @@
         requires new iproute2
         This allows for packets to be generically edited
 
-config NET_CLS_POLICE
-	bool "Traffic policing (needed for in/egress)"
-	depends on NET_CLS && NET_QOS && NET_CLS_ACT!=y
-	help
-	  Say Y to support traffic policing (bandwidth limits).  Needed for
-	  ingress and egress rate limiting.
-
 config NET_ACT_SIMP
         tristate "Simple action"
         depends on NET_CLS_ACT
@@ -569,3 +563,9 @@
 	All this action will do is print on the console the configured
 	policy string followed by _ then packet count.
 
+config NET_CLS_POLICE
+        bool "Traffic policing (needed for in/egress)"
+        depends on NET_CLS && NET_QOS && NET_CLS_ACT!=y
+        help
+          Say Y to support traffic policing (bandwidth limits).  Needed for
+          ingress and egress rate limiting.

