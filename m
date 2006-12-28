Return-Path: <linux-kernel-owner+w=401wt.eu-S1754902AbWL1SNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902AbWL1SNP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 13:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754909AbWL1SNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 13:13:15 -0500
Received: from mail.us.es ([193.147.175.20]:45764 "EHLO us.es"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754902AbWL1SNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 13:13:14 -0500
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Dec 2006 13:13:14 EST
Message-ID: <459409AE.9070402@netfilter.org>
Date: Thu, 28 Dec 2006 19:15:10 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Netfilter Developer Mailing List 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kaber@trash.net
Subject: Re: skb->h not initialized
References: <Pine.LNX.4.61.0612281733550.23545@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0612281733550.23545@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> while writing a netfilter match module I found that, when run,
> skb->h.th is not set to the TCP header (it is assured that the packet 
> _is_ TCP), as this printk shows me:
> 
> skb: h.th=cb5bc4dc nh.iph=cb5bc4dc mac.raw=cb5bc4ce head=cb5bc400 
> data=cb5bc4dc tail=cb5bc510 end=cb5bc580
> 
> Is it intended that skb->h.th is not set to skb->data + length of ip 
> header (skb->data+protoff as far as netfilter matches are concerned)?

The netfilter hooks are placed in the network layer, therefore skb->h.th
is not set in the input path since the packet did not reach the
transport layer yet (prerouting/input), but it is set in the output path
because it already passed by the transport layer (output/postrouting).

BTW, I'm unsure that this can be of interest in the linux-kernel list,
please there's no need to cc everyone. Use netfilter or linux-net
instead next time.

-- 
The dawn of the fourth age of Linux firewalling is coming; a time of
great struggle and heroic deeds -- J.Kadlecsik got inspired by J.Morris
