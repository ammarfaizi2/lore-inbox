Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVHUGZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVHUGZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 02:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVHUGZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 02:25:25 -0400
Received: from tornado.reub.net ([202.89.145.182]:63631 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750809AbVHUGZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 02:25:24 -0400
Message-ID: <43081E51.3080706@reub.net>
Date: Sun, 21 Aug 2005 18:25:21 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20050820)
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1
References: <20050819043331.7bc1f9a9.akpm@osdl.org>	 <4305DCC6.70906@reub.net> <20050819103435.2c88a9f2.akpm@osdl.org>	 <430686EA.3000901@reub.net>  <20050819183600.49f620b0.akpm@osdl.org> <1124545232.3407.18.camel@localhost.localdomain>
In-Reply-To: <1124545232.3407.18.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/08/2005 1:40 a.m., David Woodhouse wrote:
> On Fri, 2005-08-19 at 18:36 -0700, Andrew Morton wrote:
>> Reuben Farrelly <reuben-lkml@reub.net> wrote:
>>> ...
>>>>> 4. PAM is complaining about "PAM audit_open() failed: Protocol not suppor
>>>>> ted" and I can't log in as any user including root.  I would have picked this 
>>>>> was a userspace problem, but it doesn't break with -rc5-mm1, yet reproduceably 
>>>>> breaks with -rc6-mm1.  Weird.
>>>> hm.  How come you're able to use the machine then?
>>> Machine was booting up ok, and things were being written to syslog.  Rebooted 
>>> into -rc5-mm1 to investigate, and of course could boot into rc6-mm1 in single 
>>> user mode, test and bring services up one by one from there.  Having two boxes 
>>> helped too.
>>>
>>>> Is it possible to get an strace of this failure somehow?
>>> Not sure if this is needed anymore, as I found that the problem goes away when 
>>> I compile in kernel auditing.  This not required for -rc5-mm1.  Is that change 
>>> intended?
>>>
>> Sounds wrong to me, especially if 2.6.13-rc6 doesn't do that.
> 
> Hm. It sounds like you'd configured PAM to require the pam_loginuid
> module even though you didn't have auditing enabled in your kernel. That
> seems strange and wrong to me, and _is_ a userspace problem.

I haven't touched my pam config since it was installed a long time ago - it's 
one of those things that is too annoying to fix once broked, so I leave it 
alone at the system defaults ;)

I had logged this as a Fedora bug as I figured the pam_loginuid
detection of the presence of auditing in the kernel is not very robust.  There 
was a patch modified in pam-0.80-6 at the start of August which was to fix 
this on non audit enabled kernels, which works for anything up to and older 
than 2.6.12-rc5-mm1.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=166422

It was closed 8 mins later, and the suggestion made that I take it to a pam 
development list instead.  Redhat don't seem so interested in fixing things as 
a result of breakage when running an -mm kernel.

> I'd also agree that it shouldn't have changed with the new kernel though
> -- and I can't think of anything I changed recently which would have
> that effect. An strace would still be useful.

Done.  Posted up at  http://www.reub.net/kernel/strace-login

> Can you double-check that you didn't have auditing enabled in your
> older, working kernel?

Definitely wasn't enabled.  I still have the .config that I used to build
-rc5-mm1 with and my original -rc6-mm1 and it reads:

CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_HOTPLUG=y

Thanks for taking a look.

Reuben




