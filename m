Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284220AbRLAUGK>; Sat, 1 Dec 2001 15:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284221AbRLAUGA>; Sat, 1 Dec 2001 15:06:00 -0500
Received: from marine.sonic.net ([208.201.224.37]:51242 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S284220AbRLAUFq>;
	Sat, 1 Dec 2001 15:05:46 -0500
X-envelope-info: <dhinds@sonic.net>
Date: Sat, 1 Dec 2001 12:05:41 -0800
From: David Hinds <dhinds@sonic.net>
To: Ian Morgan <imorgan@webcon.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dhinds@zen.stanford.edu
Subject: Re: in-kernel pcmcia oopsing in SMP
Message-ID: <20011201120541.B28295@sonic.net>
In-Reply-To: <Pine.LNX.4.40.0112011406040.2329-100000@light.webcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0112011406040.2329-100000@light.webcon.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 02:21:33PM -0500, Ian Morgan wrote:
> On a few SMP boxes here, with kernels from about 2.4.14 though 2.4.17-pre2,
> the system locks up hard during heavy wireless I/O.

The bug pretty much has to be in the orinoco driver; I'm not sure how
much stress testing it has had on SMP.

> (Some have said the kernel pcmcia stuff is still immature, but Hinds'
> pcmcia-cs package doesn't work at all for me. It's ds.o keeps oopsing when
> insmod'ed, so I can't even try it.)

I did fix one major SMP bug in the pcmcia-cs drivers just a couple
days ago; the beta at http://pcmcia-cs.sourceforge.net/ftp/NEW has the
fix.  I'm not sure if it is really the same bug you describe, though,
since no one else has reported the ds module causing an immediate
oops.

The standalone drivers are unlikely to help, though, because the
orinoco_cs driver in the standalone package is virtually identical to
the one in the current 2.4.* kernel.

Actually, though, you could try the (older) wvlan_cs driver in the
pcmcia-cs package.  You can do that with your current kernel drivers,
even.  Unpack the pcmcia-cs package, do "make config", then cd to the
wireless subdirectory and do a "make" there.  That should build a
wvlan_cs module that will mesh with your kernel PCMCIA subsystem.  It
will at least give you another data point.

I don't know how to interpret your oops report; you should probably
also forward the bug to David Gibson, hermes@gibson.dropbear.id.au,
since he is the orinoco maintainer.

-- Dave
