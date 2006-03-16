Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWCPLxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWCPLxn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 06:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbWCPLxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 06:53:43 -0500
Received: from kbsmtao2.starhub.net.sg ([203.116.2.167]:21181 "EHLO
	kbsmtao2.starhub.net.sg") by vger.kernel.org with ESMTP
	id S1751106AbWCPLxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 06:53:42 -0500
Date: Thu, 16 Mar 2006 19:53:42 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Re: Fix gus_pcm dereference before NULL
In-reply-to: <s5hek12r6w5.wl%tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>
Reply-to: Eugene Teo <eugene.teo@eugeneteo.net>
Message-id: <20060316115342.GB24356@eugeneteo.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-PGP-Key: http://www.honeynet.org/misc/pgp/eugene-teo.pgp
X-Operating-System: Debian GNU/Linux 2.6.16-rc6
References: <20060316020007.GA20734@eugeneteo.net>
 <s5hek12r6w5.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<quote sender="Takashi Iwai">
> At Thu, 16 Mar 2006 10:00:07 +0800,
> Eugene Teo wrote:
> > 
> > substream is dereferenced before checking for NULL.
> 
> The NULL check of substream is simply superfluous.
> It is guaranteed to receive non-NULL substream and
> substream->runtime.
> > 
> > Coverity bug #861
> > 
> > Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

Resend.

Eugene

--
The NULL check of substream is simply superfluous. It is
guaranteed to receive non-NULL substream. Thanks Takashi.

Coverity bug #861

Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

--- linux-2.6/sound/isa/gus/gus_pcm.c~	2006-03-15 10:05:45.000000000 +0800
+++ linux-2.6/sound/isa/gus/gus_pcm.c	2006-03-16 19:50:45.000000000 +0800
@@ -114,8 +114,6 @@ static void snd_gf1_pcm_trigger_up(struc
 	unsigned char pan;
 	unsigned int voice;
 
-	if (substream == NULL)
-		return;
 	spin_lock_irqsave(&pcmp->lock, flags);
 	if (pcmp->flags & SNDRV_GF1_PCM_PFLG_ACTIVE) {
 		spin_unlock_irqrestore(&pcmp->lock, flags);

-- 
1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }

