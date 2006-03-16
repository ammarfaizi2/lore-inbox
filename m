Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWCPXng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWCPXng (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 18:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWCPXng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 18:43:36 -0500
Received: from mail.gmx.de ([213.165.64.20]:39556 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964884AbWCPXnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 18:43:35 -0500
X-Authenticated: #427522
Message-ID: <4419F97B.5090301@gmx.de>
Date: Fri, 17 Mar 2006 00:49:15 +0100
From: Mathis Ahrens <Mathis.Ahrens@gmx.de>
User-Agent: Mail/News 1.5 (X11/20060206)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.16-rc6] CONFIG_LOCALVERSION_AUTO
References: <44179C77.1010902@gmx.de> <20060316203400.GA24008@mars.ravnborg.org>
In-Reply-To: <20060316203400.GA24008@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Wed, Mar 15, 2006 at 05:47:51AM +0100, Mathis Ahrens wrote:
>   
>> 1.
>> Semantics of LOCALVERSION are confusing and probably buggy.
>> [...]
>>     
> This is a bug.
> I will fix that for 2.6.17.
>   
Cool, thanks.

>> 2.
>> "make kernelrelease" does not imply "make .kernelrelease", it only
>> does cat the file .kernelrelease (or shows an error if it's not there).
>>     
Oh, I notice that I have been dumb here. Of course `make kernelrelease`
should not depend on `make .kernelrelease` or alter .kernelrelease in any
way.
>> This leads to the following IMHO slightly irritating behaviour
>> $ echo "LV1" > localversion
>> $ make kernelrelease
>> 2.6.16-rc6LV1
>> $ echo "LV2" > localversion
>> $ make kernelrelease
>> 2.6.16-rc6LV1
>>
>> Is there a reason for this?
>>     
> make kernelrelase shall work in both a read-only environment and shall
> avoid modifying files when run as another user.
> So the simple measure was to error out only if .kernelrelease was
> missing.
>   
But then - for this I would use `cat .kernelrelease` ?

> The trick here seems to print $(KERNELVERSION)$(localver-full)
> but only if .kernelrelease is present.
> On the other hand if .kernelrelase and $(KERNELVERSION)$(localver-full)
> differ then what to print.
> The kernelrelease of the kernel or how it is configured?
>   
Yes, these may be different, and both are interesting:
1. What name would I get if I started building now.
2. Assuming I did not modify anything since the last build, what was it
named?
> echo -sam > locelversion does NOT change the kernel.
> The kernelrealse of the kernel is only changed after running 'make'.
> And this is what we want to see - the kernelrelase of the kernel, not
> what happes to be stored in a file after the kernel was compiled.
>   
Right. Only I get this also with `cat .kernelrelease`.
That's why my intuition said, `make kernelrelease` probably prints the
string
that *would* be appended, based on all the knowledge in the Makefile.

After all, this is interesting, since that composition is not trivial,
and the
logic is inside the Makefile.

Maybe this could be made another target?
`make upcomingrelease` (-;
  

Cheers,
Mathis
