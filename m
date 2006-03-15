Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWCOEB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWCOEB6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 23:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbWCOEB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 23:01:58 -0500
Received: from metis.starhub.net.sg ([203.117.3.21]:42885 "EHLO
	metis.starhub.net.sg") by vger.kernel.org with ESMTP
	id S932200AbWCOEB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 23:01:57 -0500
X-SBRS: 3.5
X-HAT: Message received through Sender Group RELAYLIST,Policy $RELAYED applied.
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Date: Wed, 15 Mar 2006 11:55:04 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Re: Fix hostap_cs double kfree
In-reply-to: <44178469.3090907@terra.com.br>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, jkmaline@cc.hut.fi
Reply-to: Eugene Teo <eugene.teo@eugeneteo.net>
Message-id: <20060315035504.GA10602@eugeneteo.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-PGP-Key: http://www.honeynet.org/misc/pgp/eugene-teo.pgp
X-Operating-System: Debian GNU/Linux 2.6.16-rc6
References: <20060315023900.GA8179@eugeneteo.net>
 <44178469.3090907@terra.com.br>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<quote sender="Felipe W Damasio">
> Eugene Teo wrote:
> 
> >  failed:
> >-	kfree(parse);
> >-	kfree(hw_priv);
> >+	if (parse)
> >+		kfree(parse);
> >+	if (hw_priv)
> >+		kfree(hw_priv);
>
>     I don't think those if's are needed, since the kfree code already does:
> 
> void kfree(const void *objp)
> {
>         if (unlikely(!objp))
>                 return;
> ...
> }
> 
>     But if you really want to use it, I suggest using if (likely
> (!<pointer>)) there to hint gcc of a possible optimization.

Ah, thanks for the tip.

Eugene
-- 
1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }
