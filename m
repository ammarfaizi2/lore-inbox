Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWJHWpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWJHWpj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 18:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWJHWpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 18:45:39 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:33496 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932077AbWJHWpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 18:45:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K8dzZWTp2vBc/F7J+F5V7Zpb913R+0WcJKL3K6jqHPblVU5/TfV9ZW+CsCiEY9+EHZ/zis2eNATOWohCR6z7BiHqDAFlfdESN3tDyxjLYtgsTstDK5bVMnwWAh6jThe2Pei/7YsP3j82CVGYwVrUlkPcg1SIGRk5+yDndRDT2HA=
Message-ID: <653402b90610081545n51cdfbcej469990279f6d018c@mail.gmail.com>
Date: Mon, 9 Oct 2006 00:45:36 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [PATCH 2.6.19-rc1 V9] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061008220722.GG4152@elf.ucw.cz>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/06, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>
> I do not understand, both /dev/fbcfag12864b and /dev/cfag12864bX are
> in /dev/...
>

I mean: I think it is better to have the cfag12864b device than doesn't.

>
> What is advantage of /dev/cfag12864bX over /dev/fbcfag12864b ?
>
> (And I guess you should invent better name... /dev/fbaux0?)
>
>
> I do not think we need a Kconfig option, and I do not think we need
> /dev/cfag12864bX . Just use /dev/fbaux0, always.
>

One is the pure device, the other one is the framebuffer device. I
think having both is better than just one. There is no advantage, they
are different.

Maybe someone doesn't need any of the framebuffer advantages and just
wants to write to it directly, for better performance, for example:
The LCD needs to change 8 pixels (1 byte) every write, if you modify a
single pixel at the framebuffer device you will write more times than
you need for the same result (right? I'm not sure of this); the LCD is
not capable of high refreshing rates.

And well, I think it is better that way. About the Kconfig activating
both modules (cfag12864b and fbcfag12864b) I really don't care. One
option = easy of use. Both options = more control. Maybe someone just
needs the pure device :-/ We can really know how the requeriments will
be, but I think having more options in the future is better than
shrinking them now.

>
> I do not think it is suitable for -rc at this point, and it does not
> have chance before 2.6.20-rc1, anyway.
>

No? Why not? Time is not a problem, I would want to know why are you
saying that.

If you are talking about the code's quality, well, the modules are
working fine, they have been reviewed by many people, and I and some
friend have tested them enought times to be sure they work. They
doesn't remove or change any other's code, they doesn't get compiled
by default either...

If you are talking about the framebuffer device, it is something that
can be added later, without any withdraws; and without having to stop
or modify the other device drivers; as is an additional feature that
should be added as other module "fbcfag12864b", like:

lcd -> parport -> ks0108 -> cfag12864b -> fbcfag12864b -> fbcon -> console

This way, adding future forks/modifications is easier and doesn't
affect other modules. Right now, we are providing cfag12864b support
to Linux, then, we will be able to provide a framebuffer device for
the cfag12864b; then, ...; then, ...
