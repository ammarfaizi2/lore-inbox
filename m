Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWCPMRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWCPMRg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 07:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbWCPMRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 07:17:36 -0500
Received: from kbsmtao2.starhub.net.sg ([203.116.2.167]:35046 "EHLO
	kbsmtao2.starhub.net.sg") by vger.kernel.org with ESMTP
	id S1751155AbWCPMRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 07:17:36 -0500
Date: Thu, 16 Mar 2006 20:17:36 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Re: Fix seq_clientmgr dereferences before NULL check
In-reply-to: <s5hfylir72e.wl%tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Frank van de Pol <fvdpol@coil.demon.nl>,
       Jaroslav Kysela <perex@suse.cz>
Reply-to: Eugene Teo <eugene.teo@eugeneteo.net>
Message-id: <20060316121736.GA24686@eugeneteo.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-PGP-Key: http://www.honeynet.org/misc/pgp/eugene-teo.pgp
X-Operating-System: Debian GNU/Linux 2.6.16-rc6
References: <20060316014606.GA20609@eugeneteo.net>
 <s5hfylir72e.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<quote sender="Takashi Iwai">
> At Thu, 16 Mar 2006 09:46:06 +0800,
> Eugene Teo wrote:
> > 
> > Fix cptr->pool dereferences before NULL check.
> 
> cptr->pool must be non-NULL there, so just the if (cptr->pool) is
> superfluous.

Resend.

Eugene

--
cptr->pool must be non-NULL there, so just the if (cptr->pool) is
superfluous. Thanks Takashi.

Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

--- linux-2.6/sound/core/seq/seq_clientmgr.c~	2006-03-15 10:05:45.000000000 +0800
+++ linux-2.6/sound/core/seq/seq_clientmgr.c	2006-03-16 20:14:29.000000000 +0800
@@ -1866,8 +1866,7 @@ static int snd_seq_ioctl_get_client_pool
 	info.output_pool = cptr->pool->size;
 	info.output_room = cptr->pool->room;
 	info.output_free = info.output_pool;
-	if (cptr->pool)
-		info.output_free = snd_seq_unused_cells(cptr->pool);
+	info.output_free = snd_seq_unused_cells(cptr->pool);
 	if (cptr->type == USER_CLIENT) {
 		info.input_pool = cptr->data.user.fifo_pool_size;
 		info.input_free = info.input_pool;

-- 
1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }

