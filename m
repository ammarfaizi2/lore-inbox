Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVAMXVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVAMXVx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVAMXTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:19:47 -0500
Received: from ns1.coraid.com ([65.14.39.133]:28078 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261823AbVAMXNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:13:38 -0500
To: Andi Kleen <ak@muc.de>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: [BUG] ATA over Ethernet __init calling __exit
References: <20050113000949.A7449@flint.arm.linux.org.uk>
	<20050113085035.GC2815@suse.de> <m1wtuh2kah.fsf@muc.de>
	<87is616oi2.fsf@coraid.com> <20050113215346.GB1504@muc.de>
	<87ekgp567u.fsf@coraid.com> <20050113224832.GA19673@muc.de>
From: Ed L Cashin <ecashin@coraid.com>
Date: Thu, 13 Jan 2005 17:59:09 -0500
Message-ID: <87is613phe.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> On Thu, Jan 13, 2005 at 05:12:21PM -0500, Ed L Cashin wrote:
>
>> It seems rash to make the change now, because there is no need for it.
>
> It would be better to future proof the driver at least a bit.
>
>> 
>> For the skbuffs, we could use a mempool with GFP_NOIO allocation and
>> then skb_get them before the network layer ever sees them.  We already
>> keep track of the packets that we've sent out, so we'll just keep a
>> pointer to the skbuffs.
>
> That won't work because you don't know when the driver is done with it.
>
> There is a callback, but it's already used by socket buffer management

The destructor member of struct sk_buff, right?

> (if you don't use a socket it may be usable) 

You mean a struct sock?  No, we don't use that because we're not IP.
Thanks for the lead.

-- 
  Ed L Cashin <ecashin@coraid.com>

