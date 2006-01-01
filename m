Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWAASjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWAASjy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 13:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWAASjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 13:39:54 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:28071 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932187AbWAASjx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 13:39:53 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sun,  1 Jan 2006 19:38:33 +0100
In-reply-to: <43B815CC.3070300@ns666.com>
To: Mark v Wolher <trilight@ns666.com>
Cc: Jiri Slaby <xslaby@fi.muni.cz>, Sami Farin <7atbggg02@sneakemail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org,
       jesper.juhl@gmail.com, s0348365@sms.ed.ac.uk, rlrevell@joe-job.com,
       mchehab@brturbo.com.br, video4linux-list@redhat.com
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
References: <200512310027.47757.s0348365@sms.ed.ac.uk> <43B5D3ED.3080504@ns666.com> <200512310051.03603.s0348365@sms.ed.ac.uk> <43B5D6D0.9050601@ns666.com> <43B65DEE.906@ns666.com> <9a8748490512310308g1f529495ic7eab4bd3efec9e4@mail.gmail.com> <43B66E3D.2010900@ns666.com> <9a8748490512310349g10d004c7i856cf3e70be5974@mail.gmail.com> <43B67DB6.2070201@ns666.com> <43B6A14E.1020703@ns666.com> <20051231163414.GE3214@m.safari.iki.fi> <20051231163414.GE3214@m.safari.iki.fi> <43B6B669.6020500@ns666.com> <43B73DEB.4070604@ns666.com> <43B7D3BE.60003@ns666.com> <43B7EB99.8010604@ns666.com> <43B7EB99.8010604@ns666.com>
Message-Id: <20060101183832.2BE0222AEE7@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark v Wolher wrote:
>> Still no crashes or irregular things happened ! Will let it go for a few
>> more hours. This test is being done with the binary nvidia module loaded
>> and bttv disabled. The next test will be nv for X instead of the binary
>> module with bttv enabled, if crashes and such start to occur then it's
>> very likely that the problem sits in the bttv code.
>
>
>Okay, here are the test results:
>
>
>- heavy load + nvidia (binary module) + bttv with grabdisplay = crash
>- heavy load + nv (not tainted kernel) + bttv with grabdisplay = crash
>
>- heavy load + nvidia (binary module) + bttv with overlay = OK
>- heavy load + nv (not tainted kernel) + bttv with overlay = OK
>
>Adding vmware on top of it will cause the system sooner to freeze/crash
>(using grabdisplay)
>
>So what you think guys ?
Hi,
we still think that there is a problem in bttv_risc_packed in computing
estimated size. My patch was bad, I see it now, but still don't understand, how
it is computed and how it should be:
        instructions  = (bpl * lines) / PAGE_SIZE + lines;
        instructions += 2;
and here it crashes (the first line, the (*rp)) -- actually after while loop.
	*(rp++)=cpu_to_le32(BT848_RISC_WRITE|BT848_RISC_EOL|todo);
	*(rp++)=cpu_to_le32(sg_dma_address(sg));
So, Mauro (or somebody from list), have you any idea, what could be wrong?  

thanks,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
