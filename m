Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932816AbWJIN4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932816AbWJIN4k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 09:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932817AbWJIN4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 09:56:39 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:63461 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932816AbWJIN4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 09:56:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ncqbm++YDZs5XtB/yDggXAKtzV27L+c1PhjWJTBqvdaHAZwVF8KOWk+Fl4cby3pdoiuJ8Gk+XF401kYYL8bjlcq/oUuFDcPTxQPEBbEEJcEISj0aZYW7rc2vZGQ9GoJTttwRXNh1sfYNQwhdHEanp2j8kwQvy9N24oxFBQ3tpII=
Message-ID: <653402b90610090656r18a43413ue0407a98bc8a0178@mail.gmail.com>
Date: Mon, 9 Oct 2006 15:56:36 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 2.6.19-rc1 V9] drivers: add LCD support
Cc: "Pavel Machek" <pavel@ucw.cz>, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <452A4FA1.10701@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061006002950.49b25189.maxextreme@gmail.com>
	 <20061008182438.GA4033@ucw.cz>
	 <653402b90610081137g7885fc85h54e5e94de682a246@mail.gmail.com>
	 <20061008191217.GA3788@elf.ucw.cz>
	 <653402b90610081312m32fcf7ecx9929ae9dc4768c17@mail.gmail.com>
	 <20061008211550.GE4152@elf.ucw.cz>
	 <653402b90610081436w34d692ecv2dd9801c451ab490@mail.gmail.com>
	 <20061008220722.GG4152@elf.ucw.cz>
	 <653402b90610081545n51cdfbcej469990279f6d018c@mail.gmail.com>
	 <452A4FA1.10701@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> On 10/9/2006 12:45 AM, Miguel Ojeda wrote:
> > On 10/9/06, Pavel Machek <pavel@ucw.cz> wrote:
> ...
> >> What is advantage of /dev/cfag12864bX over /dev/fbcfag12864b ?
> >>
> >> (And I guess you should invent better name... /dev/fbaux0?)
>
> If the driver exposes sensible information, udev can give names.
>
> ...
> >> I do not think it is suitable for -rc at this point, and it does not
> >> have chance before 2.6.20-rc1, anyway.
> >
> > No? Why not? Time is not a problem, I would want to know why are you
> > saying that.
>
> Linus currently has a rule for merge windows; akpm certainly doesn't.
>

I meant that time is not a problem (it is not a critical part), so the
drivers can wait peacefully until the next merge window (althought
they don't compromise any other part of the kernel :). But I thought
he could be saying that the code is not ready (because of the
framebuffer).

>
> On 10/8/2006 11:36 PM, Miguel Ojeda wrote:
> ||| I have no problem coding the fbcfag12864b module in my free time;
> ||| but I prefer to remain the other modules as they are now and add
> ||| the fbcfag12864b later in time: I'm waiting them to get into one
> ||| of the -rcs without more radical changes.
>
> An interface which promises to be future-proof, especially if it is an
> interface to userspace, is of course a requirement to get into mainline
> in the first place. (However I don't know enough about the interfaces
> discussed here nor about your requirements to say anything specifically
> about your interface or the one Pavel suggested.)
>

Sure, the point is that there is no new interface:

My thought: The cfag12864b module creates a device node
/dev/cfag12864b which represents the physical display. If you write
there, you get the pixels painted in the screen. So if I code a new
fbcfag12864b module which depends on the cfag12864b module and creates
a new device, a framebuffer one. The framebuffer interface is also
"standard", right?. This way, as there are not any new interfaces, and
as cfag12864b doesn't know anything about fbcfag12864b and
fbcfag12864b doesn't have to know about the hardware, it is
future-proof as there is not going to be any changes and no new
interfaces in any way. The cfag12864b will remain without any changes.

Pavel suggested that I should recode the cfag12864b to destroy all
about the /dev/cfag12864b, and just create the fbcfag12864b device. I
think this mixs different concepts (the framebuffer abstraction with
the hardware), create less maintanieable code (as it mixs hardware io
related code with the framebuffer code: someone could improve the
fbcfag12864b without having to read about the cfag12864b driver, for
example; or change some function to meet the new kernel release
instead of having to take care of more irrelevant code), less scalable
(as it is mixed together), more hardware specific (maybe it is
possible to create a framebuffer device for every lcd of 128x64
dimensions), etc.

      Miguel Ojeda
