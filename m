Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317341AbSHVU4a>; Thu, 22 Aug 2002 16:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317349AbSHVU4a>; Thu, 22 Aug 2002 16:56:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:49629 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317341AbSHVU42>; Thu, 22 Aug 2002 16:56:28 -0400
Message-ID: <1030049891.3d655063b662f@imap.linux.ibm.com>
Date: Thu, 22 Aug 2002 13:58:11 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
To: ibm-specweb99@linux.ibm.com, Dave Hansen <haveblue@us.ibm.com>
Cc: Mala Anand <manand@us.ibm.com>, Benjamin LaHaise <bcrl@redhat.com>,
       alan@lxorguk.ukuu.org.uk, Bill Hartner <bhartner@us.ibm.com>,
       davem@redhat.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, lse-tech-admin@lists.sourceforge.net
Subject: Re: [Ibm-specweb99] Re: [Lse-tech] Re: (RFC): SKB Initialization
References: <OF126E7130.D54285DD-ON87256C1C.0077A747@boulder.ibm.com> <3D653543.6000403@us.ibm.com>
In-Reply-To: <3D653543.6000403@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 9.47.18.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave, 

Just FYI, the profile of the second link (*mala*) is the
one youre quoting first in this msg, and the profile of
the first link (presumably prior to mala's patch) is the
one you've quoted second in the mail. Hopefully, the links
are just misnamed, and the profiles listed before/after are
the right ones here in the mail. :).

It would be useful to know how consistent these profiles are,
and the variance youre seeing with these runs, before reaching any 
conclusions..

For instance, skb_release_data(), which wasnt altered,
increased from 7259 to 13,322, which is on par with the
kind of gain expected by the patch in the other functions.
So is this just normal variance, or a result of the patch?

Looking at most of the Specweb profiles and networking
in general, and because so much here depends on which cpu
code gets run on, and cache behaviour, I'd say youre going
to get a lot of variance...

thanks,
Nivedita

Quoting Dave Hansen <haveblue@us.ibm.com>:

[snip] 

> First of all, the patch doesn't apply at all against the current 
> bitkeeper tree.  I can post the exact one I used if you like.
> 
> I tried this under our Specweb99 setup.  Here's a snippet of 
> readprofile with, then without the patch:
> 
>    8788 __kfree_skb
>    8970 mod_timer
>    9095 file_read_actor
>   10778 alloc_skb
>   10905 skb_clone
>   11368 e1000_clean_tx_irq
>   13595 e1000_intr
>   18367 csum_partial_copy_generic
>   27848 e1000_xmit_frame
> 225838 poll_idle
> 623160 total                                      0.4107
> 
> alloc:free ratio: 1.226
> (__kfree_skb+alloc_skb)/total = 3.14%
> 
>    4535 alloc_skb
>    4559 do_tcp_sendpages
>    4596 e1000_clean_rx_irq
>    4847 dev_queue_xmit
>    5020 tcp_clean_rtx_queue
>    5155 batch_entropy_store
>    5165 kmalloc
>    5309 tcp_transmit_skb
>    6060 do_schedule
>    6138 qdisc_restart
>    6235 tcp_v4_rcv
>    6393 kfree
>    6787 do_gettimeofday
>    7089 __d_lookup
>    7810 ip_queue_xmit
>    8303 skb_clone
>    8858 file_read_actor
>    8885 mod_timer
>    9375 .text.lock.namei
>   10267 .text.lock.dec_and_lock
>   10936 e1000_clean_tx_irq
>   13001 __kfree_skb
>   13322 skb_release_data
>   13562 e1000_intr
>   18099 csum_partial_copy_generic
>   27447 e1000_xmit_frame
> 225023 poll_idle
> 628695 total                                      0.4143
> 
> alloc:free ratio: 0.348
> (__kfree_skb+alloc_skb)/total = 2.79%
> 
> You can see the entire readprofile here:
> 
http://www.sr71.net/~specweb99/run-specweb-100sec-2400-2.5.31-bk+4-kmap
-08-22-2002-11.20.17/
> 
http://www.sr71.net/~specweb99/run-specweb-100sec-2400-2.5.31-bk+4-kmap
-mala-08-22-2002-11.44.25/
> No, I don't know why I have so much idle time.
> 
> -- 
> Dave Hansen
> haveblue@us.ibm.com
> 
> _______________________________________________
> ibm-specweb99 mailing list
> ibm-specweb99@linux.ibm.com
> http://ltc.linux.ibm.com/mailman/listinfo/ibm-specweb99
> 
> 




