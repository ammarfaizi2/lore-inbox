Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUE2HJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUE2HJi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 03:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbUE2HJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 03:09:38 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:63106 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263795AbUE2HJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 03:09:34 -0400
Date: Sat, 29 May 2004 09:09:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Message-ID: <20040529070953.GB850@ucw.cz>
References: <20040528154307.142b7abf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528154307.142b7abf.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 03:43:07PM -0700, Andrew Morton wrote:

> Guys, I agree with this person.  People are having serious problems
> with the input layer and you're just not talking to anyone.  Please come out
> and help work out a resolution.

I'm sorry for not being more responsive in the near past, I've had a
huge load of other work in addition to the input subsystem, many patches
are now in my inbox to go through.

>From today on I can work almost 100% on the input drivers, and I'll go
over all the patches and consider each one.

Regarding the raw interface to the AUX (and possibly also KBD)
interfaces, I'm not opposed to that, however, I don't see an easy way to
add it that would be able to coexist with the other drivers.

Eg. one cannot load both the 'psmouse' and the raw 'psaux' modules, as
the access to the serio port is exclusive. So far I don't very much like
the fact that one would have to unload the psmouse module to get raw
access to the port.

Regarding GPM and duplication of work between it and the kernel - as far
as I know, GPM development isn't going forward very much, and there is a
bunch of things it doesn't (and likely won't) support - like the
passthrough port on synaptics touchpads.

So, yes, I'd eventually like (and will accept patches) the kernel to be
able to use every mouse (or other device) GPM supports. I believe we're
pretty near already, except for a few rather obscure ones.

BUT, we still will need GPM, because something needs to do screen
copy-and-paste. And GPM will need to be able to implement touchpad
functionality (taps, edge scrolling, etc) from absolute pad data, like
the X synaptics driver does.

That's about it. I'd be happy to merge the raw access driver, if there
is a real need for it, and if it can be made to work together with the
other PS/2 kernel drivers.

One more thought: The emulated PS/2 mouse so many people are complaining
about is there only because applications like X cannot use the native
event interface. It was intended to be removed after that support is
added, but with X development being as slow as it is, it didn't ever
happen.

> Begin forwarded message:
> 
> Date: Fri, 28 May 2004 15:33:21 +0200
> From: Giuseppe Bilotta <bilotta78@hotpop.com>
> To: linux-kernel@vger.kernel.org
> Subject: Re: keyboard problem with 2.6.6
> 
> 
> Sau Dan Lee wrote:
> > Yeah.   They   say  the  input  system  "unifies"   the  interface  to
> > keyboard/mouse  devices.   They're   also  proud  that  the  in-kernel
> > keyboard/mouse drivers  are supporting more and more  devices.  But at
> > the same  time, they're sacrificing  flexibility by moving  many codes
> > into kernel.   (GPM supports more  mouse types!)  The new  system also
> > breaks backward compatibility.
> 
> The new system has some ups and downs. The biggest "down", 
> which is that of RAW mode not being available anymore (it's 
> emulated!) could be circumvented by having both the RAW and 
> translated codes move between layers.
> 
> Concerning GPM vs kernel support for mice, maybe we can hope 
> for a merging of the efforts and a reduction of code 
> duplication, if there is any?
> 
> Overall, I think that the new system *could* be a good starting 
> point, but it still needs a *lot* of work.
> 
> (Now, if we could have any reply from the maintainers?)
> 
> -- 
> Giuseppe "Oblomov" Bilotta
> 
> Can't you see
> It all makes perfect sense
> Expressed in dollar and cents
> Pounds shillings and pence
>                   (Roger Waters)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
