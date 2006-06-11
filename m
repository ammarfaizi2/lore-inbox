Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWFKWEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWFKWEQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 18:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWFKWEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 18:04:16 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:8124 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750956AbWFKWEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 18:04:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FgMykwTGW73mD5x8r97bUVXCH6annK1onk9hy4Sil0xDXHJEFBMcefVbq4EaOfsuI1HAfpir1AWkkpePWw0QnLiq2v6K6Z5DXc0MRT3iAfMchs60zoLFKYbVDGedwlutlpiqCt6PhoncVHLt56V2xT1iqWaq8sS0ZzGFtUVHT6s=
Message-ID: <448C9355.5080105@gmail.com>
Date: Mon, 12 Jun 2006 06:04:05 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file describing the feature
References: <44893407.4020507@gmail.com> <448B38F8.2000402@gmail.com>	 <9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>	 <448B61F9.4060507@gmail.com>	 <9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>	 <448B6ED3.5060408@gmail.com>	 <9e4733910606101905y6bfdff4bo3c1b1a2126d02b26@mail.gmail.com>	 <448B8818.1010303@gmail.com>	 <9e4733910606102027o8438d55webf938dfc8495ea8@mail.gmail.com>	 <448BA03B.6060800@gmail.com> <9e4733910606111359o38822782oe0fd9a69659d7d06@mail.gmail.com>
In-Reply-To: <9e4733910606111359o38822782oe0fd9a69659d7d06@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 6/11/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Jon Smirl wrote:
>> > On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> >> My point is: 'Multiple active drivers feature' is a natural
>> consequence
>> >> of the evolution of the code, but the only way to take advantage of it
>> >> is if we provide a means for the user to use it.  And we are not
>> >> providing the means.
>>
>> Maybe you're misunderstanding me. When I say "we are not providing the
>> means", I mean "we are definitely not going to provide the means", NOT,
>> "so we should be providing the means".
> 
> I thought about this for a day. The problem is that in-kernel,
> single-user, multi-head is not on a good development path. That path
> leads to in-kernel, multi-user support which is something I  don't
> think we want to do. The current in-kernel, single-user, multi-head
> feature is also only partially complete, it does not work on the
> majority of VGA hardware in use today.

If you're talking about fbcon, it does work, and not just on the
minority. 

> 
> So the question is, what do you want to do about it? If you leave it
> in place it complicates new work in the VT layer.  One result being the
> complicated sysfs interface that you are building.

The VT subsystem happens to support single user, multi-head, period.
I did not add it, maybe Linus did, who knows. To use it though, besides
hacking the drivers, one needs to provide an interface for it. And I
have emphasized several times that I AM NOT going to provide one.

What I have done is to add a feature to enable us to unload the VT
drivers. If you are planning on replacing the current system with your
own, you will need this feature. So I'm doing you a favor.

> You are forced into
> doing more in-kernel work to support a feature that may not be on the
> long term path.

Look, you're saying that I should only support one driver loaded at
one time.  And I'm doing it by not allowing the users to load more
than one driver at a time. To fully kill this feature, you need to
kill the source which happens to be the VT layer.

If you don't want the VT layer to support more than 1 drivers,
go ahead, rewrite the VT layer.

> 
> Another solution would be to build a small user space console system
> and use it to drive the secondary heads. That would then allow the
> feature to then be removed from the kernel. People would need to
> change their scripts but the user level feature will still be there.

Again, go ahead.

> 
> This is an example of a case where evolutionary design gets into
> trouble. Without knowing the high-level plan for the future of
> multi-user, multi-head graphics support in Linux you don't know the
> right way to solve this problem.
> 

Nobody is stopping you from rewriting the entire graphics subsystem
from scratch.

You can be as revolutionary with your changes as you want, but you have
to respect one very important thing, kernel to userspace compatibility.

Tony
