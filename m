Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261242AbREMPzH>; Sun, 13 May 2001 11:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261289AbREMPy5>; Sun, 13 May 2001 11:54:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26668 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S261242AbREMPyo>; Sun, 13 May 2001 11:54:44 -0400
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        alexander.eichhorn@rz.tu-ilmenau.de, linux-kernel@vger.kernel.org
Subject: Re: [Question] Explanation of zero-copy networking
In-Reply-To: <E14wlUi-0003WQ-00@the-village.bc.nu> <Pine.LNX.3.95.1010507121212.4256A-100000@chaos.analogic.com> <20010508091811.C17720@pcep-jamie.cern.ch>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 May 2001 09:13:36 -0600
In-Reply-To: Jamie Lokier's message of "Tue, 8 May 2001 09:18:11 +0200"
Message-ID: <m1k83qlfmn.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <lk@tantalophile.demon.co.uk> writes:

> Richard B. Johnson wrote:
> > However, PCI to memory copying runs at about 300 megabytes per
> > second on modern PCs and memory to memory copying runs at over 1,000
> > megabytes per second. In the future, these speeds will increase.
> 
> That would be "big expensive modern PCs" then.  Our clusters of 700MHz
> boxes are strictly limited to 132 megabytes per second over PCI...

300 Megabytes per second is definitely an odd number for a PCI bus.
But 132 Megabytes per second is actually high, the continuous burst
speeds are:
32bit 33Mhz: 33*1000*1000*32/(1024*1024*8) = 125.8 Megabytes/second
64bit 33Mhz: 33*1000*1000*64/(1024*1024*8) = 251.7 Megabytes/second
32bit 66Mhz: 66*1000*1000*32/(1024*1024*8) = 251.7 Megabytes/second
64bit 66Mhz: 66*1000*1000*64/(1024*1024*8) = 503.4 Megabytes/second

The possibility of getting a continuous bursts is actually low, if
nothing else you have an interrupt acknowledgement 100 times per
second.  But if you are pushing the bus it should deliver close to
it's burst potential.  But the ISA traffic doing subtractive decode
can be nasty because you get 4 PCI cycles before you even get
acknowledgement from the PCI/ISA bridge that you there is something to
transfer to.   

Eric
