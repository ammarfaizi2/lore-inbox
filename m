Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUBYRTv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 12:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbUBYRTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 12:19:51 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:58798 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261418AbUBYRTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 12:19:47 -0500
Message-ID: <403CD8E2.2060102@colorfullife.com>
Date: Wed, 25 Feb 2004 18:18:26 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "David S. Miller" <davem@redhat.com>, dsw@gelato.unsw.edu.au,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.3 Slab corruption: errors are triggered when memory
 exceeds 2.5GB (correction)
References: <403AF155.1080305@colorfullife.com>	<20040223225659.4c58c880.akpm@osdl.org>	<403B8C78.2020606@colorfullife.com>	<20040225005804.GE18070@cse.unsw.EDU.AU>	<403C3F04.20601@colorfullife.com>	<20040224230318.19a0e6b9.davem@redhat.com> <20040224232205.4fe87448.akpm@osdl.org>
In-Reply-To: <20040224232205.4fe87448.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Ah-hah.
>
>This should find it:
>  
>
I think we should first check that skb->dataref is really the problem: 
what about adding an unused field before the dataref? Something like

struct skb_shared_info {
+	int		unused;
 	atomic_t	dataref;
	int		debug;

If the dataref decrease causes the problem, then the affected offset should change to 0x628.

--
	Manfred


