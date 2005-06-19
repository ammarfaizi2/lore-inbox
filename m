Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVFSNFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVFSNFr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 09:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVFSNFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 09:05:47 -0400
Received: from [62.206.217.67] ([62.206.217.67]:53647 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262149AbVFSNFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 09:05:37 -0400
Message-ID: <42B56D9B.9070401@trash.net>
Date: Sun, 19 Jun 2005 15:05:31 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Santiago Garcia Mantinan <netfilter-devel@manty.net>
CC: Chris Rankin <rankincj@yahoo.com>, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org, ebtables-devel@lists.sourceforge.net
Subject: Re: 2.6.12: connection tracking broken?
References: <20050618124359.39052.qmail@web52901.mail.yahoo.com>	<20050618192541.GA27439@pul.manty.net> <20050618221216.GB3182@pul.manty.net>
In-Reply-To: <20050618221216.GB3182@pul.manty.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Santiago Garcia Mantinan wrote:
>>I have sent this right now to the bridge list, I'm copying it here so that
>>more info is available about this bug.
> 
> 
> I have selected patches from 2.6.12 that I thought could be related to this
> issue, and I have finaly identified this patch...
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=b31e5b1bb53b99dfd5e890aa07e943aff114ae1c
> 
> as the patch causing the problem, I have reversed it on my kernel tree and
> now the firewall is working again.
> 
> I have not really looked at what the patch does and how it does that, I have
> just identified it as the one causing the break of this connection tracking
> relating to the bridges.

The patch drops the conntrack reference when a packet leaves IP to avoid
problems with module unload because of indefinitely queued packets.
The bridge-netfilter code defers calling of some NF_IP_* hooks to the
bridge layer, when the conntrack reference is already gone, so the entry
is neither confirmed (enters the hashtable) nor available for use by
matches or targets. Reverting the patch is not a good option, I'll look
into other possiblities.

Regards
Patrick
