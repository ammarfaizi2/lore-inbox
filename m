Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264641AbSIQVyf>; Tue, 17 Sep 2002 17:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264642AbSIQVye>; Tue, 17 Sep 2002 17:54:34 -0400
Received: from packet.digeo.com ([12.110.80.53]:38871 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264641AbSIQVx6>;
	Tue, 17 Sep 2002 17:53:58 -0400
Message-ID: <3D87A59C.410FFE3E@digeo.com>
Date: Tue, 17 Sep 2002 14:58:52 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: manfred@colorfullife.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Info: NAPI performance at "low" loads
References: <3D87A264.8D5F3AD2@digeo.com> <20020917.143947.07361352.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Sep 2002 21:58:52.0581 (UTC) FILETIME=[69135D50:01C25E95]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Andrew Morton <akpm@digeo.com>
>    Date: Tue, 17 Sep 2002 14:45:08 -0700
> 
>    "David S. Miller" wrote:
>    > Well, it is due to the same problems manfred saw initially,
>    > namely just a crappy or buggy NAPI driver implementation. :-)
> 
>    It was due to additional inl()'s and outl()'s in the driver fastpath.
> 
> How many?  Did the implementation cache the register value in a
> software state word or did it read the register each time to write
> the IRQ masking bits back?
> 

Looks like it cached it:

-    outw(SetIntrEnb | (inw(ioaddr + 10) & ~StatsFull), ioaddr + EL3_CMD);
     vp->intr_enable &= ~StatsFull;
+    outw(vp->intr_enable, ioaddr + EL3_CMD);

> It is issues like this that make me say "crappy or buggy NAPI
> implementation"
> 
> Any driver should be able to get the NAPI overhead to max out at
> 2 PIOs per packet.
> 
> And if the performance is really concerning, perhaps add an option to
> use MEM space in the 3c59x driver too, IO instructions are constant
> cost regardless of how fast the PCI bus being used is :-)

Yup.  But deltas are interesting.
