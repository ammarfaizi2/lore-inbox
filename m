Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSE1RIa>; Tue, 28 May 2002 13:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316855AbSE1RI3>; Tue, 28 May 2002 13:08:29 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:41724 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316853AbSE1RI2>; Tue, 28 May 2002 13:08:28 -0400
Subject: Re: 8-CPU (SMP) #s for lockfree rtcache
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, paul.mckenney@us.ibm.com, andrea@suse.de
In-Reply-To: <20020528183409.A23001@averell>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 May 2002 19:10:47 +0100
Message-Id: <1022609447.4123.126.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-28 at 17:34, Andi Kleen wrote:
> And gain tons of new atomic_incs and decs everywhere in the process?  
> I would prefer RCU. 

RCU is a great way to make sure people get module unloading *wrong*. It
has to be simple for the driver authors. The odd locked operation on
things like open() of a device file is not a performance issue, not
remotely. 

Lots of people write drivers, many of them not SMP kernel locking gurus
who have time to understand RCU and when they can or cannot sleep, and
what happens if their unload is pre-empted and RCU is in use. The kernel
core has to provide a clean easy interface. The network code is a superb
example of this. All the hard thinking is done outside of the driver, at
least unless you choose to join in that thinking to get the last scraps
of performance.

Alan

