Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422679AbWJOSLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422679AbWJOSLE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 14:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422681AbWJOSLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 14:11:04 -0400
Received: from web50601.mail.yahoo.com ([206.190.38.88]:2989 "HELO
	web50601.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1422679AbWJOSLB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 14:11:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=SIWQVTn7ZQTdXsi5LF0w3F2SEIcIbkG96fF9IoAmdT/x/gxZHMEeOWUKZ+NRWERIwZql8hGpRiq3939Le9/ztvDlmhbcoz9SsQmSYXo3KcCsS/5PCyWTzcqW+eSgVZ1J9aWA87ev13bz2P9fZd+PuSSrdqtFifVpU+YZgJcd+RU=  ;
Message-ID: <20061015181059.8920.qmail@web50601.mail.yahoo.com>
Date: Sun, 15 Oct 2006 11:10:59 -0700 (PDT)
From: Joan Raventos <jraventos@yahoo.com>
Subject: Re: poll problem with PF_PACKET when using PACKET_RX_RING
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org, Linux Netdev List <netdev@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

Thx for your prompt reply! Plz see some comments inline.

>> 
>> Is this a bug in PF_PACKET? Should the socket queue be
>> emptied by packet_set_ring (called via setsockopt when
>> PACKET_RX_RING is used) so the above cannot happen?
>> Should the user-space app drain the socket queue with
>> recvfrom prior to (4) -quite unlikely in practice-?


> I guess the best way is not to bind the socket before having
> completed setup. We could still flush the queue to make life
> easier for userspace, not sure about that ..

Even w/o bind, packet_create is doing a dev_add_pack, which I think will make pkts arrive to that socket (ie. in netif_receive_skb one can see the loops over the rcu for both ptype_all and type-specific which seem match whenever !ptype->dev || ptype->dev==skb->dev).

Also the packet_mmap.txt doc does not mention bind, which probably is more a mechanism to closely specify a dev than to signal socket readiness.

Salu2,
J.




