Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317606AbSIIRx0>; Mon, 9 Sep 2002 13:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318249AbSIIRx0>; Mon, 9 Sep 2002 13:53:26 -0400
Received: from chaos.analogic.com ([204.178.40.224]:40834 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317606AbSIIRxZ>; Mon, 9 Sep 2002 13:53:25 -0400
Date: Mon, 9 Sep 2002 14:00:35 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Imran Badr <imran.badr@cavium.com>
cc: "'David S. Miller'" <davem@redhat.com>, phillips@arcor.de,
       linux-kernel@vger.kernel.org
Subject: RE: Calculating kernel logical address ..
In-Reply-To: <019f01c25826$c553f310$9e10a8c0@IMRANPC>
Message-ID: <Pine.LNX.3.95.1020909134937.18141A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2002, Imran Badr wrote:

> 
> The virt_to_bus() macro would work only for kernel logical addresses. I am
> trying to find a portable way to figure out the kernel logical address of a
> user buffer so that I could use virt_to_bus() for DMA. The user address is
> mmap'ed from kmalloc'ed buffer in the mmap() entry of my driver. Now when
> the user wants to send this data to the PCI device, it makes an ioctl call
> and give the user address to the driver. Now driver has to figure out the
> kernel logical address for DMA.
> 
> Thanks,
> Imran.
> 

Well I just read Documentation/DMA-mapping.txt as advised by David
and it seems as though it will no longer be possible to do what
many programmers have been wanting to do, to wit:

(1) In user-code, allocate a buffer.
(2) Lock that buffer into memory.
(3) Call some driver that DMAs data to/from that buffer.

Although I have never done this, I have heard that this is what
screen-cards (X-Servers), and audio boards have been doing. Also,
I'm told my some M$xperts that this is what "Direct-X" does. I
don't know anything about the direct-to/from user DMA, as is obvious,
but if that's being closed-off, there may be a problem that's
just beginning.

For some reason, (claimed performance reasons) user-mode code
has to be able to get data directly from hardware with no
intervening copy operation. I think any claimed advantage goes
away when you look at the overhead necessary for user-mode
code to sleep before, and awaken after, the DMA operation but
often marketing departments make those decisions.

So, is it correct that you cannot DMA to/from a user buffer?

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

