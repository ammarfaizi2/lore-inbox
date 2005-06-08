Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVFHSiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVFHSiD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 14:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVFHSiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 14:38:03 -0400
Received: from stargate.chelsio.com ([64.186.171.138]:30772 "EHLO
	stargate.chelsio.com") by vger.kernel.org with ESMTP
	id S261488AbVFHSh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 14:37:57 -0400
Message-ID: <42A73C5F.7070706@chelsio.com>
Date: Wed, 08 Jun 2005 11:43:43 -0700
From: Scott Bardone <sbardone@chelsio.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Lukas Hejtmanek <xhejtman@mail.muni.cz>,
       Francois Romieu <romieu@fr.zoreil.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.12-rc6-mm1 & Chelsio driver
References: <20050607181300.GL2369@mail.muni.cz> <42A5EC7C.4020202@pobox.com> <20050607185845.GM2369@mail.muni.cz> <42A5F51B.5060909@pobox.com> <20050607193305.GN2369@mail.muni.cz> <20050607200820.GA25546@electric-eye.fr.zoreil.com> <20050607211048.GO2369@mail.muni.cz> <42A655C2.3030406@chelsio.com> <20050608174640.GA14954@infradead.org>
In-Reply-To: <20050608174640.GA14954@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jun 2005 18:35:51.0173 (UTC) FILETIME=[E5694350:01C56C58]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We modify the existing Linux TCP stack to add "hooks" so that our card can 
perform TCP offload and HW based checksum, thus making it possible to see high 
throughput with multiple connections and low CPU utilization.

We add 2 source files to the kernel, toedev.c and offload.c. We also modify 
neighbor.c, tcp.c, tcp_diag.c, tcp_ipv4.c, tcp_timer.c to add functions for our 
TOE capabilities so that the offloaded packet can be sent to our hardware 
(offload) path instead of going through the software (TCP stack) path.

Our processing engine is an ASIC with a HW based TCP stack which processes 
packets with Chelsio's CPL messages (Chelsio Protocol Language). I would not 
consider it a derived work.

-Scott


Christoph Hellwig wrote:
> On Tue, Jun 07, 2005 at 07:19:46PM -0700, Scott Bardone wrote:
> 
>>We currently don't have the TOE API in the Linux kernel so the TOE 
>>functionality does not exist, therefore you can only use the Chelsio 
>>modified 2.6.6 kernel for TOE.
> 
> 
> Care to explain what modifications you do, and whether or not you consider
> your card firmware a derived work of the TCP stack because of them?
> 
