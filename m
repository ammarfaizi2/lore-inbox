Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbSJQUww>; Thu, 17 Oct 2002 16:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261939AbSJQUwv>; Thu, 17 Oct 2002 16:52:51 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:43022 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261900AbSJQUwu>;
	Thu, 17 Oct 2002 16:52:50 -0400
Date: Thu, 17 Oct 2002 13:58:31 -0700
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@redhat.com>
Cc: hch@infradead.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021017205830.GD592@kroah.com>
References: <20021017185352.GA32537@kroah.com> <20021017.131830.27803403.davem@redhat.com> <20021017203652.GB592@kroah.com> <20021017.133816.82029797.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017.133816.82029797.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 01:38:16PM -0700, David S. Miller wrote:
>    
> How am I supposed to know what the things are being passed in
> via these opaque "unsigned long" parameters?
> 
> Could they be pointers?  If so, game over already, and this needs
> to be fixed NOW.

Agreed, I'll let a user of this function speak up on how they intend to
address the problem.  I'm through arguing for this hook.

>    And (ignoring the network hooks) there is not a measurable overhead for
>    these hooks.  We have documented this many times (OLS paper, USENIX
>    paper, etc.)  With the patch I'm about to submit, disabling the option
>    makes them go away entirely.
>    
> Look at the code that gets output, look at the 32K of kernel image
> I get even though I have no intention of _ever_ loading a security
> module.
> 
> So if distribution makers enable CONFIG_SECURITY, EVERY USER eats
> this 32K.  That _SUCKS_.

Note for the readers, this is 32K on Sparc, on i386 it's much smaller as
documented yesterday.

> And I severely contest your overhead argument, look at the assembler
> code being output, the kernel parts where the hooks are placed are
> different.  Lots of places that used to be leaf functions are no
> longer leaf functions due to the security_ops invocation being there
> now.  Register allocation is also going to be quite different
> different.

I've run the numbers myself on OSDL machines, and seen that there is no
measurable overhead for these functions.  Sure, there is an extra
function call, and different assembler, I'll never contest that.  It's
just that I could not measure it.

> In short, it's bloat, and if you refuse to realize that perhaps kernel
> development is not your true calling in life :-)

It is adding stuff to the kernel.  Now if you want to call it bloat,
fine.  I like calling the USB stack bloat too, and it is bloat for
people who don't use it.  And now you can disable the option, so it will
not be bloat for you too, if you don't want it.  Argue with your
favorite distro if they enable the option that they shouldn't do that,
if they do, don't try to convince me.

And I know what my true calling in life is, but unfortunately there isn't
much calling for a professional pan flute player :)

thanks,

greg k-h
