Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271236AbTHNWGr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 18:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271276AbTHNWGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 18:06:46 -0400
Received: from [207.175.35.50] ([207.175.35.50]:9848 "EHLO
	alpha.eternal-systems.com") by vger.kernel.org with ESMTP
	id S271236AbTHNWGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 18:06:45 -0400
Message-ID: <3F3C07E2.3000305@eternal-systems.com>
Date: Thu, 14 Aug 2003 15:06:26 -0700
From: Vishwas Raman <vishwas@eternal-systems.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Netfiltering - NF_IP_LOCAL_OUT - how it works???
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am working with the 2.4.20 kernel.

The module I am writing is supposed to intercept all outgoing packets 
passing between the TCP and IP layer. I was trying to use the 
netfiltering mechanism for that purpose.

While initializing the module, I register a NF_IP_LOCAL_OUT hook for the 
outgoing packet and change skb->dst->output to my_ip_output() instead of 
ip_output() in that hook function. After loading the module, I see 
control being transferred to my_ip_output() for all outgoing packets 
which in turn calls ip_output() and everything seems to work well.

The exit function of the module also unregisters the hook that I am using.

The problem is that after I unload the module, which in turn unregisters 
the hook, I have a kernel panic happening each time I use TCP.

The panic occurs at the following point, ip_build_and_send_pkt() in 
ip_output.c where it is trying to call

     NF_HOOK(PF_INET, NF_IP_LOCAL_OUT, skb, NULL, rt->u.dst.dev,
                     output_maybe_reroute);

I thought once the unregistering of the hook is done, it no longer looks 
for that hook function. I have no idea why it is failing. May be I am 
doing something grossly wrong with netfiltering. Anyone who is familiar 
with netfiltering and has registered and unregistered hooks before might 
be able to guide me regarding this.

Any help will be appreciated.

Thanks,

-Vishwas.

