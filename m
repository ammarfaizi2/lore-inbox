Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWGaEYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWGaEYe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWGaEYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:24:34 -0400
Received: from stinky.trash.net ([213.144.137.162]:18571 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751462AbWGaEYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:24:33 -0400
Message-ID: <44CD85FF.9010607@trash.net>
Date: Mon, 31 Jul 2006 06:24:31 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Coulson <david@davidcoulson.net>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: BUG: warning at net/core/dev.c:1171/skb_checksum_help() 2.6.18-rc3
References: <44CD8415.2020403@davidcoulson.net>
In-Reply-To: <44CD8415.2020403@davidcoulson.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Coulson wrote:
> This machine has four NICs running the e1000 kernel module. Other than
> the BUG() messages, it seems to be running fine. I was running 2.6.15.4
> without any issues on the same hardware, although I noticed the e1000
> has been updated (and I went for rc3 since I was hitting the panic in -rc2)
> 
> Now, I'm not sure if it also has anything to do with this message:
> 
> NAT: no longer support implicit source local NAT
> NAT: packet src 10.1.1.1 -> dst 207.166.203.131

No, this in unrelated. This message tries to tell you that the old
behaviour of changing the source address implicitly to the source
address routing would use for a DNATed connection is no longer done.
This behaviour changed in 2.6.11, so if everything worked in 2.6.15,
you should be fine.

> Any suggestions as to how to go about debugging this?
> 
> BUG: warning at net/core/dev.c:1171/skb_checksum_help()
>  [<c02e0412>] skb_checksum_help+0x4d/0xf0
>  [<c034e4d3>] ip_nat_fn+0x4e/0x19e

This is a known problem with NAT and HW checksum and will probably get
fixed in 2.6.19. The message is just a warning, everything should work
fine.

