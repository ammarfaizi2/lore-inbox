Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271956AbRIINPg>; Sun, 9 Sep 2001 09:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271257AbRIINP0>; Sun, 9 Sep 2001 09:15:26 -0400
Received: from ns.ithnet.com ([217.64.64.10]:11020 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271956AbRIINPR>;
	Sun, 9 Sep 2001 09:15:17 -0400
Date: Sun, 9 Sep 2001 15:15:09 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mcelrath@draal.physics.wisc.edu, linux-kernel@vger.kernel.org
Subject: Re: "Cached" grows and grows and grows...
Message-Id: <20010909151509.6a0c7d68.skraw@ithnet.com>
In-Reply-To: <E15flgs-0004BN-00@the-village.bc.nu>
In-Reply-To: <20010908184758.696bb9d1.skraw@ithnet.com>
	<E15flgs-0004BN-00@the-village.bc.nu>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Sep 2001 18:14:46 +0100 (BST) Alan Cox <alan@lxorguk.ukuu.org.uk>
wrote:

> > //      printk(KERN_ERR "__alloc_pages: %lu-order allocation failed.\n",
order)
> >         return NULL;
> > 
> > If there is no printk, you will obviously not notice the problem. You can
bet
> > your car on not "seeing the problem".
> 
> That printk is commented out because its pointless and bogus noise. It just
> causes confused bug reporting. The stuff that matters is cache sizes
> shrinking back when we need memory not slowly eating the computer alive.

Hm, I guess I had to find out, that you've the same problem than linus' tree,
only on "the other side of the street". This is a meminfo from a 2.4.9-ac9
kernel working one day, and then going crazy on too low mem. "Going crazy" here
means that kswapd took virtually over the cpu(s) and swapped the hell out the
machine:
(BTW you can see that swap did not really grow, but seems to get in and out
permanently)

        total:    used:    free:  shared: buffers:  cached:
Mem:  921706496 894324736 27381760     4096 783917056 29102080
Swap: 271392768 13185024 258207744
MemTotal:       900104 kB
MemFree:         26740 kB
MemShared:           4 kB
Buffers:        765544 kB
Cached:          15744 kB
SwapCached:      12676 kB
Active:         502132 kB
Inact_dirty:    291836 kB
Inact_clean:         0 kB
Inact_target:       80 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       900104 kB
LowFree:         26740 kB
SwapTotal:      265032 kB
SwapFree:       252156 kB

You are right: page cache shrunk.
You are wrong: it does _not_ work, because now buffers increased and obviously
cannot be shrunk to allow "normal" applications to run. I could not even
shutdown the machine correctly. It looks like a deadlock in vm to me.

I switched back to Linus' tree, because it does have problems, but is not dead
within one day.

Regards,
Stephan

