Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262157AbSI1Qem>; Sat, 28 Sep 2002 12:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262168AbSI1Qem>; Sat, 28 Sep 2002 12:34:42 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:15535 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S262157AbSI1Qek>; Sat, 28 Sep 2002 12:34:40 -0400
Date: Sat, 28 Sep 2002 09:40:27 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: USB Mass Storage Hangs
To: Tommi Kyntola <kynde@ts.ray.fi>
Cc: linux-kernel@vger.kernel.org
Message-id: <3D95DB7B.1040401@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > And are both of these devices USB 2.0 devices?  If so, you might want to
 > > try the 2.4.20-pre kernels, it has much better USB 2.0 support than the
 > > kernel you are using.
 >
 > I can still panic even the 2.4.20-pre8, by ...

Actually, even pre8 doesn't have the updates that would matter
for something like this ... the "better" was mostly not oopsing
if you unplug a hub (it was a hub driver bug).  You'd need some
patches that aren't yet in Marcelo's tree, but which HAVE been
pasted here on LKML.  (And people who've tried them have said
the patches have improved things for them.)

Have a look at these posts, which are slightly updated versions of
what's been posted to LKML (patches in the second two):

    http://marc.theaimsgroup.com/?l=linux-usb-devel&m=103288096812331&w=2
    http://marc.theaimsgroup.com/?l=linux-usb-devel&m=103288089912220&w=2
    http://marc.theaimsgroup.com/?l=linux-usb-devel&m=103283868910428&w=2

Alternatively, try this out on 2.5.latest ... those patches give
2.4.20-pre7 (or pre8) the same EHCI code as seen in 2.5.39, but
if you try 2.5.39 you'll benefit from some usb-storage fixes too.

And of course, if you "rmmod ehci-hcd" you'd be running using the
companion controller (likely a NEC using "usb-ohci"), which might
help you figure out whether the EHCI driver is even a factor in
this case.


 > Reason why I havent been moaning about this since last fall, when I first
 > discovered this and reported, is ...

Last fall, the EHCI driver was only available to bleeding-edge hackers
who were willing to work from CVS.  To whom did you report this?  I
can confirm that any problem report from last fall wasn't made to the
right people ... I surely didn't see any such report!  :)

- Dave



