Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVHBKoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVHBKoN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 06:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVHBKoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 06:44:13 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:49235 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261478AbVHBKoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 06:44:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:x-message-flag:x-operating-system:x-editor:x-disclaimer:user-agent;
        b=P9+O+KAIRkmenu87zxrTXNklJ1lYehDTI1IL7SDu3e7fFrmLvVAjPvq+O81y9F8rBymJV4hdsLDpOWfzIGdpysMiT5kpQteTHZLhjWL5t5Ii6PLHVgMAq9rBW/sLDBbYEH3hRxsaY2/LgFaDdjPn34DRBrp8nEijxfVtTuoSr7c=
Date: Tue, 2 Aug 2005 12:44:49 +0200
From: Mattia Dongili <malattia@gmail.com>
To: Patrick McHardy <kaber@trash.net>
Cc: Harald Welte <laforge@netfilter.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG: atomic counter underflow at ip_conntrack_event_cache_init+0x91/0xb0 (with patch)
Message-ID: <20050802104449.GA3702@inferi.kami.home>
Mail-Followup-To: Patrick McHardy <kaber@trash.net>,
	Harald Welte <laforge@netfilter.org>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050801141327.GA3909@inferi.kami.home> <42EE3169.6070604@trash.net> <20050801160537.GA3850@inferi.kami.home> <42EE5721.1090509@trash.net> <42EEC2BB.3020105@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EEC2BB.3020105@trash.net>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.13-rc4-mm1-3 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 02:47:55AM +0200, Patrick McHardy wrote:
> Patrick McHardy wrote:
> > Mattia Dongili wrote:
[...]
> >>this doesn't fix it actually, see dmesg below:

blame me... It seems I forgot a damn --dry-run while applying your
first patch :P
And in fact your first fix solves the BUG I was seeing.

> > It looks like ip_ct_iterate_cleanup and ip_conntrack_event_cache_init
> > race against each other with assigning pointers and grabbing/putting the
> > refcounts if called from different contexts.
> 
> This should be a fist step towards fixing it. It's probably incomplete
> (I'm too tired to check it now), but it should fix the problem you're
> seeing. Could you give it a spin?

building right now

> BTW, ip_ct_iterate_cleanup can only be called from ipt_MASQUERADE when
> a device goes down. It seems a bit odd that this is happending on boot,
> is there anything special about your setup?

yes, ifplugd. This morning I noticed that booting without networking a
nd without loading ip_conntrack (no iptables rules) everything proceeded
smoothly. So rebooting normally I noticed that the BUG was triggered as
soon as ifplugd configured eth0 (with ip_conntrack already loaded).
I'll try to narrow the thing more and let you know.


-- 
mattia
:wq!
