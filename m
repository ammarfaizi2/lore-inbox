Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbTDOICz (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 04:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264393AbTDOICy (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 04:02:54 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:32645 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S264392AbTDOICo (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 04:02:44 -0400
Date: Tue, 15 Apr 2003 10:14:20 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k IDE updates
In-Reply-To: <16027.14047.217861.806425@nanango.paulus.ozlabs.org>
Message-ID: <Pine.GSO.4.21.0304151012390.26578-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Apr 2003, Paul Mackerras wrote:
> Geert Uytterhoeven writes:
> > I think the least-intrusive solution is something like this:
> > 
> > --- linux-2.5/drivers/ide/ide-iops.c.orig	Mon Apr 14 21:43:30 2003
> > +++ linux-2.5/drivers/ide/ide-iops.c	Mon Apr 14 21:44:53 2003
> > @@ -423,8 +423,7 @@
> >   */
> >  void ide_fix_driveid (struct hd_driveid *id)
> >  {
> > -#ifndef __LITTLE_ENDIAN
> > -# ifdef __BIG_ENDIAN
> > +    if (ide_driveid_needs_swapping(id)) {
> 
> I really think that whether the driveid needs swapping should be
> regarded as a property of the interface, not of the system as a whole.
> 
> I like the idea of adding a "read in driveid" function pointer to the
> ide_hwif_t structure.  Most systems would set that to the same as the
> INSW function pointer.  For those systems where the hardware designer
> suffered a momentary dizzy spell we can set it to point to a function
> that does the necessary byte-swapping.

That sounds OK to me.

But I'd like to have the actual swapping code in a common source or header
file, else we fall back to the old approach, where all platforms that needed it
implemented there own driveid swapping code, which had to be kept in sync when
more reserved fields in the driveid got an actual meaning.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

