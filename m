Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWCaFw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWCaFw3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 00:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWCaFw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 00:52:29 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:2801 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1750926AbWCaFw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 00:52:28 -0500
In-Reply-To: <200603300953.01583.david-b@pacbell.net>
References: <7C75FBEB-F962-4860-A797-AC6B454D6E6E@kernel.crashing.org> <200603300953.01583.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EFC9942C-D6F4-4494-9ED7-C6B9B5A6DD46@kernel.crashing.org>
Cc: spi-devel-general@lists.sourceforge.net,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] SPI bus driver synchronous support
Date: Thu, 30 Mar 2006 23:52:41 -0600
To: David Brownell <david-b@pacbell.net>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mar 30, 2006, at 11:53 AM, David Brownell wrote:

> On Wednesday 29 March 2006 11:49 am, Kumar Gala wrote:
>
>> The case I have is I need to talk to a microcontroller connected over
>> SPI.  I'd like to be able to issue a command to the microcontroller
>> in a MachineCheck handler before the system reboots.
>
> Issuing the command is trivial, but knowing it completes before the  
> MCE
> handler completes is an entirely different kettle of fish.   
> Remember, the
> SPI controller may in general be busy with some other request,  
> which would
> need to finish first even if some other request _could_ jump to the  
> head
> of the request queue.
>
> I suspect some system designer is thinking about the problem wrong if
> you believe you need that kind of solution.  If for some reason your
> board design requires that sort of access, then what you'd be needing
> is a way to abort then bypass the normal SPI stack.  It could work  
> like
> any other board-specific hack.

Agreed.  It only on the exceptional case of the machine check.  For  
example I would like to send a "mute" command to a micro controller  
which controls audio output if we crash.

>> I need a truly
>> synchronous interface opposed to one fronting the async interface.
>
> I think the word "synchronous" means something other than what
> you're implying here.  Normally in Linux, it means that the
> request handling blocks until completion, sleeping allowed.
>
> You seem to be thinking about something behaving more like a
> register access, which is safe to call when in_irq().

That's true.  I guess I'll have to give more thought on if there is a  
way between the bus and client drivers.

I assume you are the SPI maintainer at this point?

- kumar


