Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVJHWW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVJHWW2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 18:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVJHWW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 18:22:28 -0400
Received: from mf01.sitadelle.com ([212.94.174.68]:56959 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751169AbVJHWW1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 18:22:27 -0400
Message-ID: <434846A0.5080802@cosmosbay.com>
Date: Sun, 09 Oct 2005 00:22:24 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: LeoY <multisyncfe991@hotmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Is this skb recycle buffer helpful to improve Linux network stack
 performance?
References: <BAY108-DAV4CDAEF052852412160A0893870@phx.gbl> <43483E57.1040205@cosmosbay.com> <BAY108-DAV140650CDA8608152927C4E93870@phx.gbl> <434843B5.3020306@cosmosbay.com> <BAY108-DAV4008FD962D8FEC0497CC193870@phx.gbl>
In-Reply-To: <BAY108-DAV4008FD962D8FEC0497CC193870@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LeoY a écrit :
> Hi Eric,
> 
> Thanks for your reply.
> 1. For the packet size, this idea is targeting some specific network 
> card driver and we assume all the packet size will not exceed 2KB.
> 2. Currently only Uni-Processor is considered(Hyper-threading is also 
> disabled), I will add spin lock part once it works on the UP.
> 

1) Even on Uni-Processor, you still need to protect against IRQS

2) The big cost of kmalloc()/kfree() come from the 
local_irq_save(flags)/local_irq_restore(flags)

Once you add them in your code, you will discover you gain nothing compared to 
kmalloc()/kfree() that already use a 'ring buffer' : More over, the slab 
implementation is designed to have separate 'ring buffer' (one for each cpu), 
so it is probably better than a 'central ring buffer'

Eric
