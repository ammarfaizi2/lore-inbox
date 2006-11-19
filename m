Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933186AbWKSUaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933186AbWKSUaG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933166AbWKSUaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:30:06 -0500
Received: from h155.mvista.com ([63.81.120.155]:58285 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S933188AbWKSUaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:30:04 -0500
Message-ID: <4560BF28.8010406@ru.mvista.com>
Date: Sun, 19 Nov 2006 23:31:36 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
 type IRQ handlers
References: <200611192243.34850.sshtylyov@ru.mvista.com> <1163966437.5826.99.camel@localhost.localdomain> <20061119200650.GA22949@elte.hu> <1163967590.5826.104.camel@localhost.localdomain> <20061119202348.GA27649@elte.hu>
In-Reply-To: <20061119202348.GA27649@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Ingo Molnar wrote:

>>What do you need an ack() for on fasteoi ? On all fasteoi controllers 
>>I have, ack is implicit by obtaining the vector number and all there 
>>is is an eoi...

> it's a compatibility hack only. Threaded handlers are a different type 
> of flow, but often the fasteoi handler is not changed to the threaded 
> handler so i changed it to be a threaded handler too.

   The fasteoi flow seem to only had been used for x86 IOAPIC in the RT patch 
only *before* PPC took to using them in the mainline...

> threaded handlers need a mask() + an ack(), because that's the correct

    Not all of them. This could be customized on type-by-type basis. I.e. we 
could call eoi() instead of ack() for fasteoi chips without having to resort 
to the duplicated ack/eoi handlers.

> model to map them to kernel threads - threaded handlers can be delayed 
> for a long time if something higher-prio is preempting them.
> 
> 	Ingo

WBR, Sergei
