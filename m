Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbVIZTdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbVIZTdm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 15:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbVIZTdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 15:33:42 -0400
Received: from ns1.coraid.com ([65.14.39.133]:38309 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1751383AbVIZTdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 15:33:41 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>,
       Sam Hopkins <sah@coraid.com>
Subject: Re: [PATCH 2.6.14-rc2] aoe [1/2]: explicitly set minimum packet
 length to ETH_ZLEN
References: <87oe6fhj8y.fsf@coraid.com> <87hdc7ept7.fsf@coraid.com>
	<1127757933.27757.32.camel@localhost.localdomain>
From: Ed L Cashin <ecashin@coraid.com>
Date: Mon, 26 Sep 2005 15:09:47 -0400
In-Reply-To: <1127757933.27757.32.camel@localhost.localdomain> (Alan Cox's
 message of "Mon, 26 Sep 2005 19:05:32 +0100")
Message-ID: <87vf0n63yc.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Llu, 2005-09-26 at 12:50 -0400, Ed L Cashin wrote:
>> >  	skb = alloc_skb(len, GFP_ATOMIC);
>> 
>> This change fixes some strange problems observed on a system that was
>> using the e1000 network driver.  Is the network driver supposed to
>> ensure that ethernet packets are up to spec, at least 60 bytes long?
>
> The network driver is supposed to pad frames if the hardware cannot and
> to blank the spare bits. 

Ah ha.

> If it isn't occurring please try and trace down
> the offender.

My colleague Sam observed problems with the e1000 driver in the
2.6.11.4-21.9-smp kernel from Suse 9.3 and also the e1000 driver in
2.6.12-1.1398_FC4smp from Fedora Core 4.  

The problems aren't fully characterized, but AoE ATA read packets
appeared to be getting dropped and/or corrupted.

When using the tg3 driver instead of e1000 the problems went away, and
making the aoe driver alloc_skb with a minimum length of ETH_ZLEN also
made the problems go away.

-- 
  Ed L Cashin <ecashin@coraid.com>

