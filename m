Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261993AbSI3KCK>; Mon, 30 Sep 2002 06:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261995AbSI3KCK>; Mon, 30 Sep 2002 06:02:10 -0400
Received: from ws-002.ray.fi ([193.64.14.2]:17336 "EHLO behemoth.ts.ray.fi")
	by vger.kernel.org with ESMTP id <S261993AbSI3KCJ>;
	Mon, 30 Sep 2002 06:02:09 -0400
Date: Mon, 30 Sep 2002 13:07:19 +0300 (EEST)
From: Tommi Kyntola <kynde@ts.ray.fi>
X-X-Sender: kynde@behemoth.ts.ray.fi
To: David Brownell <david-b@pacbell.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: USB Mass Storage Hangs
In-Reply-To: <3D95DB7B.1040401@pacbell.net>
Message-ID: <Pine.LNX.4.44.0209301239330.8153-100000@behemoth.ts.ray.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  > > And are both of these devices USB 2.0 devices?  If so, you might want to
>  > > try the 2.4.20-pre kernels, it has much better USB 2.0 support than the
>  > > kernel you are using.
>  >
>  > I can still panic even the 2.4.20-pre8, by ...
> 
> Actually, even pre8 doesn't have the updates that would matter
> for something like this ... the "better" was mostly not oopsing
> if you unplug a hub (it was a hub driver bug).  You'd need some
> patches that aren't yet in Marcelo's tree, but which HAVE been
> pasted here on LKML.  (And people who've tried them have said
> the patches have improved things for them.)
> 
> Have a look at these posts, which are slightly updated versions of
> what's been posted to LKML (patches in the second two):
> 
>     http://marc.theaimsgroup.com/?l=linux-usb-devel&m=103288096812331&w=2
>     http://marc.theaimsgroup.com/?l=linux-usb-devel&m=103288089912220&w=2
>     http://marc.theaimsgroup.com/?l=linux-usb-devel&m=103283868910428&w=2
> 
> Alternatively, try this out on 2.5.latest ... those patches give
> 2.4.20-pre7 (or pre8) the same EHCI code as seen in 2.5.39, but
> if you try 2.5.39 you'll benefit from some usb-storage fixes too.

Actually I did see those posts, it's just that I've had the exact same 
problem on uhci and ohci, and because rmmod usb-storage between
unplug and plugin avoided the problem, I figured it was solely usb-storage 
related.

Besides it appears that it's more likely to be just MSystems DiskOnKey 
related, because for example a similar Fujitsu mass storage works without 
problems.
 
> And of course, if you "rmmod ehci-hcd" you'd be running using the
> companion controller (likely a NEC using "usb-ohci"), which might
> help you figure out whether the EHCI driver is even a factor in
> this case.
>
>  > Reason why I havent been moaning about this since last fall, when I first
>  > discovered this and reported, is ...
> 
> Last fall, the EHCI driver was only available to bleeding-edge hackers
> who were willing to work from CVS.  To whom did you report this?  I
> can confirm that any problem report from last fall wasn't made to the
> right people ... I surely didn't see any such report!  :)

Not about ehci, I did mail here (twice) and to sf usb-devel 
(or usb-users-devel or similar) list, but I was only talking about 
usb-storage module and DiskOnKey because, like I said, it didn't matter 
which Xhci I used, nor on what chipsets I tried it on. Late this summer I 
talked to a person who either worked for msystems (DiskOnKey manufacturer) 
or did business with them, can't remember which, and who had dug up those 
posts, and he sent mails to Matthew Dharm without reply, as far as I know. 

I know that contacting the right people is difficult, and like I said in
my previous post was that I would've looked into this and really tried 
harder, but it's just that I didn't have the time nor the need to
as aliases with the 'rmmod usb-storage' hack avoided the problem with
DiskOnKey devices.

Let me know if you want the panic prints or other tests done. 
I'll try the 2.5.39 out, but I doubt that the results will be any 
different.

-- 
Tommi Kynde Kyntola		kynde@ts.ray.fi
      "A man alone in the forest talking to himself and
       no women around to hear him. Is he still wrong?"

