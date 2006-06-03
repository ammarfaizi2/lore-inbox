Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWFCDWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWFCDWl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 23:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWFCDWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 23:22:41 -0400
Received: from smtpout.mac.com ([17.250.248.176]:3288 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750944AbWFCDWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 23:22:41 -0400
In-Reply-To: <9e4733910606011918vc53bbag4ac5e353a3e5299a@mail.gmail.com>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605302314.25957.dhazelton@enter.net> <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com> <200605310026.01610.dhazelton@enter.net> <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com> <20060601092807.GA7111@localhost.localdomain> <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com> <21d7e9970606011815y226ebb86ob42ec0421072cf07@mail.gmail.com> <9e4733910606011918vc53bbag4ac5e353a3e5299a@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <24BBD756-4658-48A7-AD4D-1D25124A946B@mac.com>
Cc: Dave Airlie <airlied@gmail.com>, Ondrej Zajicek <santiago@mail.cz>,
       "D. Hazelton" <dhazelton@enter.net>, Pavel Machek <pavel@ucw.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Fri, 2 Jun 2006 23:21:46 -0400
To: Jon Smirl <jonsmirl@gmail.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 1, 2006, at 22:18:07, Jon Smirl wrote:
> On 6/1/06, Dave Airlie <airlied@gmail.com> wrote:
>> of course, but that doesn't mean it can't re-use X's code, they  
>> are the best drivers we have. you forget everytime that the kernel  
>> fbdev drivers aren't even close, I mean not by a long long way  
>> apart from maybe radeon.
>
> I am aware that X has the best mode setting code and it would be  
> foolish to ignore it.

You're kidding, right?  I've never been able to get X to get the  
modes right on my damn flatpanel.  Hell, it can't even match DDC  
channels to VGA ports without hand-holding in the config file.  To  
contrast, the fbdev layer gets it right every time on the whole  
variety of hardware that I've got.  Likewise the only way that I've  
ever gotten X to even set a vaguely functional mode on another card  
is by loading the framebuffer module first and specifying Option  
"UseFBDev" "true".  Anything else and the monitor goes off mode and  
there's no getting it back.

>>> 9) there needs to be a way to control the mode on each head,  
>>> merged fb should also work. Monitor hotplug should work. Video  
>>> card hot plug should work. These should all work for console and  
>>> the display servers.
>>
>> Of course, have you got drivers for these written? this is mostly  
>> in the realms of the driver developer, the modesetting API is  
>> going to have to deal with all these concepts.
>
> This needs to be considered in the design stage. For example, if  
> both heads are mapped through a single device node they can't be  
> independently controlled by two different user IDs. We need to make  
> sure we leave the path open to building this.

I kind of agree, but on the other hand there needs to be a way to  
specify multiple viewports in a single framebuffer like MergedFB on  
my radeon.  I would be quite happy to tinker with my little C-based  
framebuffer graphics apps in the console except that I can't  
manipulate the second display's view in the same framebuffer with fbset.

> I meant support for Korean, Chinese, etc. You can't draw some of  
> the complex scripts without using something like Pango. Do we want  
> to build a system where people can use console in their native  
> language?  You can use these languages from xterm but not console  
> today. I have no strong opinion on this point other that I believe  
> it should be discussed and input from non-English speakers should  
> be considered. No one on this list has a problem with this area  
> since we all speak English.

IMHO the best way to do this is leave basic 7-bit or 8-bit fonts in  
the kernel where they are now and do the rest from a little userspace  
framebuffer console.  With a secure-attention-key to revert to the  
native console for emergency debugging and such, set up so it can  
display panics, I think the rest would be much better handled with  
the flexibility and locale support of userspace.

>> 14) backwards compatible, an old X server should still run on a  
>> new kernel. I will allow for new options to be enabled at run-time  
>> so that this isn't possible, but just booting a kernel and  
>> starting X should work.
>
> I'm not sure we want to continue supporting every X server released  
> in the last 25 years. But we should definitely support any X server  
> released in a 2.6 based kernel distribution. What are reasonable  
> limits?

IMHO X is currently broken enough on much of my hardware that I'd be  
completely happy to be forced to upgrade.  My LCD has diagonal red  
scrolling when in X (works fine on the kernel console though) and X  
can't seem to hardware accelerate at all, even on this RV200 chip.

>> 16) secure - no direct IO or MMIO access, modesetting is slow  
>> anyways having the kernel checking the mmio access won't make it  
>> much slower.
>
> This needs some expansion. Secure is good, but it's not clear what  
> you are requiring with this point.
>
> For me security means reducing the privileged code to an absolute  
> minimum and then inspecting it closely to make sure there are no  
> holes. Everything that is passed in needs to be checked and  
> regarded with suspicion. But you can go too far with the reduction,  
> if you provide a generic IOCTL to poke an IO port with an arbitrary  
> value you now have to verify that it is safe to pass in every  
> possible value. Instead if the IOCTL implements a specific function  
> that pokes the port with a single fixed value it is easier to say  
> that it is secure.

I'd personally rather not see any IOCTLs for poking of ports, I kinda  
like being able to script framebuffer drawing with a little bit of  
Perl or some hastily written C.  Calling FBIOGET_VSCREENINFO is fine,  
calling FBIO_POKE_OBSCURE_PORT is kinda iffy.  I realize there's no  
black and white but it would be nice to maintain some clarity of  
interface; make simple things simple and hard things possible.

Cheers,
Kyle Moffett

