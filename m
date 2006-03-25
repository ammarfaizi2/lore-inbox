Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWCYGeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWCYGeR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 01:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWCYGeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 01:34:17 -0500
Received: from smtpout.mac.com ([17.250.248.44]:16346 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751086AbWCYGeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 01:34:16 -0500
In-Reply-To: <20060325013615.GD8117@ccure.user-mode-linux.org>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060325013615.GD8117@ccure.user-mode-linux.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7321E6DA-90FE-4CFC-9AA3-DDC53BB7BC4A@mac.com>
Cc: Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>,
       Mariusz Mazur <mmazur@kernel.pl>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: State of userland headers
Date: Sat, 25 Mar 2006 01:33:55 -0500
To: Jeff Dike <jdike@addtoit.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 24, 2006, at 20:36:15, Jeff Dike wrote:
> On Fri, Mar 24, 2006 at 05:46:27PM -0500, Kyle Moffett wrote:
>> 4)  UML runs into a lot of problems when glibc's headers and the
>> native kernel headers headers conflict.
>>
>> UML has other issues with conflicts between the native kernel  
>> headers and the GLIBC-provided stubs.  It's been mentioned on the  
>> prior threads about this topic that this sort of system would ease  
>> most of the issues that UML runs into.
>
> Actually, this isn't quite the same as what UML hits.  My problem  
> with the kernel headers is that they are a mixture of things that  
> are usable in userspace and things that aren't.  This is closely  
> related, but not identical to, things which are part of the ABI and  
> things which aren't.
>
> For example, the kernel locks are quite usable in userspace, but  
> you would never make them part of the ABI.
>
> So, a set of KABI headers would likely make UML's headers cleaner,  
> by avoiding copying arch headers and using various nasty tricks to  
> disable objectionable pieces of headers which I steal from the arch.
>
> So what I really want is a superset of the KABI headers, but the  
> KABI will give me most of what I want.

So perhaps could we define an informal subset of the kernel code that  
works in both userspace and kernel-space and put it in include/libk?   
Stuff like linked lists, spinlocks (depends on arch, may not be  
supported), etc could be in linux/libk and linux/include/libk or  
similar, and then from there included into linux/include/linux/ 
list.h, etc, as well as into the UML files that need it.  Since the  
provider and user would both be the Linux kernel, I see no issues  
with trying to provide a stable interface of any kind, especially if  
we document it as "PRIVATE - FOR KERNEL USE ONLY!!!" with big warning  
signs. As a nice bonus, this would make it possible to implement some  
user-space unit tests of various pieces.

Cheers,
Kyle Moffett

