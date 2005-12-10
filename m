Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbVLJFkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVLJFkX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 00:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVLJFkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 00:40:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11423 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932297AbVLJFkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 00:40:22 -0500
Date: Sat, 10 Dec 2005 00:40:13 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: broken cast in parport_pc
Message-ID: <20051210054013.GA11286@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted by a Fedora user. Compiling with DEBUG_PARPORT set fails
due to the broken cast.

Just remove it.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.14/include/linux/parport_pc.h~	2005-12-10 00:26:42.000000000 -0500
+++ linux-2.6.14/include/linux/parport_pc.h	2005-12-10 00:38:57.000000000 -0500
@@ -86,7 +86,7 @@ extern __inline__ void dump_parport_stat
 	unsigned char dcr = inb (CONTROL (p));
 	unsigned char dsr = inb (STATUS (p));
 	static char *ecr_modes[] = {"SPP", "PS2", "PPFIFO", "ECP", "xXx", "yYy", "TST", "CFG"};
-	const struct parport_pc_private *priv = (parport_pc_private *)p->physport->private_data;
+	const struct parport_pc_private *priv = p->physport->private_data;
 	int i;
 
 	printk (KERN_DEBUG "*** parport state (%s): ecr=[%s", str, ecr_modes[(ecr & 0xe0) >> 5]);
