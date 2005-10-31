Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbVJaToU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVJaToU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 14:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVJaToU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 14:44:20 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:11082 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932416AbVJaToT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 14:44:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=L41FQ7APX9mZOYDhjgTKX2qF2qDBP0SAAsccuvOAMNqJHI3HDjko7UjmHlfDYoCefSF/yEu32lT+9cagiuIEYBadAX8CkmYHXFmimWuyAUATrHZ3umN2feUgge9YhrOGv8wnZNkN3f/7DBE3Az2C5xBnRjs8H13qRa57q6OePDg=
Message-ID: <43667406.9070104@gmail.com>
Date: Mon, 31 Oct 2005 20:44:06 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Ray Lee <ray-lk@madrabbit.org>, "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2579] linux 2.6.* sound problems
References: <53L1x-6dC-13@gated-at.bofh.it> <53LkE-6QU-5@gated-at.bofh.it> <53LkW-6QU-49@gated-at.bofh.it> <53LEq-7gr-7@gated-at.bofh.it>
In-Reply-To: <53LEq-7gr-7@gated-at.bofh.it>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Lee ha scritto:
> On Mon, 2005-10-31 at 18:04 +0100, Patrizio Bassi wrote:
> 
>>>On 10/31/05, Patrizio Bassi <patrizio.bassi@gmail.com> wrote:
>>>
>>>>starting from 2.6.0 (2 years ago) i have the following bug.
>>>>link: http://bugzilla.kernel.org/show_bug.cgi?id=2579
> 
> 
>>>>fast summary:
>>>>when playing audio and using a bit the harddisk (i.e. md5sum of a 200mb
>>>>file) i hear noises, related to disk activity. more hd is used, more chicks
>>>>and ZZZZ noises happen.
>>>
>>>Does hdparm -i (or -I) show differences between the 2.4 kernels and
>>>2.6? 2.6 has new IDE drivers, and so perhaps your system isn't using
>>>the best driver any more.
>>>
>>>You may also want to compare lspci -vv of your IDE controller and
>>>sound card between 2.4 and 2.6, and see if there are any differences.
>>>
>>>No guarantees, but this is where you'd start.
>>>
>>>
>>>
>>>>Ready to test any patch/solution.
>>>
>>>
>>>Try that. If nothing obvious appears in the examination, you may want
>>>to try the 2.6.14-rt1 patchset from Ingo Molnar. It's designed to
>>>reduce latency in the kernel, but also has a latency tracer that may
>>>be particularly useful for your problem. (Assuming it's a latency
>>>issue, and not a hardware misconfiguration due to 2.6 doing something
>>>wrong.)
>>>
>>>Ray
>>
>>actually i don't have any more 2.4 kernels due to some problems with
>>other devices.
> 
> 
> I'd suggest installing one and at minimum booting it to single user mode
> to run some tests. If 2.4 works great, then it's worthwhile to find out
> what it's getting right that 2.6 is getting wrong. The only way to find
> that out is to compare the two.
> 
> 
>>however i remember i checked that and it was pretty the same
> 
> 
> Well, I barely trust my own memory in general, so I'd suggest that we
> check. Humor me. This is the standard way to find out where a problem
> is. Check the good, check the bad, compare the two.
> 
> 
>>kernel is perfectly tuned.
> 
> 
> <?> How do you know?
> 
> 
>>i notice that with dma disabled it works much better.
>>problem happens with hda/hdc, so both ide channels.
> 
> 
>>hdparm -i /dev/hda
> 
> 
> It'd be more useful to see hdparm 2.4 versus 2.6, so we can see if
> there's any difference. If we don't see the 2.4 version, then we can't
> tell if this is something worthwhile to tweak. Does that make sense? If
> they are set the same between both 2.4 and 2.6, then we know we can rule
> the hard drive settings out as the source of the problem.
> 
> 
>> BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
>> BuffType=DualPortCache, BuffSize=1821kB, MaxMultSect=16, MultSect=off
> 
> 
> MultiSect is off on both, can you turn that on and see if that makes a
> difference? Without multisect set on (and set to 16), your hard drives
> are transferring one sector per interrupt, instead of a max of 16. This
> makes for a lot more interrupts on the system, and might be the source
> of the problem.
> 
> If that doesn't change anything, you may also try what Mike Fowler
> hinted at, and recompile your kernel with Hz set to 100 instead of the
> default 250. As well as trying the RT patchset and seeing if that shows
> any sources of problems.
> 
> Ray
> 

2.4 is hard to try for me....i'll try if i can...

i set 16 to sectors setting, but nothing changed, no real changes.

i'll recompile tomorrow -git4 with 100Hz option to check if timer can
help me


