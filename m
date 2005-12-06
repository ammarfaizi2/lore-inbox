Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbVLFJ13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbVLFJ13 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 04:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVLFJ13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 04:27:29 -0500
Received: from smtpout.mac.com ([17.250.248.88]:30421 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964888AbVLFJ12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 04:27:28 -0500
In-Reply-To: <20051205214256.492421ad@griffin.suse.cz>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <20051205190038.04b7b7c1@griffin.suse.cz> <200512052123.42357.mbuesch@freenet.de> <20051205214256.492421ad@griffin.suse.cz>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D76B7270-C6A7-4068-9FDD-4C8B9F491F62@mac.com>
Cc: Michael Buesch <mbuesch@freenet.de>, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, NetDev <netdev@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Broadcom 43xx first results
Date: Tue, 6 Dec 2005 04:26:50 -0500
To: Jiri Benc <jbenc@suse.cz>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 05, 2005, at 15:42, Jiri Benc wrote:
> On Mon, 5 Dec 2005 21:23:42 +0100, Michael Buesch wrote:
>> This is __not__ "yet another stack". It is an _extension_.  It is  
>> all about management frames, which the in-kernel code does not  
>> manage.
>
> But this code should be part of the stack, as nearly every driver  
> needs it.

WRONG.  More than half the currently Linux-compatible wireless cards  
handle the wireless management packets in hardware, such that they're  
little more complicated than a basic ethernet device with a channel,  
an ESSID, and a list of MACs/APs.

> Management handling should be really managed by the kernel.

Yes, but it might not need to be in the base stack if it's largely  
functionally independent.

> The hard part is that every driver will need a slightly different  
> amount of this support depending on the amount of features that are  
> provided by firmware.

s/firmware/hardware/g.  This is _exactly_ why an external module  
makes a lot of sense.

>> We tried the code from the RTL driver, but it is total crap.  We  
>> dropped it again. We thought about using yet another out of kernel  
>> ieee80211 stack, but we began to write an extension to the in- 
>> kernel code. If that was right or wrong, well, that's the question.
>>
>> If you _really_ think we should have used $EXTERNAL_STACK, go and  
>> patch the driver to work with it.
>
> No. I just think we (everybody) should concentrate at one  
> particular stack, finish it and merge it. And I'm convinced Jouni's  
> stack is currently the best solution available - far far from  
> perfect, with many issues, but still the best - and it will finally  
> save as much time.

What you miss is that the kernel does _not_ go with the "rewrite it  
and replace it" methodology.  See Luben Toikov in the SAS flamewar  
for another example.  If a better stack exists, provide a nice clean  
set of totally functional changes that convert the current one into  
that one.  In the process, we even get to keep the nice parts of the  
current one that aren't in his (whatever they may be), and we always  
have a working wireless stack.  With the rewrite/replace solution,  
you end up broken or unstable half the time.

Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay



