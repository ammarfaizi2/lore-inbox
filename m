Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWDYVEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWDYVEv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 17:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWDYVEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 17:04:51 -0400
Received: from web50212.mail.yahoo.com ([206.190.39.176]:8100 "HELO
	web50212.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932309AbWDYVEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 17:04:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=pjo2YRzuSH2J+u9yrtFLbEv++8KTEXxBvmiz5OnbmVXSktRlcNDEIdtPsO5nmtCZgxijVo+g5jYgtgmDG3PNVy7RzsoXVAf89b7VEwlbqR9WTSbemDS1fNrCEb6HQAh0gpJnQBa6Vj/BCOCDRxR3gX8AbEzjyuqz41YclaEAShw=  ;
Message-ID: <20060425210450.72120.qmail@web50212.mail.yahoo.com>
Date: Tue, 25 Apr 2006 14:04:50 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: [PATCH] compile error in ieee80211_ioctl.c
To: linville@tuxdriver.com, linux-netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

I sent this patch earlier and got no response, so I'm sending it again.


I cloned git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-dev.git
last night and got compile errors while compiling net/d80211/ieee80211_ioctl.c
into a module:

  CC [M]  net/d80211/ieee80211_ioctl.o
net/d80211/ieee80211_ioctl.c:33: error: syntax error before string constant
net/d80211/ieee80211_ioctl.c:33: warning: type defaults to `int' in declaration of `MODULE_PARM'
net/d80211/ieee80211_ioctl.c:33: warning: function declaration isn't a prototype
net/d80211/ieee80211_ioctl.c:33: warning: data definition has no type or storage class
net/d80211/ieee80211_ioctl.c:43: error: syntax error before string constant
net/d80211/ieee80211_ioctl.c:43: warning: type defaults to `int' in declaration of `MODULE_PARM'
net/d80211/ieee80211_ioctl.c:43: warning: function declaration isn't a prototype
net/d80211/ieee80211_ioctl.c:43: warning: data definition has no type or storage class
make[2]: *** [net/d80211/ieee80211_ioctl.o] Error 1
make[1]: *** [net/d80211] Error 2
make: *** [net] Error 2

This patch fixes it.

Signed-off-by: Alex Davis <alex14641@yahoo.com>

diff --git a/net/d80211/ieee80211_ioctl.c b/net/d80211/ieee80211_ioctl.c
index 42a7abe..4949e52 100644
--- a/net/d80211/ieee80211_ioctl.c
+++ b/net/d80211/ieee80211_ioctl.c
@@ -30,7 +30,7 @@ #include "aes_ccm.h"
 
 
 static int ieee80211_regdom = 0x10; /* FCC */
-MODULE_PARM(ieee80211_regdom, "i");
+module_param(ieee80211_regdom, int, 0x10);
 MODULE_PARM_DESC(ieee80211_regdom, "IEEE 802.11 regulatory domain; 64=MKK");
 
 /*
@@ -40,7 +40,7 @@ MODULE_PARM_DESC(ieee80211_regdom, "IEEE
  * module.
  */
 static int ieee80211_japan_5ghz /* = 0 */;
-MODULE_PARM(ieee80211_japan_5ghz, "i");
+module_param(ieee80211_japan_5ghz, int, 0);
 MODULE_PARM_DESC(ieee80211_japan_5ghz, "Vendor-updated firmware for 5 GHz");

I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
