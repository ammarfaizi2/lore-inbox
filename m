Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161072AbWFKDEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbWFKDEE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 23:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWFKDEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 23:04:04 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:203 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932557AbWFKDED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 23:04:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=I+x7zgtf27aX58AVUUiBLFqfH1qLMuo5Me7FLMuR/h7MkMlfuc6Q1Jjc5rHTNXfaIQw/H2aws41PsTF99UYjSrJlQGDoee4j8Jk8eoIBbVLJqIElgWTg14OWx22T0m185k/tCZn0Bm36SbUOJaraOK7QPuCxKOl3R5yFk80JE+c=
Message-ID: <448B8818.1010303@gmail.com>
Date: Sun, 11 Jun 2006 11:03:52 +0800
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
References: <44893407.4020507@gmail.com>	 <9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>	 <448AC8BE.7090202@gmail.com>	 <9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>	 <448B38F8.2000402@gmail.com>	 <9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>	 <448B61F9.4060507@gmail.com>	 <9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>	 <448B6ED3.5060408@gmail.com> <9e4733910606101905y6bfdff4bo3c1b1a2126d02b26@mail.gmail.com>
In-Reply-To: <9e4733910606101905y6bfdff4bo3c1b1a2126d02b26@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Jon Smirl wrote:
>> > On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> >> > I see now that you can have tty0-7 assigned to a different console
>> >> > driver than tty8-63.
>> >> > Why do I want to do this?
>> >>
>> >> Multi-head.  I can have vgacon on the primary card for tty0-7,
>> >> fbcon on the secondary card for tty8-16.
>> >
>> > That's what I thought, I couldn't see any other reason. The kernel
>> > doesn't support input from multiple users so multihead can only be
>> > used by a single user.
>> >
>> > Does anyone use single user multihead on current systems? The kernel
>> > doesn't have code in it to initialize secondary VGA cards. What modern
>> > non-VGA hardware does this work on?
>>
>> matroxfb supports multihead and fbcon already has this feature for a
>> long time, ie you can bind /dev/fb0 to tty0-3 and /dev/fb1 to tty4-6.
>> And there are definite users because I happen to break this feature once
>> and I got rained with complaints :-)
> 
> Were those people using this: http://linuxconsole.sourceforge.net/
> Does that work anymore?

No, plain vanilla kernel support this feature. There are lots of
users using the single-user, multi-head feature of fbcon. I've been using it.
The developer of one of the cyber cards also use it.

The main goal of the linuxconsole people is true multiuser, multihead.
One user per card simultaneously.

> 
> This is single a single driver bound to the vt layer. Support for both
> fb0 and fb1 are provided by that single driver. So there may be some
> way to make this work.
> 

Yes, fbcon does intermediate between drivers, so it's not a problem.

>> > If this feature doesn't work on current hardware, could it be dropped?
>> > It would make binding to the vt system much simpler if only one driver
>> > could be bound at a time. Anything we do to make that system simpler
>> > would benefit everyone.
>>
>> You can't drop something that's already in the kernel and has users,
>> well,
>> the binding part at least. What we don't currently have is the
>> fine-grained
>> control and because of the reason's you mentioned, I said that it's
>> for the
>> future.
> 
> There are variations on 'drop' is it dropping if we provide an
> alternate way to achieve the same thing?

Yes, by not providing the user with the option to load and bind
multiple drivers at one time, we are essentially not supporting this
feature.  And that's not a problem. /sys/class/vtconsole/vtcon[x]/bind
handles wholesale binding and unbinding, ie, when you echo 1 > bind,
only that driver, and nothing else, becomes active.

My point is: 'Multiple active drivers feature' is a natural consequence
of the evolution of the code, but the only way to take advantage of it
is if we provide a means for the user to use it.  And we are not
providing the means.

> 
> Does matroxfb know which VC number it is drawing too? If so, we could
> move the mapping between head and VC down to an attribute on the
> matroxfb driver. That would allow the general case of the VC layer
> binding to be simplified to opening a single driver.
> 
> That is not an attribute you want long term on the matroxfb driver,
> but all of this would get more cleanly sorted out when a user space
> implementation happens.

No, matroxfb and any other fbdev drivers has no knowledge whatsoever about
the console.

Tony
