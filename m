Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWCPLtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWCPLtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 06:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWCPLtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 06:49:13 -0500
Received: from kbsmtao2.starhub.net.sg ([203.116.2.167]:59822 "EHLO
	kbsmtao2.starhub.net.sg") by vger.kernel.org with ESMTP
	id S1751051AbWCPLtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 06:49:12 -0500
Date: Thu, 16 Mar 2006 19:48:40 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Re: Fix ali5451 dereferenced before NULL check
In-reply-to: <s5hbqw6r6jb.wl%tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Reply-to: Eugene Teo <eugene.teo@eugeneteo.net>
Message-id: <20060316114840.GA24356@eugeneteo.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-PGP-Key: http://www.honeynet.org/misc/pgp/eugene-teo.pgp
X-Operating-System: Debian GNU/Linux 2.6.16-rc6
References: <20060316013602.GA20455@eugeneteo.net>
 <s5hbqw6r6jb.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi-san,

<quote sender="Takashi Iwai">
> At Thu, 16 Mar 2006 09:36:02 +0800,
> Eugene Teo wrote:
> > 
> > pvoice is missing a NULL check. channel needs a bound check too.
> 
> Both checks are not necessary.  There is a single caller to this
> function, and the channel argument is a loop value of

All right.

> 	for (channel = 0; channel < ALI_CHANNELS; channel++)
> 		snd_ali_update_ptr(codec, channel);
> 
> pvoice is the address pointing a part of a structure, so it cannot be
> NULL anyway.  If a check were needed, it should be if (codec != NULL).

A check for codec is unnecessary. snd_ali_card_interrupt() is the only
caller for snd_ali_interrupt() and it checks codec for NULL before it
calls the function to perform the above for loop.

Thanks.

Eugene
-- 
1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }

