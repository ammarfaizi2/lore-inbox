Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264566AbUAOAOe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 19:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbUAOAOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 19:14:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:46277 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264566AbUAOAOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 19:14:33 -0500
Date: Wed, 14 Jan 2004 16:13:24 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: jt@hpl.hp.com, jt@bougret.hpl.hp.com, jgarzik@pobox.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.X] SIOCSIFNAME wilcard suppor & name validation
Message-Id: <20040114161324.61b7198f.shemminger@osdl.org>
In-Reply-To: <20040113162112.509edb71.davem@redhat.com>
References: <20040112234332.GA1785@bougret.hpl.hp.com>
	<20040113142204.0b41403b.shemminger@osdl.org>
	<20040113162112.509edb71.davem@redhat.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug: dev_alloc_name returns the number of the slot used, so comparison needs
to be < 0.

diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Wed Jan 14 16:09:02 2004
+++ b/net/core/dev.c	Wed Jan 14 16:09:02 2004
@@ -718,7 +718,7 @@
 
 	if (strchr(newname, '%')) {
 		int err = dev_alloc_name(dev, newname);
-		if (err)
+		if (err < 0)
 			return err;
 		strcpy(newname, dev->name);
 	}
