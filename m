Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVASGdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVASGdB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 01:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVASGdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 01:33:01 -0500
Received: from pc1.pod.cz ([213.155.230.51]:51406 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id S261600AbVASGc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 01:32:59 -0500
Date: Wed, 19 Jan 2005 07:32:57 +0100
From: Vitezslav Samel <samel@mail.cz>
To: Shaun Jackman <sjackman@gmail.com>, Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: [NET] TUN needs CRC32 after adding multicast filtering to it
Message-ID: <20050119063257.GA10015@pc11.op.pod.cz>
Mail-Followup-To: Shaun Jackman <sjackman@gmail.com>,
	Andrew Morton <akpm@osdl.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

  Just tried to compile 2.6.11-rc1, but it fails with unresolved symbols
"bitreverse" etc. Found out that TUN driver needs CRC32 which I haven't
compiled in.
  Following patch fixes this. Please, consider applying.

	Cheers,
		Vita


diff -urN linux-2.6.11-rc1.orig/drivers/net/Kconfig linux-2.6.11-rc1/drivers/net/Kconfig
--- linux-2.6.11-rc1.orig/drivers/net/Kconfig	Fri Jan 14 14:45:30 2005
+++ linux-2.6.11-rc1/drivers/net/Kconfig	Wed Jan 19 07:11:00 2005
@@ -84,6 +84,7 @@
 config TUN
 	tristate "Universal TUN/TAP device driver support"
 	depends on NETDEVICES
+	select CRC32
 	---help---
 	  TUN/TAP provides packet reception and transmission for user space
 	  programs.  It can be viewed as a simple Point-to-Point or Ethernet
