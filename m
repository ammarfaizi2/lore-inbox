Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317413AbSFMCZg>; Wed, 12 Jun 2002 22:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317414AbSFMCZf>; Wed, 12 Jun 2002 22:25:35 -0400
Received: from dsl093-054-208.blt1.dsl.speakeasy.net ([66.93.54.208]:10480
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S317413AbSFMCZd>; Wed, 12 Jun 2002 22:25:33 -0400
Date: Wed, 12 Jun 2002 22:25:22 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
X-X-Sender: <becker@presario>
To: "David S. Miller" <davem@redhat.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-mips@oss.sgi.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: NAPI for eepro100
In-Reply-To: <20020612.163344.31410429.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0206122219100.1390-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002, David S. Miller wrote:
>    From: Jeff Garzik <jgarzik@mandrakesoft.com>
>    Oh crap, you're right...   eepro100 in general does funky stuff with the
>    way packets are handled, mainly due to the need to issue commands to the
>    NIC engine instead of the normal per-descriptor owner bit way of doing
>    things.

The eepro100 has a unique design in many different aspects.

> The question is, do the descriptor bits have to live right before
> the RX packet data buffer or can other schemes be used?

With the current driver structure, yes, the descriptor words must be
immediately before the packet data.  You can use other Rx and Tx
structures/modes to avoid this, but they use less efficient memory access.
For instance, the current Tx structure allows transmitting a packet with
a single PCI burst, rather than multiple transfers.


-- 
Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

