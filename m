Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422825AbWJDSs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422825AbWJDSs1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422815AbWJDSs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:48:26 -0400
Received: from rtr.ca ([64.26.128.89]:40453 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1422825AbWJDSsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:48:25 -0400
Message-ID: <452401F8.5000004@rtr.ca>
Date: Wed, 04 Oct 2006 14:48:24 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in libata-dev.git
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com> <4523F602.6070608@rtr.ca> <4523F77B.1030908@ru.mvista.com>
In-Reply-To: <4523F77B.1030908@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergei Shtylyov wrote:
>..
>> I suspect Sergei simply had a bad controller card at the time.
> 
>    I can hardly imagine the reason why a PCI IDE controller (that was 
> something like VT82C586 I think) would need to mess with the sector 
> count reg. in PIO mode and return "command aborted" in the error reg... 
> That was the exact sympthom IIRC.

Ahh.. well, if it just returned command aborted, then Jeff's original
change would present no real danger --> any occurances would be detected.

But to answer the imaginative question, the *reason* why a PCI (or VLB) IDE
controller would mess with the registers, is because the makers have this
nasty habit of wanting to do data prefetching (and posting) to speed up
transfers, particularly PIO transfers.  And the only way they can do the
prefetching/posting "safely", is to snoop the taskfile registers and have
the contoller "know" their meanings.

This has lead to all kinds of lunacies, like the RZ1000, CMD640, and other
memorable disasters of mis-implementation.

Cheers!
