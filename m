Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262907AbUDULZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbUDULZM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 07:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbUDULZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 07:25:12 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:63423 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S262907AbUDULY7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 07:24:59 -0400
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: arjanv@redhat.com, Andrew Morton <akpm@osdl.org>,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>, b-gruber@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux-Interface
References: <Pine.GSO.4.58.0402271451420.11281@stekt37>
	<Pine.GSO.4.58.0404191124220.21825@stekt37>
	<20040419015221.07a214b8.akpm@osdl.org>
	<xb77jwci86o.fsf@savona.informatik.uni-freiburg.de>
	<1082372020.4691.9.camel@laptop.fenrus.com>
	<16518.20890.380763.581386@cse.unsw.edu.au>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 21 Apr 2004 13:24:56 +0200
In-Reply-To: <16518.20890.380763.581386@cse.unsw.edu.au>
Message-ID: <xb71xmhfu9j.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Neil" == Neil Brown <neilb@cse.unsw.edu.au> writes:

    Neil> I agree that it is good for the kernel to provide hardware
    Neil> abstractions, and that "mouse" is an appropriate device to
    Neil> provide an abstract interface for.

So, the next  step is to port efax or Hylafax  into kernel space.  Why
leave the /dev/ttyS? hanging out there?  Why not encapsulated them and
provide a /dev/fax that does what efax or Hylafax do?

And then, it's time to port  Ghostscript and lpd into the kernel.  Why
leave the raw /dev/lp0 there?   Why not move abstract them and provide
a   /dev/postscript_printer  instead?   Why   lpd?   Have   a  virtual
filesystem pqfs, so  that we can easily copy  postscript files to that
fs  (instead of  lpr), use  ls to  inspect what  print jobs  are there
(instead of lpq) and use rm to remove pending jobs (instead of lprm)?


    Neil> It does not follow that all drivers below that abstraction
    Neil> should live in the kernel.

Exactly!   Look at  autofs and  nfs.   The respective  daemons are  in
userland (I know  there is knfsd -- as a OPTION).   Why?  Why not move
them into the kernel altogether?  What's the advantage of implementing
these daemons  in userland?  That's exactly the  advantage of handling
mouse protocol using a gpm-like program.



    Neil> I have a userspace program that talks to my ALPS touchpad
    Neil> (through a hacked /dev/psaux that talks direct to the psaux
    Neil> port) and converts taps etc into "input layer" messages that
    Neil> are passed back into /dev/input/uinput.

That's  what I  have  in mind:  have  a userland  daemon that  bridges
between the  raw port and  uinput.  This leaves great  flexibility for
the daemon  to do  whatever the writer  feel appropriate.  I  hope you
agree that it is easier to  develop and debug programs in userland and
in  kernel space.   Providing  API  for such  a  daemon would  provide
fertile soil for people to implement different useful things.


BTW, how did you hack the /dev/psaux?


    Neil> I did consider writing a kernel driver for the ALPS
    Neil> touchpad, but due to the dearth of documentation and the
    Neil> fact that it seemed very hard to automatically detect it, I
    Neil> decided that such a driver would be too hard to support.

So,  writing userland  programs are  generally easier  than  having to
touch the kernel -- even when  you're just writing a module.  A daemon
that seg-faults doesn't hurt.  A  daemon that runs into infinite loops
can  be killed.  It's  much safer  and easier  to implement  the mouse
protocol interpreter in userland.  And I guess 'gpm' and its dozens of
drivers  can  be  more   easily  transformed  into  a  bridge  between
/dev/psaux or /dev/ttyS? (or even a TCP/UDP socket!) and uinput.  I'll
bet on gpm, given its maturity vs. the kernel 2.6 mouse drivers.



    Neil> So here is my vote in favour of "Let's make /dev/psaux a
    Neil> clean channel to the PS/AUX device" - at least
    Neil> conditionally.

I second!  Let's  free /dev/psaux.  We want the  /dev/psaux as in 2.4,
2.2, 2.0, ...  We don't want a faked, censored one as in 2.6.0--5.


-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

