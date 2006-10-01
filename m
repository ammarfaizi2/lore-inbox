Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWJAJO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWJAJO1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 05:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbWJAJO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 05:14:27 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:39308 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1751768AbWJAJO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 05:14:26 -0400
Date: Sun, 1 Oct 2006 11:14:11 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ismail Donmez <ismail@pardus.org.tr>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Andrew Morton <akpm@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>, mchehab@infradead.org
Subject: Re: __STRICT_ANSI__ checks in headers
Message-ID: <20061001091411.GA9647@uranus.ravnborg.org>
References: <200609150901.33644.ismail@pardus.org.tr> <20060930215343.548f5cd9.akpm@osdl.org> <110413A1-7699-4DDB-9997-C3DA9E9DDB46@mac.com> <200610011034.57158.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610011034.57158.ismail@pardus.org.tr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2006 at 10:34:56AM +0300, Ismail Donmez wrote:
> On Sunday 01 October 2006 08:20, Kyle Moffett wrote:
> > On Oct 01, 2006, at 00:53:43, Andrew Morton wrote:
> [...]
> > > Bisection shows that this patch causes these depmod warnings:
> > >
> > > WARNING: "snd_card_disconnect" [sound/usb/usx2y/snd-usb-usx2y.ko]
> > > has no CRC!
> > > [etc]
> > >
> > > I don't know why that would happen.
> > >
> > > From: Ismail Donmez <ismail@pardus.org.tr>
> > >
> > > __STRICT_ANSI__ usage in types.h header results in compile errors
> > > for some userspace packages[1] when used with gcc -ansi flag.  With
> > > the suggestion of Kyle Moffett I replace strict ansi checks with
> > > __extension__ to tell gcc not to error or warn on gcc extensions.
> > > Compile tested on x86 with 2.6.18.
> >
> > Best guess:  Depmod does some kind of funny type-based expansion and
> > hashing of the symbols which doesn't understand the "__extension__"
> > keyword.  Probably the simplest thing to do is to add "-
> > D__extension__=" to the depmod preprocessing flags.  Alternatively
> > you could teach depmod to completely ignore the __extension__ keyword
> > when it shows up in the sources, but the former seems like it would
> > be much simpler.
> >
> > Just thinking about it we probably also need to educate sparse about
> > __extension__ too.  Perhaps somebody could also add an sparse flag to
> > make it warn about nonportable constructs in exported header files.
> >
> > I'd submit a patch but my knowledge of kernel makefiles and depmod is
> > somewhere between zero and none, exclusive.
> 
> Thanks, I will have a look at it.
I assume you will same errors from the in-kernel modpost.
If you do not do so then there is some inconsistency between depmod
and modpost that ougth to be fixed.

I'm not up to the task atm - busy with my day job and travelling a lot

	Sam
