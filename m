Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWH0VkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWH0VkF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 17:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWH0VkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 17:40:05 -0400
Received: from terminus.zytor.com ([192.83.249.54]:60602 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932264AbWH0VkD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 17:40:03 -0400
Message-ID: <44F21122.3030505@zytor.com>
Date: Sun, 27 Aug 2006 14:39:46 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Alon Bar-Lev <alon.barlev@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com, Matt_Domsch@dell.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
References: <445B5524.2090001@gmail.com> <200608272116.23498.ak@suse.de> <44F1F356.5030105@zytor.com> <200608272254.13871.ak@suse.de>
In-Reply-To: <200608272254.13871.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Sunday 27 August 2006 21:32, H. Peter Anvin wrote:
>> Andi Kleen wrote:
>>> Just increasing that constant caused various lilo setups to not boot
>>> anymore. I don't know who is actually to blame, just wanting to
>>> point out that this "obvious" patch isn't actually that obvious.
>>>
>> How would that even be possible (unless you recompiled LILO with the new 
>> headers)?  There would be no difference in the memory image at the point 
>> LILO hands off to the kernel.
> 
> AFAIK the problem was that some EDD data got overwritten.
> 
>> In order to reproduce this we need some details about your "various LILO 
>> setups", or this will remain as a source of cargo cult programming.
> 
> You can search the mailing list archives, it's all in there if you don't
> belive me.
> 

Found the references.  This seems to imply that EDD overwrites the area 
used by LILO 22.6.1.  LILO 22.6.1 uses the new boot protocol, with the 
full pointer, and seems to obey the spec as far as I can read the code. 
  I'm going to try to run it in simulation and observe the failure that way.

However, something is still seriously out of joint.  The EDD data 
actually overlays the setup code, not the bootsect code, and thus there 
"shouldn't" be any way that this could interfere.  My best guess at this 
time is that either the EDD code or LILO uses memory it's not supposed 
to use, and the simulation should hopefully reveal that.

Sorry if I seem snarky on this, but if we can't get to the bottom of 
this we can't ever fix it.

	-hpa
