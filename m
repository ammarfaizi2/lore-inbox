Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVFUBm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVFUBm3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 21:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVFUAAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:00:35 -0400
Received: from [62.206.217.67] ([62.206.217.67]:47745 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261688AbVFTX1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:27:35 -0400
Message-ID: <42B750E3.4070209@trash.net>
Date: Tue, 21 Jun 2005 01:27:31 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Phil Oester <kernel@linuxace.com>
CC: Bart De Schuymer <bdschuym@pandora.be>,
       Bart De Schuymer <bdschuym@telenet.be>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       rankincj@yahoo.com, ebtables-devel@lists.sourceforge.net,
       netfilter-devel@manty.net
Subject: Re: 2.6.12: connection tracking broken?
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au> <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de> <1119249575.3387.3.camel@localhost.localdomain> <42B6B373.20507@trash.net> <1119293193.3381.9.camel@localhost.localdomain> <20050620185736.GA4883@linuxace.com>
In-Reply-To: <20050620185736.GA4883@linuxace.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Oester wrote:
> The changes were originally made to fix conntrack unload problems with
> raw sockets.  My original patch performed the nf_reset in the socket
> code, but Patrick suggested moving it to ip_output.  The below patch
> reverts the ip_output changes, and implements the original suggested
> changes to raw socket handling.  
> 
> While this is unlikely to be the permanent solution, it will fix the
> current bridging problems while retaining the raw socket fixes.  I'd
> suggest that this could be included in -stable while researching
> other solutions.

I disagree. We will probably have a final solution within a few days,
so I don't think we need to submit "temporary" fixes yet. Your patch
actually causes a regression for people not using bringe-netfilter,
unplugging a network cable can cause the conntrack module to become
unloadable again.

Regards
Patrick
