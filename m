Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbUDSNxu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbUDSNvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:51:39 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:5998 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264446AbUDSNuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:50:25 -0400
Date: 19 Apr 2004 13:50:18 -0000
Message-ID: <20040419135018.4987.qmail@mercury.domedata.com>
From: tabris@tabris.net
Subject: Re: /dev/psaux-Interface
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: Jamie Lokier <jamie@shareable.org>, Arjan van de Ven <arjanv@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Tuukka Toivonen <tuukkat@ee.oulu.fi>,
       b-gruber@gmx.de, linux-kernel@vger.kernel.org
X-Originating-IP: 209.172.11.246
X-Mailer: Usermin 1.040
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bound1082382617"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--bound1082382617
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Sau Dan Lee <danlee@informatik.uni-freiburg.de> wrote ..
> >>>>> "Jamie" =3D=3D Jamie Lokier <jamie@shareable.org> writes:
> 
>     >> The input layer tries to do the same wrt HID devices and imo it
>     >> makes sense. Why should userspace care if a mouse is attached
>     >> to the USB port or via the USB->PS/2 connector thingy to the
>     >> PS/2 port.
> 
    I'd jump in here at a better point in the thread, but I'm at work right now and this is the only message I can reply to atm...

    I personally have the following problem. I have two mice, one a MS PS/2 Intellimouse. the second, a Logitech optomechanical cordless mouse (and keyboard too) attached via USB (both mouse and keyboard use same receiver as well as USB connection)

    The PS/2 mouse, which requires me to either have the driver built-in, or to manually modprobe, works more or less fine, in both X and console (using GPM). But, my USB mouse, which works fine in X, screws up in console mode. I'm using GPM's repeater function for X.

    Basically what happens is that the USB mouse can move around, but I can't use the buttons. It echoes some of the control codes to my console, and hence makes it useless for cutting and pasting.

    Admittedly, I could just hook up the mouse and keyboard to the PS/2 ports using some adapters, bypassing the USB. and it would probably work. But, why? Why is this broken in 2.6, but not in 2.4?


> Isn't it  possible to use  the PS/2 AUX  port for purposes  other than
> HID?  In 2.4,  /dev/psaux looks like /dev/ttyS1 to  the userspace.  Is
> there a good reason to make them different in 2.6?
> 
> 
<snip discussion of Modems> 
> SEPARATION  of POLICY  and MECHANISM  is an  important concept  in the
> design of unix.
> 
> 
<snip discussion of graphics cards> 
> 
> 
>     >> Requiring different configuration for both cases, and
>     >> potentially even requiring different userspace applications for
>     >> each type make it sound like abstracting this away from
>     >> userspace does have merit.
> 
> You still need to configure your kernel by means of boot parameters or
> module options.  Are users  already complaining about surprising mouse
> sensitivity?  Don't  they need to  tune some parameters to  obtain the
> desired behaviours?  I can't see  how you can do fewer configurations,
> or avoid them at all.
> 
> 
>     Jamie> I agree in this case: the touchpad should be handled by the
>     Jamie> input layer, for uniformity if nothing else.
> 
> But why not do it in a user-space daemon?  GPM has been doing that for
> 10  years already,  and  it has  been  doing it  quite  well.  I  even
> demonstrated to many  people how I configure both a  RS232 mouse and a
> PS/2  mouse to  work in  X at  the same  time, and  those  people were
> surprised that this was even possible.  Thanks to GPM.
    I agree here. Admittedly GPM isn't perfect, and should perhaps be rewritten, but it belongs in userspace.
> 
> My philosophy is: if something can be done in userspace, then do it in
> userspace.  Only leave  the essential things in kernel  space.  So, we
> don't have XFree86 in kernel space.  It's not a good idea.
> 
> Of  course,  if  performance  is  an issue,  we  may  consider  moving
> something  from userspace  into kernel:  kernel NFS  daemon, firewall.
> Isn't khttpd now removed?  Why?  
Because khttpd wasn't that useful, was a bit ugly. Also Tux superseded it. And last of all, most of the stuff that Tux patched to make things faster... were merged into mainline and made available to userspace. So that Apache could do most/all of what Tux could, in userspace, w/ little overhead/cost.
> (But even with knfsd, you still have
> the CHOICE to use a userland nfsd instead.)  I don't believe 'gpm' has
> performance problems -- the mouse port is usally 1200 baud only.
> 
> 
>     Jamie> However, what happens when the thing connected to the PS/2
>     Jamie> port isn't a mouse or keyboard, just a strange device
>     Jamie> talking bytes?  With 2.4 kernels you could talk to it.
> 
> And  now...   it's not  possible  anymore.   Assuming that  everything
> attached to the PS/2 AUX port must be a mouse is a design mistake.  It
> is like assuming that the RS232 port must be attached to a fax-modem.
> 
> 
> 
> 
> -- 
> Sau Dan LEE                     =A7=F5=A6u=B4=B0(Big5)                    ~{@nJX6X~}(HZ)
> 
> E-mail: danlee@informatik.uni-freiburg.de
> Home page: http://www.informatik.uni-freiburg.de/~danlee
> 

--bound1082382617--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--bound1082382617--
