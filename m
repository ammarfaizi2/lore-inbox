Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbUDSLrq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 07:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbUDSLrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 07:47:46 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:47856 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S264375AbUDSLr1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 07:47:27 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>, b-gruber@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux-Interface
References: <Pine.GSO.4.58.0402271451420.11281@stekt37>
	<Pine.GSO.4.58.0404191124220.21825@stekt37>
	<20040419015221.07a214b8.akpm@osdl.org>
	<xb77jwci86o.fsf@savona.informatik.uni-freiburg.de>
	<1082372020.4691.9.camel@laptop.fenrus.com>
	<20040419111831.GA13759@mail.shareable.org>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 19 Apr 2004 13:47:24 +0200
In-Reply-To: <20040419111831.GA13759@mail.shareable.org>
Message-ID: <xb7y8osgpf7.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jamie" == Jamie Lokier <jamie@shareable.org> writes:

    >> The input layer tries to do the same wrt HID devices and imo it
    >> makes sense. Why should userspace care if a mouse is attached
    >> to the USB port or via the USB->PS/2 connector thingy to the
    >> PS/2 port.

Isn't it  possible to use  the PS/2 AUX  port for purposes  other than
HID?  In 2.4,  /dev/psaux looks like /dev/ttyS1 to  the userspace.  Is
there a good reason to make them different in 2.6?


Imagine the kernel now hiding /dev/ttyS* and ASSUMING that all of them
are Class 2.0 fax-modems.  Instead of letting you issue the AT command
set  to the  fax-modem  and  getting the  response  directly from  the
device, the  kernel now *abstracts* that away  from usespace.  Imagine
that  the  kernel now  *forbids*  the  userspace  programs to  use  AT
commands directly.   Userspace is  now only allowed  to use  ioctls to
issue "dial", "hang  up", "receive fax page" commands.   Would that be
nice?

SEPARATION  of POLICY  and MECHANISM  is an  important concept  in the
design of unix.


And how about the display?  Shouldn't the kernel abstract it away from
userspace?   Why should  we  have different  XFree86 display  drivers?
Shouldn't they be  all implemented in kernel, so  that XFree86 and all
graphics programs only need to access the graphics system in a uniform
way, without  caring about the differences  between different graphics
adaptors?



    >> Requiring different configuration for both cases, and
    >> potentially even requiring different userspace applications for
    >> each type make it sound like abstracting this away from
    >> userspace does have merit.

You still need to configure your kernel by means of boot parameters or
module options.  Are users  already complaining about surprising mouse
sensitivity?  Don't  they need to  tune some parameters to  obtain the
desired behaviours?  I can't see  how you can do fewer configurations,
or avoid them at all.


    Jamie> I agree in this case: the touchpad should be handled by the
    Jamie> input layer, for uniformity if nothing else.

But why not do it in a user-space daemon?  GPM has been doing that for
10  years already,  and  it has  been  doing it  quite  well.  I  even
demonstrated to many  people how I configure both a  RS232 mouse and a
PS/2  mouse to  work in  X at  the same  time, and  those  people were
surprised that this was even possible.  Thanks to GPM.

My philosophy is: if something can be done in userspace, then do it in
userspace.  Only leave  the essential things in kernel  space.  So, we
don't have XFree86 in kernel space.  It's not a good idea.

Of  course,  if  performance  is  an issue,  we  may  consider  moving
something  from userspace  into kernel:  kernel NFS  daemon, firewall.
Isn't khttpd now removed?  Why?   (But even with knfsd, you still have
the CHOICE to use a userland nfsd instead.)  I don't believe 'gpm' has
performance problems -- the mouse port is usally 1200 baud only.


    Jamie> However, what happens when the thing connected to the PS/2
    Jamie> port isn't a mouse or keyboard, just a strange device
    Jamie> talking bytes?  With 2.4 kernels you could talk to it.

And  now...   it's not  possible  anymore.   Assuming that  everything
attached to the PS/2 AUX port must be a mouse is a design mistake.  It
is like assuming that the RS232 port must be attached to a fax-modem.




-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

