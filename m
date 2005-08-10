Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbVHJLMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbVHJLMF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 07:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVHJLME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 07:12:04 -0400
Received: from [85.8.12.41] ([85.8.12.41]:39821 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S965070AbVHJLMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 07:12:02 -0400
Message-ID: <42F9E0E1.7060602@drzeus.cx>
Date: Wed, 10 Aug 2005 13:11:29 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-3 (X11/20050806)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 8139cp misses interrupts during resume
References: <42DD3BA1.7010302@drzeus.cx> <42F21BD6.3000807@drzeus.cx>
In-Reply-To: <42F21BD6.3000807@drzeus.cx>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Pierre Ossman wrote:
> 
>>I'm having problem with the interrupt getting killed after suspend with
>>my 8139cp controller. The problem only appears if the cable is connected
>>during resume (before suspend is irrelevant) and the interface is down.
>>
>>Both suspend-to-disk and suspend-to-ram exhibit the error. dmesg from
>>suspend-to-ram included.
>>
>>I find it a bit strange that 8139cp's interrupt handler isn't included
>>when it dumps the handlers. Could this be related to the problem?
>>
> 
> 
> Anyone familiar with this driver that can give me some pointers on what
> to look for? I'd prefer not to have to learn how the entire thing works
> just to fix one bug. :)
> 

I've gotten a bit close now at least. The problem is that the IRQ
handler isn't registered until the device is opened (up:ed) but the
hardware triggers interrupt even in a closed state. So either the
hardware needs to be silenced or the handler needs to be installed earlier.

Rgds
Pierre
