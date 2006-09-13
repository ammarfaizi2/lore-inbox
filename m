Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWIMVPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWIMVPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 17:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWIMVPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 17:15:20 -0400
Received: from gw.goop.org ([64.81.55.164]:24205 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751201AbWIMVPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 17:15:18 -0400
Message-ID: <450874DD.8090109@goop.org>
Date: Wed, 13 Sep 2006 14:15:09 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael A Fetterman <Michael.Fetterman@cl.cam.ac.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Assignment of GDT entries
References: <450854F3.20603@goop.org> <1158175001.3054.7.camel@laptopd505.fenrus.org> <4508681E.3070708@goop.org> <4508711B.6060905@vmware.com>
In-Reply-To: <4508711B.6060905@vmware.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> I believe 9,10,11 are reserved for future users like yourself or 
> expanded TLS segments.  I think a bank of 3 TLS segments in the GDT is 
> working fine now (does NPTL even use more than one?).

Nope.  And there's a comment that wine uses one more.  I think the third 
is completely unused.

Does this mean that "reserved" is actually synonymous with "unused" in 
asm/segment.h?

>> Otherwise line 1 would be ideal for putting 3 TLS, kernel+user 
>> code+data and PDA into, thereby making 99.999% of GDT descriptor uses 
>> come from one cache line.
>
> That change is visible to userspace, unfortunately.

Don't think it matters much.  32-bit processes on x86-64 seem perfectly 
happy with the TLS being in a different place.  I think the ABI is 
defined in terms of "use the selector for the entry that 
set_thread_area/clone returns", and so is not a constant.  But I agree 
it would be better not to.

Hm, moving user cs/ds would be pretty visible too... Hm, and it would 
have a greater chance of breaking stuff if they changed, compared to 
moving the TLS...

So is there any reason for "kernel entries start at 12"?  If there's no 
reason for it, then we can pack everything useful into 1-5.

>> But anyway, what breaks if I put the PDA in 11?
>
> Nothing.

OK then.

    J
