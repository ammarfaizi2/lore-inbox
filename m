Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317302AbSHVS7i>; Thu, 22 Aug 2002 14:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318154AbSHVS7i>; Thu, 22 Aug 2002 14:59:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:37520 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317302AbSHVS7g>; Thu, 22 Aug 2002 14:59:36 -0400
Message-ID: <3D653543.6000403@us.ibm.com>
Date: Thu, 22 Aug 2002 12:02:27 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020808
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mala Anand <manand@us.ibm.com>
CC: Benjamin LaHaise <bcrl@redhat.com>, alan@lxorguk.ukuu.org.uk,
       Bill Hartner <bhartner@us.ibm.com>, davem@redhat.com,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       lse-tech-admin@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
References: <OF126E7130.D54285DD-ON87256C1C.0077A747@boulder.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mala Anand wrote:
> The third scope would be measuring this patch in a workload environment.
> We measured it in a web serving workload and found that we get 0.7%
> improvement.

First of all, the patch doesn't apply at all against the current 
bitkeeper tree.  I can post the exact one I used if you like.

I tried this under our Specweb99 setup.  Here's a snippet of 
readprofile with, then without the patch:

   8788 __kfree_skb
   8970 mod_timer
   9095 file_read_actor
  10778 alloc_skb
  10905 skb_clone
  11368 e1000_clean_tx_irq
  13595 e1000_intr
  18367 csum_partial_copy_generic
  27848 e1000_xmit_frame
225838 poll_idle
623160 total                                      0.4107

alloc:free ratio: 1.226
(__kfree_skb+alloc_skb)/total = 3.14%

   4535 alloc_skb
   4559 do_tcp_sendpages
   4596 e1000_clean_rx_irq
   4847 dev_queue_xmit
   5020 tcp_clean_rtx_queue
   5155 batch_entropy_store
   5165 kmalloc
   5309 tcp_transmit_skb
   6060 do_schedule
   6138 qdisc_restart
   6235 tcp_v4_rcv
   6393 kfree
   6787 do_gettimeofday
   7089 __d_lookup
   7810 ip_queue_xmit
   8303 skb_clone
   8858 file_read_actor
   8885 mod_timer
   9375 .text.lock.namei
  10267 .text.lock.dec_and_lock
  10936 e1000_clean_tx_irq
  13001 __kfree_skb
  13322 skb_release_data
  13562 e1000_intr
  18099 csum_partial_copy_generic
  27447 e1000_xmit_frame
225023 poll_idle
628695 total                                      0.4143

alloc:free ratio: 0.348
(__kfree_skb+alloc_skb)/total = 2.79%

You can see the entire readprofile here:
http://www.sr71.net/~specweb99/run-specweb-100sec-2400-2.5.31-bk+4-kmap-08-22-2002-11.20.17/
http://www.sr71.net/~specweb99/run-specweb-100sec-2400-2.5.31-bk+4-kmap-mala-08-22-2002-11.44.25/
No, I don't know why I have so much idle time.

-- 
Dave Hansen
haveblue@us.ibm.com

