Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWAAStv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWAAStv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 13:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWAAStv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 13:49:51 -0500
Received: from [202.67.154.148] ([202.67.154.148]:34273 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S932227AbWAAStu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 13:49:50 -0500
Message-ID: <43B8241C.2020305@ns666.com>
Date: Sun, 01 Jan 2006 19:49:00 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Night Owl 3.12V
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jiri Slaby <xslaby@fi.muni.cz>
CC: Sami Farin <7atbggg02@sneakemail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org,
       jesper.juhl@gmail.com, s0348365@sms.ed.ac.uk, rlrevell@joe-job.com,
       mchehab@brturbo.com.br, video4linux-list@redhat.com
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
References: <200512310027.47757.s0348365@sms.ed.ac.uk> <43B5D3ED.3080504@ns666.com> <200512310051.03603.s0348365@sms.ed.ac.uk> <43B5D6D0.9050601@ns666.com> <43B65DEE.906@ns666.com> <9a8748490512310308g1f529495ic7eab4bd3efec9e4@mail.gmail.com> <43B66E3D.2010900@ns666.com> <9a8748490512310349g10d004c7i856cf3e70be5974@mail.gmail.com> <43B67DB6.2070201@ns666.com> <43B6A14E.1020703@ns666.com> <20051231163414.GE3214@m.safari.iki.fi> <20051231163414.GE3214@m.safari.iki.fi> <43B6B669.6020500@ns666.com> <43B73DEB.4070604@ns666.com> <43B7D3BE.60003@ns666.com> <43B7EB99.8010604@ns666.com> <43B7EB99.8010604@ns666.com> <20060101183832.2BE0222AEE7@anxur.fi.muni.cz>
In-Reply-To: <20060101183832.2BE0222AEE7@anxur.fi.muni.cz>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Mark v Wolher wrote:
> 
>>>Still no crashes or irregular things happened ! Will let it go for a few
>>>more hours. This test is being done with the binary nvidia module loaded
>>>and bttv disabled. The next test will be nv for X instead of the binary
>>>module with bttv enabled, if crashes and such start to occur then it's
>>>very likely that the problem sits in the bttv code.
>>
>>
>>Okay, here are the test results:
>>
>>
>>- heavy load + nvidia (binary module) + bttv with grabdisplay = crash
>>- heavy load + nv (not tainted kernel) + bttv with grabdisplay = crash
>>
>>- heavy load + nvidia (binary module) + bttv with overlay = OK
>>- heavy load + nv (not tainted kernel) + bttv with overlay = OK
>>
>>Adding vmware on top of it will cause the system sooner to freeze/crash
>>(using grabdisplay)
>>
>>So what you think guys ?
> 
> Hi,
> we still think that there is a problem in bttv_risc_packed in computing
> estimated size. My patch was bad, I see it now, but still don't understand, how
> it is computed and how it should be:
>         instructions  = (bpl * lines) / PAGE_SIZE + lines;
>         instructions += 2;
> and here it crashes (the first line, the (*rp)) -- actually after while loop.
> 	*(rp++)=cpu_to_le32(BT848_RISC_WRITE|BT848_RISC_EOL|todo);
> 	*(rp++)=cpu_to_le32(sg_dma_address(sg));
> So, Mauro (or somebody from list), have you any idea, what could be wrong?  
> 
> thanks,

Well, i'd like to help in any way i can, but i'm not really a programmer :(

It seems also that xawtv on nvidia cards (using either nvidia binary
module or nv), at least, somehow doesn't know how to use the hardware to
scale the image in overlay mode. So if you use tvtime which i just
installed and running it is now fullscreen in overlay mode using the
card hardware (quite technical stuff so i'm not sure what else to say).

But back to grabdisplay, this causes the freezes/crashes, especially
under heavy load it'll happen very quick. It seems maybe that other
hardware combinations maybe do not suffer quickly from these things or
ppl with other videocards maybe (?)

It seems to be a combination of factors which might lead to these
issue's, maybe some bug in the bttv code, combined with nvidia cards for
example and xawtv using grabdisplay causes the freezes/crashes.

I'm now currently using tvtime instead of xawtv, overlay mode (i hope),
fullscreen which is basically why i had to use grabdisplay with xawtv in
the first place. I'm putting now alot of load on the system and hope
this is the solution (for now) ...










