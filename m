Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbVI1XEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbVI1XEn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVI1XEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:04:43 -0400
Received: from mail.dvmed.net ([216.237.124.58]:48102 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750905AbVI1XEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:04:42 -0400
Message-ID: <433B217F.4060509@pobox.com>
Date: Wed, 28 Sep 2005 19:04:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <43384E28.8030207@adaptec.com> <4339BFE9.1060604@pobox.com> <4339CCD6.5010409@adaptec.com> <4339F9A8.2030709@pobox.com> <433AFEB2.7090003@adaptec.com> <433B0457.7020509@pobox.com> <433B14E1.6080201@adaptec.com>
In-Reply-To: <433B14E1.6080201@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> The community calls specs "techno-gibberish"
> and think that LUNs can be u64, that REQUEST SENSE
> clears ACA, and that HCIL is here for ever, etc.

How many times do we have to repeat "HCIL dependencies should get moved 
to SPI-specific transport code" before you listen?


>>>If you understood how different those architectures are,
>>>you'd understand what I mean.
>>
>>
>>James is wrong here.
> 
> 
> Either you meant "Luben" here or you've been banned
> forever from "the community" and your patches would never
> ever be accepted.

Quit being silly.  I meant what I wrote.  Though it turns out that your 
interpretation of James's ideas was incorrect.  James agrees that 
"transport code" includes both lib and attributes, not attributes only.


> What I meant is that the place and design of JB's transport
> attribute "blessing" is completely out of whack for SAM
> abiding implementation.

By focusing on attributes, you miss the big picture.  This is not about 
attributes.


> Look at the pictures: the transport layer is _below_
> the application client and the application client
> is completely unaware of the transport.
> 
> Now lets translate (http://www.t10.org/scsi-3.gif) :
>     Command set drivers  <-->  sd, st, etc (application client)
>                 SAM/SPC  <-->  SCSI Core to be
>         Transport layer  <-->  SAS (all others implemented in LLDD)
>                     SDS  <-->  LLDD + Firmware
>            Interconnect  <-->  Firmware + hardware.
> 
> It is _this_ SAM architecture which allows you to say,
> send SATA commands over SAS links (via STP), and do other
> interesting things.
> 
> I guarantee you that any _new_ SCSI transport would yield
> to a Transport Layer abstraction just as SAS does.
> 
> Since, this is what SAM _is_ (all about).

This is fundamental:  SCSI specs dictate how this functions, not 
necessarily what Linux code looks like.

The big picture is

	device class <-> transport class

and everything falls out from there, including SAM.

Moving SPI (parallel SCSI, for those unfamiliar with the acronym) to 
transport-specific code will eliminate legacy assumptions that you keep 
complaining about.

Linux is about getting things done, not being religious about 
specifications.  You are way too focused on the SCSI specs, and missing 
the path we need to take to achieve additional flexibility.

With Linux, it's all about evolution and the path we take.


> I don't mind James Bottomley entertaining his
> "transport attribute" code, as long as he's not shoving
> it down my throat (again because of pictures like the one
> above).

As long as you think James is merely talking about attributes, you're 
just not getting it.

Transport classes are an abstraction which allows SAS to exist as a peer 
to parallel SCSI, FC, and other acronyms.


>>>But an AIC-94xx and BCM8603 _is_ NOT a scsi_host material.  It is just
>>>an interface to the interconnect.
>>
>>A scsi_host is simply a container.  You're being too literal.
> 
> 
> By "too literal" do you mean "following specs too closely",
> or do you mean "being realistic without tweaking things".

I mean, paying too much attention to specs at the expense of 
understanding how Linux code needs to be shaped.


>>James and Christoph have been asking you to submit patches for a long 
>>time now.
> 
> 
> Not patches to fix SCSI Core or to get "struct scsi_domain_device"
> into SCSI Core or to get 64 bit LUNs into the kenrel.
> 
> They've been asking me for me to abandon the complete
> SAS transport layer which I have, which is 1000 years ahead
> of theirs and ahead of SCSI Core and to go and work
> on LSI's and on "transport attributes".

They are asking you to help with the task of eliminating SPI 
dependencies in the core, so that SAS can exist as a peer to other 
transports.


>>James, Christoph and the rest of linux-scsi have been saying this over 
>>and over again.
> 
> 
> They've never said it: why else do you think we do not
> have 64 bit LUNS or why else do you think we have HCIL in
> SCSI Core.

Repeating myself (and others):  everybody wants HCIL stuff to move to 
SPI-specific transport code.

That is the task that must be completed BEFORE transport layer for SAS 
can be fully merged.


>>Everybody knows the SCSI core is too SPI-centric, and you have been 
>>given a recipe for fixing this.
> 
> 
> I "have been given recipe for fixing this"?
> 
> Are you all right Jeff?
> 
> Yep, the recipe was given to me by people who think that
> we should stay with HCIL, who have found purpose for
> the "second channel" in HCIL, who think that REQUEST SENSE
> clears ACA, who think that 64 bit LUN is just a waste, and
> so forth with their antics.

For the nth time, everybody agrees HCIL should move to 
transport-specific code.

And from past threads, everybody seems OK with moving to a 64-bit lun 
representation.


> So excuse me if I don't see or recognize the recipe
> given to me.  Mind pointing out a link?  This way we
> will have a hard coded evidence of what that recipe is.
> And we can see the exact steps it outlines.

For the nth time: 
http://marc.theaimsgroup.com/?l=linux-scsi&m=112487476527470&w=2

	Jeff


