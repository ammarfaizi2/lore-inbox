Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSHVTfm>; Thu, 22 Aug 2002 15:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSHVTfm>; Thu, 22 Aug 2002 15:35:42 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:7386 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S316677AbSHVTfl>;
	Thu, 22 Aug 2002 15:35:41 -0400
Date: Thu, 22 Aug 2002 21:37:43 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Stern <stern@rowland.harvard.edu>, Dave Jones <davej@suse.de>,
       James Simmons <jsimmons@transvirtual.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch for PC keyboard driver's autorepeat-rate handling
Message-ID: <20020822193743.GA5448@win.tue.nl>
References: <Pine.LNX.4.33L2.0208221153210.672-100000@ida.rowland.org> <1030037462.3090.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030037462.3090.1.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 06:31:02PM +0100, Alan Cox wrote:
> On Thu, 2002-08-22 at 16:59, Alan Stern wrote:
> > properly?  The error is not in the program; it's in the kernel's
> > handling of the KDKBDREP ioctl.  This patch fixes the following three
> > mistakes:
> > 
> > 	The .rate member of struct kbd_repeat is actually a repeat
> > 	_period_ measured in msec; the driver interprets it as a
> > 	repeat _rate_ in characters per second.
> > 
> > 	The driver returns the _prior_ values of the rate and delay
> > 	settings rather than the _current_ values.
> > 
> > 	The driver looks for an exact match for the rate and delay
> > 	values rather than using the closest match.
> 
> Since its done what it does now since about 1991, it would be better to
> fix the documentation if in fact there is an error.

I am not so sure. The KDKBDREP is a very recent (2.4test/prerelease-to-final)
addition to the stock kernel. The kbdrate program is much older, and of course
used /dev/port - we had this discussion not too long ago.

Today kbdrate tries (i) KDKBDREP, (ii) KIOCSRATE, (iii) /dev/port.

What it does for KDKBDREP is conform the text of kd.h, and I think
conform what m68k has done for years (but I've never seen the m68k patch).
Alan Stern is entirely right that the current 2.4 kernels and the
current kbdrate program have different ideas about what KDKBDREP does.

One of the two has to be fixed. Preferably in such a way that ancient
m68k behaviour does not change. Does anyone have this old m68k patch?

Andries
