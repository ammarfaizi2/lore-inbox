Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbUEAUNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUEAUNv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 16:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbUEAUNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 16:13:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48863 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262065AbUEAUNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 16:13:49 -0400
Date: Sat, 1 May 2004 22:13:42 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-dvb-maintainer@linuxtv.org
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.6-rc3: modular DVB tda1004x broken
Message-ID: <20040501201342.GL2541@fs.tum.de>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org> <408F9BD8.8000203@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408F9BD8.8000203@eyal.emu.id.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 09:56:08PM +1000, Eyal Lebedinsky wrote:
>...
> depmod says:
> 
> WARNING: 
> /lib/modules/2.6.6-rc3/kernel/drivers/media/dvb/frontends/tda1004x.ko needs 
> unknown symbol errno
>...

Thanks for this report.

It seems the DVB updates broke this.

Please _undo_ the patch below.

cu
Adrian

--- a/drivers/media/dvb/frontends/tda1004x.c	Tue Apr 27 18:37:15 2004
+++ b/drivers/media/dvb/frontends/tda1004x.c	Tue Apr 27 18:37:15 2004
@@ -188,7 +190,6 @@
 static struct fwinfo tda10046h_fwinfo[] = { {.file_size = 286720,.fw_offset = 0x3c4f9,.fw_size = 24479} };
 static int tda10046h_fwinfo_count = sizeof(tda10046h_fwinfo) / sizeof(struct fwinfo);
 
-static int errno;
 
 
 static int tda1004x_write_byte(struct dvb_i2c_bus *i2c, struct tda1004x_state *tda_state, int reg, int data)
