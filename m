Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUAIKQH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 05:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266489AbUAIKQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 05:16:07 -0500
Received: from mail1.drkw.com ([62.129.121.35]:2298 "EHLO mail1.drkw.com")
	by vger.kernel.org with ESMTP id S266488AbUAIKQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 05:16:00 -0500
From: "Heilmann, Oliver" <Oliver.Heilmann@drkw.com>
To: linux-kernel@vger.kernel.org
Subject: Re: SIS 648FX AGP fixed - but clarification needed
In-Reply-To: <20040108155753.GB20616@redhat.com>
References: <1073563512.502.66.camel@cobra> 
    <20040108155753.GB20616@redhat.com>
Content-Type: text/plain
Message-Id: <1073643356.501.1.camel@cobra>
Mime-Version: 1.0
Date: Fri, 09 Jan 2004 10:15:56 +0000
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: Oliver.Heilmann@drkw.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-08 at 15:57, Dave Jones wrote:
> On Thu, Jan 08, 2004 at 12:05:12PM +0000, Heilmann, Oliver wrote:
> 
>  > 1. According to sis_agp_device_ids the 648 chipset is supported. Does
>  > this mean that the "plain" 648 is actually supported and my "FX"
>  > iteration is so fundamentally different (even thought is has the same
>  > device id).
> 
> Some of the agpgart submissions go along the lines of..
> - agpgart complains when I load it.
> - running with try_unsupported makes the error go away
> - ID of chipset gets added.
> 
> In quite a few cases in the past, no, or little actual testing to see
> whether the device works correctly, or doesn't corrupt mappings through
> the GART.  In some cases, folks actually have thought everything was working
> fine, and then later found out they had misconfigured their X setup, and
> were running unaccelerated software GL.
> 
> These days when recieving ID updates, I usually ask folks
> to at least give it a run through testgart to make sure.
> 
So before I change the 648 setup I'd still better check with someone
who's got the plain version?

> It's not the be all and end all of test apps, but it catches the really
> stupid cases.
> 
>  > 2. Once the agpEnable bit is set in the bridge's cmd register the config
>  > space of the master is completely screwed up for a while. Trying to
>  > configure/enable the master during that period mostly crashes the
>  > system. Waiting does the trick. (Annoyingly, simply waiting for the
>  > master to become readable again is not good enough, one still needs to
>  > wait longer for things to become stable). None of the other chipsets
>  > seem to need this. Can anybody explain? Perhaps I missed something? If
>  > there is no other way and I do have to stick with the delay, then I
>  > suppose it would not be a good idea to polute the generic agp_enable
>  > with it?!
>  
> This sounds very odd. How long a delay are we talking here?
~5ms. At around 4ms it sometimes doesn't die before a few windows have
been opened (mutilated requests?).

> It sounds to me like we should be waiting on some other event.
Hmm, like what? Any idea what I could check/wait for?

> I'll see if I can dig out the 648 datasheet later.
Thanks.
> 
> I'd rather not add it to agp_enable. Better would be to add a sis specific
> .enable function (which mostly just calls the agp_generic_enable() function
> and does the wait), so the other drivers don't need to worry about this.
> 
> I'd rather get to the bottom of why the delay is needed though.
> 
> 		Dave

Here's some additional info:

The bridge claims AGP V3.5, master says 3.0
Interestingly, the bridge's status register has the isoch bit OFF.
bridge:
Capabilities: [c0] AGP version 3.5  
Status: RQ=32 Iso- ArqSz=2 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW-
AGP3+ Rate=x4,x8
Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8

card:
Capabilities: [58] AGP version 3.0
Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit-
FW+ AGP3+ Rate=x4,x8
Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8

The machine is basically a notebook with a desktop chipset/cpu(P4 3.2).
The gpu is not on board but on a separate module connected through what
looks to me like a non-standard connector.

Thanks,

Oliver



--------------------------------------------------------------------------------
The information contained herein is confidential and is intended solely for the
addressee. Access by any other party is unauthorised without the express
written permission of the sender. If you are not the intended recipient, please
contact the sender either via the company switchboard on +44 (0)20 7623 8000, or
via e-mail return. If you have received this e-mail in error or wish to read our
e-mail disclaimer statement and monitoring policy, please refer to 
http://www.drkw.com/disc/email/ or contact the sender.
--------------------------------------------------------------------------------

