Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263068AbUJ1X0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263068AbUJ1X0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbUJ1XZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:25:10 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55058 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263070AbUJ1XW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:22:56 -0400
Date: Fri, 29 Oct 2004 01:22:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] serial_core.c: remove an unused function
Message-ID: <20041028232220.GI3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from 
drivers/serial/serial_core.c


diffstat output:
 drivers/serial/serial_core.c |   40 -----------------------------------
 1 files changed, 40 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/drivers/serial/serial_core.c.old	2004-10-28 23:28:48.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/serial/serial_core.c	2004-10-28 23:28:58.000000000 +0200
@@ -444,46 +444,6 @@
 }
 
 static inline int
- -__uart_user_write(struct uart_port *port, struct circ_buf *circ,
- -		  const unsigned char __user *buf, int count)
- -{
- -	unsigned long flags;
- -	int c, ret = 0;
- -
- -	if (down_interruptible(&port->info->tmpbuf_sem))
- -		return -EINTR;
- -
- -	while (1) {
- -		int c1;
- -		c = CIRC_SPACE_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
- -		if (count < c)
- -			c = count;
- -		if (c <= 0)
- -			break;
- -
- -		c -= copy_from_user(port->info->tmpbuf, buf, c);
- -		if (!c) {
- -			if (!ret)
- -				ret = -EFAULT;
- -			break;
- -		}
- -		spin_lock_irqsave(&port->lock, flags);
- -		c1 = CIRC_SPACE_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
- -		if (c1 < c)
- -			c = c1;
- -		memcpy(circ->buf + circ->head, port->info->tmpbuf, c);
- -		circ->head = (circ->head + c) & (UART_XMIT_SIZE - 1);
- -		spin_unlock_irqrestore(&port->lock, flags);
- -		buf += c;
- -		count -= c;
- -		ret += c;
- -	}
- -	up(&port->info->tmpbuf_sem);
- -
- -	return ret;
- -}
- -
- -static inline int
 __uart_kern_write(struct uart_port *port, struct circ_buf *circ,
 		  const unsigned char *buf, int count)
 {

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgX8smfzqmE8StAARAqE1AJ9dRUsN9r2xdA9EFQN5/fHXicotmgCdGx+4
jnmHYPR4TUjMXwXiN2btqDs=
=PE8M
-----END PGP SIGNATURE-----
