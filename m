Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129666AbRCFIbg>; Tue, 6 Mar 2001 03:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129686AbRCFIb0>; Tue, 6 Mar 2001 03:31:26 -0500
Received: from 13dyn176.delft.casema.net ([212.64.76.176]:64005 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129666AbRCFIbL>; Tue, 6 Mar 2001 03:31:11 -0500
Message-Id: <200103060831.JAA04492@cave.bitwizard.nl>
Subject: Re: kmalloc() alignment
In-Reply-To: <981a78$cb2$1@cesium.transmeta.com> from "H. Peter Anvin" at "Mar
 5, 2001 04:15:36 pm"
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Tue, 6 Mar 2001 09:31:01 +0100 (MET)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Followup to:  <20010306000652.A13992@excalibur.research.wombat.ie>
> By author:    Kenn Humborg <kenn@linux.ie>
> In newsgroup: linux.dev.kernel
> >
> > On Sun, Mar 04, 2001 at 11:41:12PM +0100, Manfred Spraul wrote:
> > > >
> > > > Does kmalloc() make any guarantees of the alignment of allocated 
> > > > blocks? Will the returned block always be 4-, 8- or 16-byte 
> > > > aligned, for example? 
> > > >
> > > 
> > > 4-byte alignment is guaranteed on 32-bit cpus, 8-byte alignment on
> > > 64-bit cpus.
> > 
> > So, to summarise (for 32-bit CPUs):
> > 
> > o  Alan Cox & Manfred Spraul say 4-byte alignment is guaranteed.
> > 
> > o  If you need larger alignment, you need to alloc a larger space,
> >    round as necessary, and keep the original pointer for kfree()
> > 
> > Maybe I'll just use get_free_pages, since it's a 64KB chunk that
> > I need (and it's only a once-off).

My old kmalloc would actually use n+10 bytes if you request n bytes.
As memory comes in pools of powers of two, if you request 64k, you
would acutaly use 128k of memory. If you use "get_free_pages", you'll
not have the overhead, and actually allocate the 64k you need. 

I'm not sure what the slab stuff does...

		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
