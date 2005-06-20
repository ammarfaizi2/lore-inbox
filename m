Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVFTMQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVFTMQC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 08:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVFTMQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 08:16:02 -0400
Received: from [62.206.217.67] ([62.206.217.67]:55789 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261151AbVFTMPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 08:15:54 -0400
Message-ID: <42B6B373.20507@trash.net>
Date: Mon, 20 Jun 2005 14:15:47 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Bart De Schuymer <bdschuym@telenet.be>
CC: Herbert Xu <herbert@gondor.apana.org.au>, bdschuym@pandora.be,
       netfilter-devel@manty.net, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org, ebtables-devel@lists.sourceforge.net,
       rankincj@yahoo.com
Subject: Re: 2.6.12: connection tracking broken?
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au>	 <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de> <1119249575.3387.3.camel@localhost.localdomain>
In-Reply-To: <1119249575.3387.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart De Schuymer wrote:
> Op ma, 20-06-2005 te 04:45 +0200, schreef Patrick McHardy:
> 
>> Bart, can you explain why the hooks are defered please?
> 
> This is done so that iptables knows which bridge port the output device
> is, using the iptables physdev match.

In which cases is this necessary? AFAICT the output device is determined
in br_handle_frame_finish() for a normally bridged packet.

> Can't you release the conntrack reference with a function registered on
> the POSTROUTING hook with a prio higher than nat POSTROUTING (or
> something like that)?

We would have to hold the reference while the packet is queued at the
device for the bridge case, which we want to avoid.

Regards
Patrick
