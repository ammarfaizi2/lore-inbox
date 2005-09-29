Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbVI2Wcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVI2Wcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbVI2Wcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:32:41 -0400
Received: from ns1.coraid.com ([65.14.39.133]:60507 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932296AbVI2Wck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:32:40 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.14-rc2] aoe [1/3]: explicitly set minimum packet
 length to ETH_ZLEN
References: <87wtkzbz5z.fsf@coraid.com>
	<1128032491.9290.1.camel@localhost.localdomain>
From: Ed L Cashin <ecashin@coraid.com>
Date: Thu, 29 Sep 2005 18:31:02 -0400
In-Reply-To: <1128032491.9290.1.camel@localhost.localdomain> (Alan Cox's
 message of "Thu, 29 Sep 2005 23:21:31 +0100")
Message-ID: <874q83tsk9.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Iau, 2005-09-29 at 12:45 -0400, Ed L. Cashin wrote:
>> Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
>> 
>> Explicitly set the minimum packet length to ETH_ZLEN and zero the
>> packet data.
>
> You still haven't explained why this is neccessary. The drivers should
> be doing it for you.

I did respond to your earlier request post, but I forgot to make sure
you were in the CC list, sorry.  I've quoted my response below.

Ed L Cashin <ecashin@coraid.com> writes:

> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
...
>> The network driver is supposed to pad frames if the hardware cannot and
>> to blank the spare bits. 
>
> Ah ha.
>
>> If it isn't occurring please try and trace down
>> the offender.
>
> My colleague Sam observed problems with the e1000 driver in the
> 2.6.11.4-21.9-smp kernel from Suse 9.3 and also the e1000 driver in
> 2.6.12-1.1398_FC4smp from Fedora Core 4.  
>
> The problems aren't fully characterized, but AoE ATA read packets
> appeared to be getting dropped and/or corrupted.
>
> When using the tg3 driver instead of e1000 the problems went away, and
> making the aoe driver alloc_skb with a minimum length of ETH_ZLEN also
> made the problems go away.

We suspect that the e1000 driver is misbehaving when given short
packets, but we have not had time to pinpoint what part of the e1000
driver is involved or what the specific problem is.

-- 
  Ed L Cashin <ecashin@coraid.com>

