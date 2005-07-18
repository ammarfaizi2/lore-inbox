Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVGRJu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVGRJu4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 05:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVGRJuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 05:50:55 -0400
Received: from mail.charite.de ([160.45.207.131]:24799 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S261327AbVGRJuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 05:50:52 -0400
Date: Mon, 18 Jul 2005 11:50:46 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.3 flooding my logs
Message-ID: <20050718095046.GL19921@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050717215306.GK10995@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050717215306.GK10995@charite.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:
> 2.6.13.2 didn't do this, now I'm getting (from dmesg):
> 
> PROTO=17 127.0.0.1:53 127.0.0.1:56872 L=56 S=0x00 I=40463 F=0x4000 T=64
> ip_local_deliver: bad skb: PRE_ROUTING LOCAL_IN LOCAL_OUT POST_ROUTING 
> skb: pf=2 (unowned) dev=lo len=56
> PROTO=17 127.0.0.1:56872 127.0.0.1:53 L=56 S=0x00 I=12024 F=0x4000 T=64
> ip_local_deliver: bad skb: PRE_ROUTING LOCAL_IN LOCAL_OUT POST_ROUTING 
> skb: pf=2 (unowned) dev=lo len=89
> PROTO=17 127.0.0.1:53 127.0.0.1:56872 L=89 S=0x00 I=40464 F=0x4000 T=64
> ip_local_deliver: bad skb: PRE_ROUTING LOCAL_IN LOCAL_OUT POST_ROUTING 
> skb: pf=2 (unowned) dev=lo len=124
> PROTO=17 127.0.0.1:53 127.0.0.1:56729 L=124 S=0x00 I=40465 F=0x4000 T=64
> ip_local_deliver: bad skb: PRE_ROUTING LOCAL_IN LOCAL_OUT POST_ROUTING 
> skb: pf=2 (unowned) dev=lo len=152
> PROTO=1 127.0.0.1:0 127.0.0.1:0 L=152 S=0xC0 I=41998 F=0x0000 T=64
> 
> What is it? Looks like debug output, but I haven't turned any of that
> on.

This must be related to this change:
    [PATCH] revert nf_reset change
        
    [NETFILTER]: Revert nf_reset change
	        
Revert the nf_reset change that caused so much trouble, drop conntrack
references manually before packets are queued to packet sockets.
        
Adapted for 2.6.12 by Daniel Drake <dsd@gentoo.org>
	        
  Signed-off-by: Phil Oester <kernel@linuxace.com>
  Signed-off-by: Patrick McHardy <kaber@trash.net>
  Signed-off-by: Chris Wright <chrisw@osdl.org>
  Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
