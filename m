Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315347AbSEBSlf>; Thu, 2 May 2002 14:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315348AbSEBSle>; Thu, 2 May 2002 14:41:34 -0400
Received: from dsl-213-023-038-046.arcor-ip.net ([213.23.38.46]:39072 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315347AbSEBSlc>;
	Thu, 2 May 2002 14:41:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Roman Zippel <zippel@linux-m68k.org>
Subject: Re: discontiguous memory platforms
Date: Thu, 2 May 2002 20:39:52 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>, Ralf Baechle <ralf@uni-koblenz.de>,
        Russell King <rmk@arm.linux.org.uk>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0205022032280.27986-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E173LUk-00027L-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 20:35, Geert Uytterhoeven wrote:
> On Thu, 2 May 2002, Roman Zippel wrote:
> > On Thu, 2 May 2002, Andrea Arcangeli wrote:
> > > What I
> > > care about is not to clobber the common code with additional overlapping
> > > common code abstractions.
> > 
> > Just to throw in an alternative: On m68k we map currently everything
> > together into a single virtual area. This means the virtual<->physical
> > conversion is a bit more expensive and mem_map is simply indexed by the
> > the virtual address.
> > It works nicely, it just needs two small patches in the initializition
> > code, which aren't integrated yet. I think it's very close to what Daniel
> > wants, only that the logical and virtual address are identical.
> 
> I also want to add that the order (by address) of the virtual chunk is not
> necessarily the same as the order (by address) of the physical chunks.
> 
> So it's perfect possible to put the kernel in the second physical chunk, in
> which case the first physical chunk (with a lower physical address) ends up in
> the virtual list behind the first physical chunk.
> 
> IIRC (/me no Linux mm whizard), the above reason was the main reason why the
> current zone system doesn't work well for m68k boxes (mainly talking about
> Amiga).

Config_nonlinear will handle this situation without difficulty.

-- 
Daniel
