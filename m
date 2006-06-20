Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWFTWoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWFTWoh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWFTWoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:44:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13465 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751351AbWFTWog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:44:36 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jeff Garzik <jeff@garzik.org>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       Dave Olson <olson@unixfolk.com>, Brice Goglin <brice@myri.com>,
       linux-kernel@vger.kernel.org, Greg Lindahl <greg.lindahl@qlogic.com>,
       gregkh@suse.de
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilities
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no>
	<200606200925.30926.ak@suse.de> <4497ABAC.4030305@garzik.org>
	<200606201013.51564.ak@suse.de> <4497B16E.6020103@garzik.org>
Date: Tue, 20 Jun 2006 16:44:06 -0600
In-Reply-To: <4497B16E.6020103@garzik.org> (Jeff Garzik's message of "Tue, 20
	Jun 2006 04:27:26 -0400")
Message-ID: <m1wtbbcurt.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> writes:

> Andi Kleen wrote:
>> On Tuesday 20 June 2006 10:02, Jeff Garzik wrote:
>>> Andi Kleen wrote:
>>>> So if there are any more MSI problems comming up IMHO it should be white
>>>> list/disabled by default and only turn on after a long time when Windows
>>>> uses it by default or something. Greg, do you agree?
>>>
>>> We should be optimists, not pessimists.
>> Yes, booting on all systems is overrated anyways, isn't it?
>
> Don't be silly.  Whatever solution is arrived at will boot on all systems.
> That's an obvious operational requirement.
>
> This is how new technology always works in Linux.  We turn it on and see what
> works, and what doesn't.  And whether existing problems will disappear.  With
> MSI, I think we see them disappearing.
>
> Newer systems seem to be doing better with MSI, in part because PCI-Express and
> other technologies trend towards MSI-style operation.
>
> And the kernel's MSI code is finally getting cleaned up, and getting the
> attention it needs.
>
>
>>> MSI is useful enough that we should turn it on by default in newer systems.
>> That is what we've tried so far and it seems to not work.
>
> IMO that's an exaggeration.  On 50% of the x86-64 platforms (Intel), MSI has
> been working for quite some time.  On newer systems in the other half of the
> platforms, MSI seems be more usable than it has been in the past.

It would help if the msi code as more than a 3 year old proof of concept
that has intel assumptions all through it.  Things are getting better
but there are still issues there.

I suspect that on x86 hypertransport systems if we directed our writes
to 0xFDF8000000 instead of at 0xfee0000 we would have quite a bit more luck.
Hopefully I can test and confirm that soon.  It is still a trick to get
a card with a working MSI implementation.

My gut feel is what we want is not a while list or a black list but instead
a MSI window driver.  The location and the meaning of the window is on the
edge of being an architectural definition.  But it really isn't and we are
treating it like one.

So I think part of the reason we are having MSI is we are making unwarranted
assumptions.  Once we take a good look at our side and fix that then we
can tell if something was broken.

Eric
