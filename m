Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbVJUUld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbVJUUld (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 16:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbVJUUld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 16:41:33 -0400
Received: from magic.adaptec.com ([216.52.22.17]:22956 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965156AbVJUUlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 16:41:32 -0400
Message-ID: <43595275.1000308@adaptec.com>
Date: Fri, 21 Oct 2005 16:41:25 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: andrew.patterson@hp.com, Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached
 PHYs)
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com>	 <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com>	 <20051020170330.GA16458@lst.de>  <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <435929FD.4070304@adaptec.com> <43593100.5040708@pobox.com> <43593884.7000800@adaptec.com> <4359395B.9030402@pobox.com> <43593FE1.7020506@adaptec.com> <4359440E.2050702@pobox.com>
In-Reply-To: <4359440E.2050702@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2005 20:41:30.0309 (UTC) FILETIME=[D0DA5F50:01C5D67F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/05 15:39, Jeff Garzik wrote:
> The technical stuff got covered long ago.  Here are the basic basics:
> 
> * aic94xx needs to have the scsi-host-template in the LLDD, to fix 
> improper layering.
> * SAS generic code needs to use SAS transport class, which calls 
> scsi_scan_target(), to avoid code duplication.
> * other stuff I listed in my "analysis" email, including updating libata 
> to support SAS+SATA hardware.

All this bastardizes the code and the layering infrastructure.

If you're saying that there is "improper layering" you must be
smoking something really strong.

I'd suggest you talk to storage engineers with years of storage
experience about the design of the Linux SAS Stack.
I'd suggest you take a look at the USB and SBP code.
I'd suggest you take an overview of all of SAM and see how the protocols
fit together.
I'd suggest you take a look at the hardware design and see how and _where_
it fits and where it does not and _why_.
I'd suggest you take a look at the event management interface
(drivers/scsi/sas/sas_event.c) what it is, how it provides _all_
communication from LLDD to SAS Layer, filled in by the SAS Stack.
I'd suggest you take a look at the Execute Command SCSI RPC and the TMFs,
declared in the struct sas_ha_struct, filled in by the LLDD,
how they provide all communication from the SAS Stack to the LLDD (inteconnect).

I'm even ready to do a presentation in front of people explaining
the design of the Linux SAS Stack, why and how it works.  Specify
time and venue, please.

(I will put something up on the web site -- html and figures
to show the layering, function stubs, event management, etc.)

> This is the stuff that I have been working on (nothing pushed to sas-2.6 
> yet, as it doesn't yet boot locally).

I'm sorry to hear that.  Maybe you shouldn't have to bastardize the code.
Implement SDI and then everyone will be happy.  Look, I've alredy twice
posted code and templates, just grab it and put your name there.

Think about it: there is no reason to mess with the code.  It is
present at the link below, it works and people are using it.  It is also
sound and spec complient.  There are other subsystems which use the exact
same layering (namely USB Storage and SBP) which is consistent with the
SCSI Architecture Model all new protocols abide by.

> If you were willing to do this stuff, _working with others_, then I 
> would be off in happy happy SATA land right now, and you would have been 
> nominated to be the Linux SAS maintainer.

You seem to be traveling a path which I've already traveled.

Jeff, if you want an Adaptec SAS driver which has the host template
_in_ the driver, you can use "adp94xx" submitted earlier this year
by Adaptec to "the community".

"The community" rejected it. Why?  Because "common SAS tasks should
be in a common layer".  Well there you have the Linux SAS Stack and
aic94xx at the link below (my sig), which does separate common SAS
tasks and the interconnect _as per architecture and spec_.  Apparently
this still isn't good enough for "the community".

You see how this going around in circles just never seems to end.

One day one thing, another day the opposite, etc.

> Call it FUD, politics, personal attacks, wanking off to please 
> manglement, whatever.  My goal has always been to (a) help Linux users 
> by getting aic94xx+SAS upstream, and (b) try to help you understand why 
> your code didn't go upstream verbatim, long after others have given up 
> trying to do that.

(a) There are Linux users using "aic94xx+SAS" right now.  They've
downloaded a working Linux code from the link at my signature.

(b) I think it was because Linux says "no to specs" and you say that
"specs are the source code".

> 	Jeff, he of infinite patience

Everyone is very pleased with you.  You will go places.

	Luben
-- 
http://linux.adaptec.com/sas/
http://www.adaptec.com/sas/
