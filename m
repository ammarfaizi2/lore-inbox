Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271799AbRHRIwC>; Sat, 18 Aug 2001 04:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271798AbRHRIvw>; Sat, 18 Aug 2001 04:51:52 -0400
Received: from cmailg6.svr.pol.co.uk ([195.92.195.176]:26700 "EHLO
	cmailg6.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S271797AbRHRIvl>; Sat, 18 Aug 2001 04:51:41 -0400
Message-ID: <3B7E2CA5.50904@humboldt.co.uk>
Date: Sat, 18 Aug 2001 09:51:49 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Nicholas Knight <tegeran@home.com>, linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <Pine.LNX.3.95.1010817152158.4584B-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> We've established no such thing. In fact, you can't properly initialize
> SDRAM memory without writing something to it. 

After all of this theory it was time to do some experiments. I modified 
the BIOS on my current PowerPC system to compare memory against a test 
pattern (I chose 0x31415926 incrementing by 0x27182817) over the address 
range 0x0 to 0x100000. This pattern has approximately 50% 1s and 50% 0s.

On pressing the reset button, I got 100% of bits holding the same value. 
If I turn the power off for 20s, I get approximately 90% of bits holding 
the same value. After a minute, it's dropped to the 50% level, which I 
take as random.

For added fun, I then tried turning off, pulling out the DIMM, plugging 
it into the other slot, and turning back on. 97% of the bits had the 
original value. So one attack we must consider is the attacker removing 
power, ripping the DIMM out, and plugging it into a special DIMM reading 
device.

Your descriptions on how memory is started look very machine specific. 
On mine (Motorola MPC107) I write the number of row bits, column bits, 
and internal banks to the memory controller, along with the CAS latency. 
I then set MEMGO, and the memory controller precharges each bank.
-- 
Adrian Cox   http://www.humboldt.co.uk/

