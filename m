Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284773AbRLEWni>; Wed, 5 Dec 2001 17:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284781AbRLEWn2>; Wed, 5 Dec 2001 17:43:28 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:12207 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284773AbRLEWnO>; Wed, 5 Dec 2001 17:43:14 -0500
Message-ID: <3C0EA2FA.7010008@redhat.com>
Date: Wed, 05 Dec 2001 17:43:06 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com> <3C0D9456.6090106@optonline.net> <3C0DA1CC.1070408@redhat.com> <3C0DAD26.1020906@optonline.net> <3C0DAF35.50008@redhat.com> <3C0E7DCB.6050600@optonline.net> <3C0E7DFB.2030400@optonline.net> <3C0E7F1C.4060603@redhat.com> <3C0E8DBF.5010000@optonline.net> <3C0E90B2.1030601@redhat.com> <3C0E935F.3070505@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Bryant wrote:

>
> Actually, I think I *may* have found the problem, in update ptr, it 
> should look like this: going to test in a moment
> 
>        /* error handling and process wake up for DAC */
>        if (dmabuf->enable == DAC_RUNNING) {
>                /* update hardware pointer */
>                hwptr = i810_get_dma_addr(state, 0);
>                diff = hwptr - dmabuf->hwptr;
>                if (hwptr < dmabuf->hwptr)
>                        diff += dmabuf->dmasize;


This is mathematically equivelant to what was already there.


> #if defined(DEBUG_INTERRUPTS) || defined(DEBUG_MMAP)
>                printk("DAC HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
> #endif
> 
> reason: hwptr hits 65536 which is indistinguishable from 0 in mod 
> arithmetic


The mod doesn't happen until all the rest is already done, and then it's 
just cancelling out the dmabuf->dmasize portion (instead of using an if 
statement to do the same thing).


> also, I ran your other DEBUG_MMAP patch and the news is that count just 
> sits at 65536 ad nauseum.


Yes, but if I have the stuff leading up to it sitting at 65536 forever I 
might be able to diagnose the problem (without installing quake myself 
and taking the time to set it up anyway) ;-)





-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

