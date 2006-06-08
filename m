Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbWFHHFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbWFHHFU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWFHHFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:05:20 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:40162 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932536AbWFHHFT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:05:19 -0400
Message-ID: <4487CB77.3050503@aitel.hist.no>
Date: Thu, 08 Jun 2006 09:02:15 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Dave Airlie <airlied@gmail.com>, Ondrej Zajicek <santiago@mail.cz>,
       "D. Hazelton" <dhazelton@enter.net>, Pavel Machek <pavel@ucw.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
       adaplas@gmail.com
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <200605302314.25957.dhazelton@enter.net>	 <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com>	 <200605310026.01610.dhazelton@enter.net>	 <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>	 <20060601092807.GA7111@localhost.localdomain>	 <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>	 <21d7e9970606011815y226ebb86ob42ec0421072cf07@mail.gmail.com> <9e4733910606011918vc53bbag4ac5e353a3e5299a@mail.gmail.com>
In-Reply-To: <9e4733910606011918vc53bbag4ac5e353a3e5299a@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 6/1/06, Dave Airlie <airlied@gmail.com> wrote:
>> > Without specifying a design here are a few requirements I would have:
>> >
>> > 1) The kernel subsystem should be agnostic of the display server. The
>> > solution should not be X specific. Any display system should be able
>> > to use it, SDL, Y Windows, Fresco, etc...
>>
>> of course, but that doesn't mean it can't re-use X's code, they are
>> the best drivers we have. you forget everytime that the kernel fbdev
>> drivers aren't even close, I mean not by a long long way apart from
>> maybe radeon.
>
> This requirement means that stuff like mode setting has to be broken
> out into an independent library. For example it would not be ok to say
> that Fresco has to install X to get mode setting. No comment was made
> on where the code comes from, you are reading in something that isn't
> in the requirement.. I am aware that X has the best mode setting code
> and it would be foolish to ignore it.
>
> Both you and I both know what a pain it is to extract this type of
> code from X. Let's not repeat X's problems in this area. Let's make
> the new library standalone and easy to work with in any environment.
> No all encompassing typedef systems this time.
>
>> > 2) State inside the hardware is maintained by a single driver. No
>> > hooks for state swapping (ie, save your state, now I'll load mine,
>> > ...).
>>
>> We still have to do state swapping, we just don't expose it,
>> suspend/resume places state swapping as a requirement.
>
> I don't consider suspend/resume state swapping, it is state save and
> restore. The same state is loaded back in.
>
> Other than suspend/resume why would the driver need to do state swapping?
>
>> > 9) there needs to be a way to control the mode on each head, merged fb
>> > should also work. Monitor hotplug should work. Video card hot plug
>> > should work. These should all work for console and the display
>> > servers.
>>
>> Of course, have you got drivers for these written? this is mostly in
>> the realms of the driver developer, the modesetting API is going to
>> have to deal with all these concepts.
>
> This needs to be considered in the design stage. For example, if both
> heads are mapped through a single device node they can't be
> independently controlled by two different user IDs. We need to make
> sure we leave the path open to building this.
Yes.  Having two nodes should fix this one though.  The two nodes
can of course be managed by the same driver, so as to deal with
issues when there are some shared resources like memory
and a single graphichs accelerator.
>
>
>> > 10) Console support for complex scripts should get consideration.
>>
>> not really necessary.. nor should it be... fbset works, something like
>> it would be good enough..
>
> I meant support for Korean, Chinese, etc. You can't draw some of the
> complex scripts without using something like Pango. Do we want to
> build a system where people can use console in their native language?
That is very nice to have.  Of course, it is acceptable to say that
those who want a Korean/Chinese console are the ones who have to
program that part themselves too, but the console design should not 
prevent this.


Helge Hafting
