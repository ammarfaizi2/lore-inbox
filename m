Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130570AbRCFMMB>; Tue, 6 Mar 2001 07:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130616AbRCFMLv>; Tue, 6 Mar 2001 07:11:51 -0500
Received: from nas11-81.wms.club-internet.fr ([213.44.38.81]:64759 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S130570AbRCFMLk>;
	Tue, 6 Mar 2001 07:11:40 -0500
Message-Id: <200103061210.NAA17114@microsoft.com>
Subject: Re: kmalloc() alignment
From: Xavier Bestel <xavier.bestel@free.fr>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200103060831.JAA04492@cave.bitwizard.nl>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution (0.8/+cvs.2001.02.16.08.55 - Preview Release)
Date: 06 Mar 2001 13:10:11 +0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06 Mar 2001 09:31:01 +0100, Rogier Wolff a écrit :
> 
> > Followup to:  <20010306000652.A13992@excalibur.research.wombat.ie>
> > By author:    Kenn Humborg <kenn@linux.ie>
> > In newsgroup: linux.dev.kernel
> > >
> > > On Sun, Mar 04, 2001 at 11:41:12PM +0100, Manfred Spraul wrote:
> > > > >
> > > > > Does kmalloc() make any guarantees of the alignment of allocated 
> > > > > blocks? Will the returned block always be 4-, 8- or 16-byte 
> > > > > aligned, for example? 
> > > > >
> > > > 
> > > > 4-byte alignment is guaranteed on 32-bit cpus, 8-byte alignment on
> > > > 64-bit cpus.
> > > 
> > > So, to summarise (for 32-bit CPUs):
> > > 
> > > o  Alan Cox & Manfred Spraul say 4-byte alignment is guaranteed.
> > > 
> > > o  If you need larger alignment, you need to alloc a larger space,
> > >    round as necessary, and keep the original pointer for kfree()
> > > 
> > > Maybe I'll just use get_free_pages, since it's a 64KB chunk that
> > > I need (and it's only a once-off).
> 
> My old kmalloc would actually use n+10 bytes if you request n bytes.
> As memory comes in pools of powers of two, if you request 64k, you
> would acutaly use 128k of memory. If you use "get_free_pages", you'll
> not have the overhead, and actually allocate the 64k you need. 
> 
> I'm not sure what the slab stuff does...

A properly initialised (i.e. default settings) 64k slab would put object
descriptors outside the slab itself, and so use the expected number of
pages for each 64k object, I believe.
Small or non n*512 sized objects are a different story.

Xav

