Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316592AbSGGWYA>; Sun, 7 Jul 2002 18:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316594AbSGGWX7>; Sun, 7 Jul 2002 18:23:59 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:47118 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316592AbSGGWX5>;
	Sun, 7 Jul 2002 18:23:57 -0400
Date: Sun, 7 Jul 2002 15:24:17 -0700
From: Greg KH <greg@kroah.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020707222417.GC18298@kroah.com>
References: <Pine.LNX.4.44L.0207061306440.8346-100000@imladris.surriel.com> <3D27390E.5060208@us.ibm.com> <20020707205543.GA18298@kroah.com> <3D28B423.9060903@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D28B423.9060903@us.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Sun, 09 Jun 2002 19:34:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 02:35:31PM -0700, Dave Hansen wrote:
> 
>  "As long as I comment [and understand] why I am using the BKL." 
> would be a bit more accurate.  How many places in the kernel have you 
> seen comments about what the BKL is actually doing?  Could you point 
> me to some of your comments where _you_ are using the BKL?  Once you 
> fully understand why it is there, the extra step of removal is usually 
> very small.

I have never written any kernel code that added usages of the BKL.  The
fact that I am now maintaining code that uses it should not be confused
with this.  Yes, some of my filesystems (pcihpfs and usbfs) now use it,
but that was due to other people pushing it down, out of the VFS.

> >>A lock with a single purpose, guarding relatively small amounts of 
> >>data is much easier to understand than one such as the BKL.  Would you 
> >>want a simple VM operation to take 1 second as the TTY layer and ext3 
> >>take their sweet time with the BKL?
> >
> >If ext3 is spinning on the BKL, then try to fix that, as it seems like a
> >worthwhile task (like the ext2 changes proved.)  If you want to remove
> >the BKL from the tty layer, be my guest, that will involve rewriting
> >that whole subsystem :)
> 
> All that I'm saying is that there can be unintended consequences.  By 
> having it in your code, you open the possibility of these strange 
> interactions and a drop in _your_ code's reliability.

Yes, and there can be unintended conequences for just blindly removing
the BKL as your input layer patch proved.  The input layer was using the
BKL in a reliable manner, it just wasn't documented.  And by using the
BKL in my code, it does not decrease reliability in any way (just might
slow it down under some system loads, but it still works properly.)

> I'm staying well away from the TTY layer, it is just a well known 
> example.

Ah, so it's easier to try to pick on subsystems that don't matter like
USB and driverfs?  :)

> >>I would mind the BKL a lot less if it was as well understood 
> >>everywhere as it is in VFS.  The funny part is that a lock like the 
> >>BKL would not last very long if it were well understood or documented 
> >>everywhere it was used.
> >
> >I would mind it a whole lot less if when you try to remove the BKL, you
> >do it correctly.  So far it seems like you enjoy doing "hit and run"
> >patches, without even fully understanding or testing your patches out
> >(the driverfs and input layer patches are proof of that.)  This does
> >nothing but aggravate the developers who have to go clean up after you.
> 
> Like it or not, the only way to get maintainers to pay any attention 
> at all is to give them code.  Is there more likely to be progress if I 
> just say, "Hey Greg, why don't you take the BKL out of USB", or if I 
> send you a crappy patch which has the beginning of a valid approach? 
> Code gets people thinking.

Either way, you get my same response, "Why?"  Again, as someone stated,
where in the USB code is the BKL used that affects performance in any
real life situations?

And yes, sending crappy patches does get people jumping, but don't rely
on that being a good method of doing development.  People only fall for
that one so many times.

greg k-h
