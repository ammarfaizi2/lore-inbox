Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264559AbTFTUCm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 16:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbTFTUCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 16:02:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21003 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264559AbTFTUCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 16:02:40 -0400
Date: Fri, 20 Jun 2003 21:16:40 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Eivind Tagseth <eivindt@multinet.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with PCMCIA Compact Flash adapter in 2.5.72
Message-ID: <20030620211640.B913@flint.arm.linux.org.uk>
Mail-Followup-To: Eivind Tagseth <eivindt@multinet.no>,
	linux-kernel@vger.kernel.org
References: <20030620081846.GB2451@tagseth-trd.consultit.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030620081846.GB2451@tagseth-trd.consultit.no>; from eivindt@multinet.no on Fri, Jun 20, 2003 at 10:18:46AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 10:18:46AM +0200, Eivind Tagseth wrote:
> I've got a Kingston Compact Flash adapter that I use to mount the flash
> card of my digital camera.  I've had several problems with the kernel
> with this, both 2.4.20, 2.5.69 and 2.5.72.

Hmm, you mention pcmcia-cs 3.2.4 later in your mail.  Are you trying to
get pcmcia-cs modules to work with the 2.5.72 pcmcia subsystem?

> I always seem to forget some vital information when reporting bugs, 
> please don't hesitate to ask for more info.  I'll be happy to try any
> patches to the kernel and/or cardmgr if needed.

There is this which fixes some people problems, and is already in Linus'
recent bk tree.  Does this solve your problem?

--- orig/drivers/pcmcia/cs.c	Tue Jun 17 12:56:30 2003
+++ linux/drivers/pcmcia/cs.c	Wed Jun 18 09:47:39 2003
@@ -816,7 +816,8 @@
 				if ((skt->state & SOCKET_PRESENT) &&
 				     !(status & SS_DETECT))
 					socket_shutdown(skt);
-				if (status & SS_DETECT)
+				if (!(skt->state & SOCKET_PRESENT) &&
+				    status & SS_DETECT)
 					socket_insert(skt);
 			}
 			if (events & SS_BATDEAD)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

