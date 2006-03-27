Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWC0A16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWC0A16 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 19:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWC0A16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 19:27:58 -0500
Received: from smtpout.mac.com ([17.250.248.70]:206 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932268AbWC0A15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 19:27:57 -0500
In-Reply-To: <20060326212601.GA7088@mars.ravnborg.org>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <20060326065416.93d5ce68.mrmacman_g4@mac.com> <20060326200537.GA5012@mars.ravnborg.org> <1DF54B48-4541-4BA9-A71C-A64CE98B4964@mac.com> <20060326212601.GA7088@mars.ravnborg.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6B80F385-00A4-4D45-9310-7A52DB53C190@mac.com>
Cc: linux-kernel@vger.kernel.org, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI header infrastructure
Date: Sun, 26 Mar 2006 19:27:42 -0500
To: Sam Ravnborg <sam@ravnborg.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2006, at 16:26:01, Sam Ravnborg wrote:
> On Sun, Mar 26, 2006 at 03:39:32PM -0500, Kyle Moffett wrote:
>> I'm not entirely sure I understand this bit.  The idea behind this  
>> kabi stuff is precisely to split out portions of the headers so  
>> that both userspace and kernelspace can get at them; to designate  
>> specific items as "userspace clean" by putting them in kabi;  
>> everything else need not care at all, and all those headers would  
>> remain in include/ linux where they are now.  No sense moving  
>> _everything_ in include/ around, we just want the parts that  
>> userspace needs too.
>
> There are today a great number of users of the existing kernel  
> headers.  Introducing a new namespace for the userspace suers will  
> leave them in a dilemma where they have to support kernels before  
> kabi, and kernels with kabi. That alone will limit the acceptance  
> of this.

I tried to talk to this in my other email, but for emphasis; I'd like  
to do two things:
1)  Preserve compatibility with <linux/*.h>, so that old programs  
still work fine
2)  Cause <kabi/*.h> to work on any distro, and kernel, not just  
kernel released after it is introduced.  In practice this means that  
a distro could just package up the kabi headers and install them in / 
usr/include.  A package that is altered to compile against only  
__kabi_* would be able to use information about which syscalls and  
structures are available in each version to either handle different  
kernels at runtime or have a configure-time kernel version specified  
by the user.

> Keeping include/linux for the kernel ABI will allow us NOT to break  
> existing users and it will allow a stepwise apporach at the same time.

I completely agree.  If you'll notice the patches I submitted were  
quite careful to preserve the exact same semantics for the linux/*.h  
headers, both in the interests of not breaking the kernel _and_ in  
the interests of allowing userspace to still include <linux/ 
types.h>.  IMHO, we should try to get the interface compatibility  
crap _out_ of linux source tree and into a separate package which  
depends only on the cleaned-up interface specification (IE: kabi/*).

Cheers,
Kyle Moffett



