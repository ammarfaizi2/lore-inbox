Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272011AbRH2Q5x>; Wed, 29 Aug 2001 12:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272014AbRH2Q5o>; Wed, 29 Aug 2001 12:57:44 -0400
Received: from mailf.telia.com ([194.22.194.25]:5858 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S272011AbRH2Q5e>;
	Wed, 29 Aug 2001 12:57:34 -0400
Message-Id: <200108291657.f7TGvlw27738@mailf.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Date: Wed, 29 Aug 2001 18:47:54 +0200
X-Mailer: KMail [version 1.3]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010829140706.3fcb735c.skraw@ithnet.com>
In-Reply-To: <20010829140706.3fcb735c.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesdayen den 29 August 2001 14:07, Stephan von Krawczynski wrote:

> Aug 29 13:43:34 admin kernel: __alloc_pages: 2-order allocation failed
> (gfp=0x20/0). Aug 29 13:43:34 admin kernel: pid=1207;
> __alloc_pages(gfp=0x20, order=2, ...) 
> Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] 
> [__get_free_pages+10/24] [<fdcec845>]
> [<fdcec913>] [<fdceb7d7>] [<fdcec0f5>] [<fdcea589>]
> [ip_local_deliver_finish+0/368]
I think this is the okfn parameter to nf_hook_slow below (0/368).
And that skb_linearize(skp, GFP_ATOMIC) is much more likely candidate
especially since it calls kmalloc...

Why does skb_linearize need to be GFP_ATOMIC? Lets see, furter down we have
do_softirq... hmm.. not good to sleep in...

Next question: do we really need to linearize?

Third question: order of the package is 2 => 4096 << 2 = 16k quite big
for a packet... (MRU MTU network settings?)

> [nf_hook_slow+272/404]
> [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
> [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480]
> [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404]
> [ip_rcv+870/944] [ip_rcv_finish+0/480] [net_rx_action+362/628] 
> [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] 
> [sys_ioctl+443/532] [system_call+51/56]

>
> Unfortunately I cannot tell what pid 1207 is, for it is gone when I do a ps
> afterwards.

Change the printout of 'current->pid' to 'current->comm' format '%s'

> This test setup shows vm errors on every 2.4 I tested so far,
> but on various occasions, all 2.4 below 10-pre1 fail during reading /
> writing. All 10-pre-x fail afterwards. If I can provide additional
> information please tell me. I am very willing to test anything you like
> with chances it doesn't corrupt my filesystems ;-) 

No guarantees...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
