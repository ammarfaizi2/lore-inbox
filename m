Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVFTCph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVFTCph (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 22:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVFTCph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 22:45:37 -0400
Received: from [62.206.217.67] ([62.206.217.67]:51854 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261330AbVFTCpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 22:45:24 -0400
Date: Mon, 20 Jun 2005 04:45:15 +0200 (CEST)
From: Patrick McHardy <kaber@trash.net>
X-X-Sender: kaber@kaber.coreworks.de
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: netfilter-devel@manty.net, rankincj@yahoo.com,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       ebtables-devel@lists.sourceforge.net, bdschuym@pandora.be
Subject: Re: 2.6.12: connection tracking broken?
In-Reply-To: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au>
Message-ID: <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de>
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2005, Herbert Xu wrote:
> Patrick McHardy <kaber@trash.net> wrote:
>>
>> The bridge-netfilter code defers calling of some NF_IP_* hooks to the
>> bridge layer, when the conntrack reference is already gone, so the entry
>
> Why does it defer them at all? Shouldn't the fact that the device is
> bridged be transparent to the IP layer?

I couldn't figure out the reason, it seems to have something to do
with setting up device pointers for iptables and ebtables. It looks
like the only way to fix this problem without keeping the conntrack
reference while packets are queued at the device is to avoid defering
the NF_IP_* hooks. Bart, can you explain why the hooks are defered
please?

Regards
Patrick
