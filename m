Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263690AbTHVQxg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 12:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbTHVQxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 12:53:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:64896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263690AbTHVQxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 12:53:21 -0400
Date: Fri, 22 Aug 2003 12:55:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Patrick Sodre Carlos <klist@i-a-i.com>
cc: Ben Greear <greearb@candelatech.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Reinjecting IP Packets
In-Reply-To: <1061569442.2060.2.camel@iai68>
Message-ID: <Pine.LNX.4.53.0308221252400.9325@chaos>
References: <1061563295.824.4.camel@iai68>  <3F464177.1020709@candelatech.com>
 <1061569442.2060.2.camel@iai68>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Aug 2003, Patrick Sodre Carlos wrote:

>
>    My mistake... I forgot to mention that the packet will be coming from
> user-space.
>
> Patrick

Then just use raw packets. Find the source of 'ping' and send
packets just like it does...

    ld->icp.net.icmp_id    = ld->ident;
    ld->icp.net.icmp_cksum = 0;
    ld->icp.net.icmp_cksum = chksum(&ld->icp, len);
    if(sendto(ld->s, &ld->icp, len, 0, &ld->where, sizeof(ld->where)) != len)
        perror("ping: sendto");
}


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


