Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbVLMI1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbVLMI1F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbVLMIZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:25:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:65411 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932558AbVLMIY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:24:59 -0500
Date: Tue, 13 Dec 2005 00:22:16 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       bunk@stusta.de, rolandd@cisco.com
Subject: [patch 03/26] drivers/infiniband/core/mad.c: fix a use-after-free
Message-ID: <20051213082215.GD5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="infiniband-fix-a-null-pointer-deref.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Adrian Bunk <bunk@stusta.de>

The Coverity checker spotted this obvious use-after-free
caused by a wrong order of the cleanups.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Roland Dreier <rolandd@cisco.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/infiniband/core/mad.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.14.3.orig/drivers/infiniband/core/mad.c
+++ linux-2.6.14.3/drivers/infiniband/core/mad.c
@@ -356,9 +356,9 @@ error4:
 	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
 	kfree(reg_req);
 error3:
-	kfree(mad_agent_priv);
-error2:
 	ib_dereg_mr(mad_agent_priv->agent.mr);
+error2:
+	kfree(mad_agent_priv);
 error1:
 	return ret;
 }

--
