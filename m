Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136590AbREGSbI>; Mon, 7 May 2001 14:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136577AbREGSa6>; Mon, 7 May 2001 14:30:58 -0400
Received: from mean.netppl.fi ([195.242.208.16]:51728 "EHLO mean.netppl.fi")
	by vger.kernel.org with ESMTP id <S136581AbREGSau>;
	Mon, 7 May 2001 14:30:50 -0400
Date: Mon, 7 May 2001 21:30:48 +0300
From: Pekka Pietikainen <pp@evil.netppl.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: [Question] Explanation of zero-copy networking
Message-ID: <20010507213048.A17014@netppl.fi>
In-Reply-To: <E14wlUi-0003WQ-00@the-village.bc.nu> <Pine.LNX.3.95.1010507121212.4256A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <Pine.LNX.3.95.1010507121212.4256A-100000@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2001 at 12:12:57PM -0400, Richard B. Johnson wrote:
> you can perform network speed tests using "lo", removing the network
> board from the speed test. You will note that the network speed, due
> to software, is over 10 times faster, 30 times on some machines) than
> when the hardware I/O is used. This shows that the network code, alone,
> cannot be improved very much to provide an improvement in throughput.
I'd say more like a factor of 2.

Socket bandwidth using localhost: 141.63 MB/sec
Socket bandwidth using 192.168.9.3: 74.79 MB/sec

(with the boxes being able to do ~= 100MB/s when the receiver CPU/mem
bandwidth isn't limiting things). So I have slow pIII/500 class machines
with fast networking. You could rerun the test with your favourite 
multi-gigabit network and latest 1.7GHz PC and still have a similar
ratio. Being on the bleeding edge isn't easy, and waiting for a few years
for faster hardware isn't a solution for everyone ;)

Zero-copy mostly helps against CPU use (where it'll make your heavily 
loaded server be able to serve a lot more connections), not so much against
bandwidth. The receiver will still run into problems with the copy it has to
do unless you do some very evil tricks like header-splitting+MMU tricks or
run protocols designed to be accelerated in hardware.

Not that zero-copy isn't problem-free. If your bus starts corrupting random
bits there's no way of really noticing it since the NIC happily 
creates a correct TCP checksum based on the corrupt data.
It's not like hardware engineers can be expected to design hardware
that works according to spec :)

Then there's the interrupt problem, which someone will have to solve 
before they start shipping 10gigE NICs that use 1500-byte frames, 850000
interrupts/s without mitigation. Wheeee!!!! 

-- 
Pekka Pietikainen
