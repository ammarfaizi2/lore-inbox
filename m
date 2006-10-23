Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWJWPpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWJWPpo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWJWPpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:45:44 -0400
Received: from stinky.trash.net ([213.144.137.162]:60056 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751054AbWJWPpn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:45:43 -0400
Message-ID: <453CE3A4.7030003@trash.net>
Date: Mon, 23 Oct 2006 17:45:40 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Zhu Yi <yi.zhu@intel.com>, LKML <linux-kernel@vger.kernel.org>,
       jketreno@linux.intel.com
Subject: Re: 2.6.19-rc2: ieee80211/ipw2200 regression
References: <200610230244.43948.s0348365@sms.ed.ac.uk> <200610231422.07647.s0348365@sms.ed.ac.uk> <200610231454.00238.s0348365@sms.ed.ac.uk> <200610231635.49869.s0348365@sms.ed.ac.uk>
In-Reply-To: <200610231635.49869.s0348365@sms.ed.ac.uk>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------000608080304000008000704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000608080304000008000704
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Alistair John Strachan wrote:
> Tried compiling as a module too and the ieee80211 system doesn't load arc4.ko 
> before bailing out. If I reboot, load it myself and try again, it still 
> doesn't work.
> 

Do you have CONFIG_CRYPTO_ECB enabled? I think this patch is needed.

Signed-off-by: Patrick McHardy <kaber@trash.net>

--------------000608080304000008000704
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

diff --git a/net/ieee80211/Kconfig b/net/ieee80211/Kconfig
index f7e84e9..dbf55d3 100644
--- a/net/ieee80211/Kconfig
+++ b/net/ieee80211/Kconfig
@@ -32,6 +32,7 @@ config IEEE80211_CRYPT_WEP
 	depends on IEEE80211
 	select CRYPTO
 	select CRYPTO_ARC4
+	select CRYPTO_ECB
 	select CRC32
 	---help---
 	Include software based cipher suites in support of IEEE

--------------000608080304000008000704--
