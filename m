Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265589AbUAPRpv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 12:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265590AbUAPRpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 12:45:51 -0500
Received: from cpc3-hitc2-5-0-cust116.lutn.cable.ntl.com ([81.99.82.116]:57790
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S265589AbUAPRpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 12:45:49 -0500
Message-ID: <40082A67.7000709@reactivated.net>
Date: Fri, 16 Jan 2004 18:16:07 +0000
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Murilo Pontes <murilo_pontes@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nforce2 66MHz IDE without idebus=xx and "Athlon-xp powersaving
 system lock"
References: <200401161352.25732.murilo_pontes@yahoo.com.br>
In-Reply-To: <200401161352.25732.murilo_pontes@yahoo.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Murilo Pontes wrote:
> Athlon-xp powersaving lock-up: mm series disable 'Halt Disconnect and Stop Grant Disconnect' on boot!

Those patches are no longer included in -mm kernels.

> Without mm patchs I disable it with "athcool" tool, kernel developers maybe include 
> automatic disable 'Halt Disconnect and Stop Grant Disconnect' on Linus tree?

As you can probably guess, enabling the C1 disconnect bit should not cause 
system instability. Simply disabling the C1 disconnect bit is not a very good 
way of solving the problem. Thats why those earlier "fixes" are no longer 
included in the -mm tree.

Ross Dickson has been doing some good research here - it does seem to be a 
hardware/firmware related bug, the CPU acting too soon after coming out of a 
disconnect (not too sure on the details here, its a little over my head). The 
lockup bug (for me) only shows itself when I enable APIC/IO-APIC in my kernel 
configuration, the older XTPIC interrupt paths are slower and tend not to 
trigger this bug as much.

With Ross's patches, you can boot with an apic_tack argument. When this 
argument is "1" it will introduce a delay to get rid of the problem. When you 
use "2" it will only enable the delay when a lockup is predicted. For me, 
apic_tack=2 has solved the problem, with C1 disconnect on, and APIC/IO-APIC 
enabled.

There's one side effect that a few people have reported: The clock appears to 
skew, gains about 15 mins over the period of 4-5 days. I have experienced this 
too.

See this thread for more info:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107199838022614&w=2

Daniel.
