Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264987AbUD2WHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264987AbUD2WHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264989AbUD2WHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:07:38 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:41990 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264987AbUD2WHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:07:36 -0400
Message-ID: <40917DBA.1080308@techsource.com>
Date: Thu, 29 Apr 2004 18:12:10 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
CC: Rik van Riel <riel@redhat.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com> <40911C01.80609@techsource.com> <20040429213246.GA15988@valve.mbsi.ca>
In-Reply-To: <20040429213246.GA15988@valve.mbsi.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marc Boucher wrote:
> Giuliano Colla wrote:
> 
>>Can you honestly tell apart the two cases, if you don't make a it a case of
>>"religion war"?
> 
> 
> On Thu, Apr 29, 2004 at 11:15:13AM -0400, Timothy Miller answered:
> 
>>Firmware downloaded into a piece of hardware can't corrupt the kernel in the
>>host.
>>
>>(Unless it's a bus master which writes to random memory, which might be
>>possible, but there is hardware you can buy to watch PCI transactions.)
> 
> 
> and unless it's a card with binary-only, proprietary BIOS code called at
> runtime by the kernel, for example by the vesafb.c video driver,
> which despite this has a MODULE_LICENSE("GPL").
> 
> Could someone explain why such execution of evil proprietary binary-only
> code on the host CPU should not also "taint" the kernel? ;-)

That's a good question, but the BIOS code you're talking about is not 
part of the kernel.  Sure, it's possible that it might still corrupt the 
kernel, but it's not being loaded into it as a module.  The developer of 
the BIOS code never intended for their code to be run by the Linux kernel.

Is it still dangerous?  Yes.  Is it a violation of the GPL?  No.

Also, developers of modules which thunk to BIOS code are aware of the 
potential problems and are typically willing to take responsibility for 
investigating bugs in their own code.  (Bugs in the BIOS means you're 
screwed and need to get new hardware.)  Developers of proprietary 
drivers are notoriously unhelpful when it comes to fixing bugs in their 
code.

