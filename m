Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbSKFBEj>; Tue, 5 Nov 2002 20:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265259AbSKFBEj>; Tue, 5 Nov 2002 20:04:39 -0500
Received: from almesberger.net ([63.105.73.239]:48905 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265250AbSKFBEg>; Tue, 5 Nov 2002 20:04:36 -0500
Date: Tue, 5 Nov 2002 22:10:50 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Andy Pfiffer <andyp@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
Message-ID: <20021105221050.A10679@almesberger.net>
References: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com> <3DC19A4C.40908@pobox.com> <20021031193705.C2599@almesberger.net> <20021105171230.A11443@in.ibm.com> <20021105150048.H1408@almesberger.net> <1036521360.5012.116.camel@irongate.swansea.linux.org.uk> <20021105161902.I1408@almesberger.net> <1036542104.2749.197.camel@andyp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036542104.2749.197.camel@andyp>; from andyp@osdl.org on Tue, Nov 05, 2002 at 04:21:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer wrote:
> You could probably skip the system call to set it up.

Yes, yes, there are many ways to do this. This isn't the issue. The
questions regarding this are:

 - it kexec allowed to use a system call ?
 - if yes, is a system call the technically right solution ?
 - if yes, is it a practical solution ?

So far, it hasn't been considered inherently wrong to use system
calls, even for highly Linux-specific functions, and even if they
aren't performance-critical (just think of pivot_root). (*)

If this perception has changed, such a change of policy would also
affect kexec, but then we don't need to discuss kexec but the
policy change. (I don't know - is such a change in the air ?)

(*) By the way, I remember now where I brought up some hack for
    avoiding to use a system call - it was for bootimg :-)

Now, if we assume that it's okay for kexec to use a system call,
the next question is whether kexec should indeed use it, i.e.
whether a system call makes sense for what it is trying to do.
Since there are no device files or network elements naturally
involved here (i.e. other major kernel function interfaces),
the answer seems to be "yes".

Last but not least, we need to decide whether using a system
call would be painful for Eric or for kexec users. This would be
the case if kexec isn't merged, and the kexec patch would need
frequent updates because system calls have changed.

I understand Alan's question as the "what if ... ?" type. If
kexec is indeed rejected for merging, it may make sense to change
the interface to something which may be technically less elegant,
but which makes patch maintenance easier to handle.

> I'll 2nd that sentiment, and add another big one: fixing (apparent)
> problems with drivers and chipset-munging code, so that devices can be
> reliably re-probed/re-inited/etc. after the reboot.

Yes, kexec is likely to turn up a few problems in this area, too.
Right now, we only hear about such issues if some BIOS lets
something slip through. With kexec, such problems should show up
sooner.

> Long term, I think it would be advantageous to be able to avoid SCSI and
> other time consuming device probes

Definitely. May I refer you to my booting paper, which discusses
all this in section 5 ? :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
