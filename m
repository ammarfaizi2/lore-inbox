Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263633AbUDTSGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbUDTSGT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 14:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUDTSGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 14:06:19 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:18848 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263633AbUDTSGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 14:06:17 -0400
Message-ID: <4085667C.5080001@colorfullife.com>
Date: Tue, 20 Apr 2004 20:05:48 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Jakub Jelinek <jakub@redhat.com>, akpm@osdl.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-user signal pending and message queue limits
References: <20040419212810.GB10956@logos.cnet> <20040419224940.GY31589@devserv.devel.redhat.com> <20040420141319.GB13259@logos.cnet>
In-Reply-To: <20040420141319.GB13259@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>Indeed, it seems more correct to account for something else than "nr of message queues".
>
>Memory occupied sounds better, yeap?
>  
>
I agree, but note that there is one hidden problem:
There can be one notification for each registered message queue. If 
there are more than ~560 queues and one process wants to install 
SIGEV_THREAD notification handlers for all of them, then the netfilter 
code will run against the socket rmem limit and mq_notify will block.
_If_ there are users that do that we'll have to bypass the normal 
sk_rmem_alloc and add an mqueue specific limit.

--
    Manfred


