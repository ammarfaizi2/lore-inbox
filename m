Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWAZBzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWAZBzW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 20:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWAZBzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 20:55:22 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:64889 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751284AbWAZBzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 20:55:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=g+B+lbtZab9b5EK9/DnekYylJrHMMPpJQ7ld50sWyxNpDFtQLe5VmHffNK2avYwYtsTwzcz1csJnayPTl77QUSjDCA8zAxCtNT/fhRkOVZZYQt9LPxjfjWu+oUEJmYE+bL41jwRJWXvexpnAAcO0noua0OQUurA4ySAgIvMZTEo=
Date: Thu, 26 Jan 2006 05:13:07 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi: mem_{in,out}[bwl] => intf_mem_{in,out}[bwl]
Message-ID: <20060126021307.GA6577@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On mips:

drivers/char/ipmi/ipmi_si_intf.c:1274: error: conflicting types for 'mem_inb'
include/asm/io.h:436: error: previous definition of 'mem_inb' was here

Don't look at line 436 unless you really know what you're doing.

Move those static functions out of more or less generic namespace.

Signed-off-by: Alexey "## should be banned" Dobriyan <adobriyan@gmail.com>
---

 drivers/char/ipmi/ipmi_si_intf.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1270,36 +1270,36 @@ static int try_init_port(int intf_num, s
 	return 0;
 }
 
-static unsigned char mem_inb(struct si_sm_io *io, unsigned int offset)
+static unsigned char intf_mem_inb(struct si_sm_io *io, unsigned int offset)
 {
 	return readb((io->addr)+(offset * io->regspacing));
 }
 
-static void mem_outb(struct si_sm_io *io, unsigned int offset,
+static void intf_mem_outb(struct si_sm_io *io, unsigned int offset,
 		     unsigned char b)
 {
 	writeb(b, (io->addr)+(offset * io->regspacing));
 }
 
-static unsigned char mem_inw(struct si_sm_io *io, unsigned int offset)
+static unsigned char intf_mem_inw(struct si_sm_io *io, unsigned int offset)
 {
 	return (readw((io->addr)+(offset * io->regspacing)) >> io->regshift)
 		&& 0xff;
 }
 
-static void mem_outw(struct si_sm_io *io, unsigned int offset,
+static void intf_mem_outw(struct si_sm_io *io, unsigned int offset,
 		     unsigned char b)
 {
 	writeb(b << io->regshift, (io->addr)+(offset * io->regspacing));
 }
 
-static unsigned char mem_inl(struct si_sm_io *io, unsigned int offset)
+static unsigned char intf_mem_inl(struct si_sm_io *io, unsigned int offset)
 {
 	return (readl((io->addr)+(offset * io->regspacing)) >> io->regshift)
 		&& 0xff;
 }
 
-static void mem_outl(struct si_sm_io *io, unsigned int offset,
+static void intf_mem_outl(struct si_sm_io *io, unsigned int offset,
 		     unsigned char b)
 {
 	writel(b << io->regshift, (io->addr)+(offset * io->regspacing));
@@ -1349,16 +1349,16 @@ static int mem_setup(struct smi_info *in
 	   upon the register size. */
 	switch (info->io.regsize) {
 	case 1:
-		info->io.inputb = mem_inb;
-		info->io.outputb = mem_outb;
+		info->io.inputb = intf_mem_inb;
+		info->io.outputb = intf_mem_outb;
 		break;
 	case 2:
-		info->io.inputb = mem_inw;
-		info->io.outputb = mem_outw;
+		info->io.inputb = intf_mem_inw;
+		info->io.outputb = intf_mem_outw;
 		break;
 	case 4:
-		info->io.inputb = mem_inl;
-		info->io.outputb = mem_outl;
+		info->io.inputb = intf_mem_inl;
+		info->io.outputb = intf_mem_outl;
 		break;
 #ifdef readq
 	case 8:

