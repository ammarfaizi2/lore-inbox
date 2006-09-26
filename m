Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWIZUWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWIZUWB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWIZUWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:22:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44949 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964782AbWIZUWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:22:00 -0400
Subject: Re: [PATCH] restore libata build on frv
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Howells <dhowells@redhat.com>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0609260909470.3952@g5.osdl.org>
References: <20060925142016.GI29920@ftp.linux.org.uk>
	 <1159186771.11049.63.camel@localhost.localdomain>
	 <1159183568.11049.51.camel@localhost.localdomain>
	 <20060924223925.GU29920@ftp.linux.org.uk>
	 <22314.1159181060@warthog.cambridge.redhat.com>
	 <5578.1159183668@warthog.cambridge.redhat.com>
	 <7276.1159186684@warthog.cambridge.redhat.com>
	 <20660.1159195152@warthog.cambridge.redhat.com>
	 <1159199184.11049.93.camel@localhost.localdomain>
	 <1159258013.3309.9.camel@pmac.infradead.org> <4518EA39.40309@pobox.com>
	 <1159260980.3309.22.camel@pmac.infradead.org>
	 <Pine.LNX.4.64.0609260909470.3952@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 21:21:09 +0100
Message-Id: <1159302069.3309.46.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-26 at 09:15 -0700, Linus Torvalds wrote:
> That NO_IRQ thing should be zero, and any architecture that thinks that 
> zero is a valid IRQ just needs to fix its own irq mapping so that the 
> "cookie" doesn't work.

> The thing is, it's zero. Get over it. 

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 92be519..0cdf8ad 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -219,7 +219,7 @@ int setup_irq(unsigned int irq, struct i
 	unsigned long flags;
 	int shared = 0;
 
-	if (irq >= NR_IRQS)
+	if (!irq || irq >= NR_IRQS)
 		return -EINVAL;
 
 	if (desc->chip == &no_irq_chip)

-- 
dwmw2

