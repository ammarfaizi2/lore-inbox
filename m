Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271241AbRHOPt1>; Wed, 15 Aug 2001 11:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271233AbRHOPtK>; Wed, 15 Aug 2001 11:49:10 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:3340 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S271242AbRHOPss>; Wed, 15 Aug 2001 11:48:48 -0400
Message-ID: <3B7A9A33.5A649036@t-online.de>
Date: Wed, 15 Aug 2001 17:50:11 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kurt Garloff <garloff@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make psaux reconnect adjustable
In-Reply-To: <20010814170306.Q1085@gum01m.etpnet.phys.tue.nl> <Pine.LNX.4.33.0108140954390.1679-100000@penguin.transmeta.com> <20010814232947.A16332@gum01m.etpnet.phys.tue.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Garloff wrote:
> 
> On Tue, Aug 14, 2001 at 09:58:55AM -0700, Linus Torvalds wrote:
> >  - do we actually need the config switch AT ALL, whether at bootup or not?
> >    What exactly breaks if we just always pass the AA 00 values through?
> >    Apparently nothing ever breaks, which makes me suspect that people are
> >    just being unnecessarily defensive.
> >
> > In short, I'd prefer a patch that just unconditionally removes the code,
> > unless somebody KNOWS that it could break something. That failing, a
> > simple kernel command line option sounds better than more files in /proc.

Linus, no more boot options (and no more files in /proc), please.

Don't push policy on users when there is a perfect, simple and _user-friendly_ solution.

> 
> OK, here come two patches. The first one removes the special PSAUX reconnect
> handling completely. So userspace should handle it. (Which is possible; just
> not implemented in gpm/X11 at this time AFAIK.)
> 
> Second patch reintroduces the special handling again, but does
> * react on AA 00 instead of just AA, thus much less likely breaking other
>   drivers (such as synps2). All PS/2 mouses I could access (about 5
>   different models) produced AA 00, so this seems OK.
> * is disabled by default, and needs to be enabled by the psaux-reconnect
>   boot parameter, like in 2.2.19.

Your patch for "AA 00" is preferable over current state "AA" (<=2.4.8)

ioctl is preferable over sysctl. Aware drivers do "ioctl("/dev/psaux", PS2_TRANSPARENT)".

run-time configuration is preferable over a boot parameter (see above about user-friendliness).

Not breaking current behaviour ("reconnecting 3-byte protocol mice works perfectly") is preferable.
