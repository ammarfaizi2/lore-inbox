Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWAARsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWAARsQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 12:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWAARsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 12:48:16 -0500
Received: from [202.67.154.148] ([202.67.154.148]:11755 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S932068AbWAARsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 12:48:15 -0500
Message-ID: <43B815CC.3070300@ns666.com>
Date: Sun, 01 Jan 2006 18:47:56 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Night Owl 3.12V
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark v Wolher <trilight@ns666.com>
CC: Jiri Slaby <xslaby@fi.muni.cz>, Sami Farin <7atbggg02@sneakemail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org,
       jesper.juhl@gmail.com, s0348365@sms.ed.ac.uk, rlrevell@joe-job.com
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
References: <200512310027.47757.s0348365@sms.ed.ac.uk> <43B5D3ED.3080504@ns666.com> <200512310051.03603.s0348365@sms.ed.ac.uk> <43B5D6D0.9050601@ns666.com> <43B65DEE.906@ns666.com> <9a8748490512310308g1f529495ic7eab4bd3efec9e4@mail.gmail.com> <43B66E3D.2010900@ns666.com> <9a8748490512310349g10d004c7i856cf3e70be5974@mail.gmail.com> <43B67DB6.2070201@ns666.com> <43B6A14E.1020703@ns666.com> <20051231163414.GE3214@m.safari.iki.fi> <20051231163414.GE3214@m.safari.iki.fi> <43B6B669.6020500@ns666.com> <43B73DEB.4070604@ns666.com> <43B7D3BE.60003@ns666.com> <43B7EB99.8010604@ns666.com>
In-Reply-To: <43B7EB99.8010604@ns666.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark v Wolher wrote:
> Mark v Wolher wrote:
> 
>>Mark v Wolher wrote:
>>
>>
>>>Jiri Slaby wrote:
>>>
>>>
>>>
>>>>>Hi Sami,
>>>>>
>>>>>That caused also a crash, i kept pressing the v key and within 15
>>>>>seconds it crashed, then i saw the crash-info appear in the log and when
>>>>>i clicked on mozilla then it crashed too but without crahs info and
>>>>>system froze totally.
>>>>>
>>>>>Below the crash info:
>>>>>
>>>>>Dec 31 17:38:32 localhost kernel: Unable to handle kernel paging request
>>>>>at virtual address c8111000
>>>>>Dec 31 17:38:32 localhost kernel:  printing eip:
>>>>>Dec 31 17:38:32 localhost kernel: c036037a
>>>>>Dec 31 17:38:32 localhost kernel: *pgd = 21063
>>>>>Dec 31 17:38:32 localhost kernel: *pmd = 21063
>>>>>Dec 31 17:38:32 localhost kernel: *pte = 8111000
>>>>>Dec 31 17:38:32 localhost kernel: Oops: 0002 [#4]
>>>>
>>>>[snip]
>>>>Could you try the attached patch?
>>>>
>>>>--
>>>>diff --git a/drivers/media/video/bttv-risc.c b/drivers/media/video/bttv-risc.c
>>>>--- a/drivers/media/video/bttv-risc.c
>>>>+++ b/drivers/media/video/bttv-risc.c
>>>>@@ -53,7 +53,7 @@ bttv_risc_packed(struct bttv *btv, struc
>>>>	/* estimate risc mem: worst case is one write per page border +
>>>>	   one write per scan line + sync + jump (all 2 dwords) */
>>>>	instructions  = (bpl * lines) / PAGE_SIZE + lines;
>>>>-	instructions += 2;
>>>>+	instructions += 4;
>>>>	if ((rc = btcx_riscmem_alloc(btv->c.pci,risc,instructions*8)) < 0)
>>>>		return rc;
>>>>
>>>>
>>>>
>>>
>>>
>>>
>>>Hi Jiri,
>>>
>>>Tried it but it seems to crash indeed faster, and this time it didn't
>>>leave traces in the log.
>>>
>>>Appreciate your help eitherway !
>>>-
>>
>>
>>
>>Hiya all,
>>
>>First of all happy new year ! :-)
>>
>>
>>I might have discovered something interesting which might be responsible
>>for all those lockups/freezes/crashes !
>>
>>Right now, i'm putting a huge load on the system, disk i/o, swapping
>>high, virusscan, number crushing with ssh-keygen moduli etc ...
>>
>>5 hours passed with this load and no single crash/freeze/lockup happened
>>! Normally with all this load sooner or later something would have
>>happened.
>>
>>What did i do ?
>>
>>I disabled bttv support in the kernel, so no tv for me at this moment.
>>I'm planning to let this run for at least another 5 hours with heavy
>>load and see if still nothing happens...
>>
>>Keeping you informed.
>>
>>Mark
>>
>>
>>
>>
> 
> 
> Still no crashes or irregular things happened ! Will let it go for a few
> more hours. This test is being done with the binary nvidia module loaded
> and bttv disabled. The next test will be nv for X instead of the binary
> module with bttv enabled, if crashes and such start to occur then it's
> very likely that the problem sits in the bttv code.
> 
> 
> 
> 


Okay, here are the test results:


- heavy load + nvidia (binary module) + bttv with grabdisplay = crash
- heavy load + nv (not tainted kernel) + bttv with grabdisplay = crash

- heavy load + nvidia (binary module) + bttv with overlay = OK
- heavy load + nv (not tainted kernel) + bttv with overlay = OK

Adding vmware on top of it will cause the system sooner to freeze/crash
(using grabdisplay)

So what you think guys ?

