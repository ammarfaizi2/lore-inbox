Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278242AbRJMCJl>; Fri, 12 Oct 2001 22:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278243AbRJMCJb>; Fri, 12 Oct 2001 22:09:31 -0400
Received: from h24-76-51-121.vf.shawcable.net ([24.76.51.121]:63133 "EHLO
	whiskey.enposte.net") by vger.kernel.org with ESMTP
	id <S278242AbRJMCJW>; Fri, 12 Oct 2001 22:09:22 -0400
Date: Fri, 12 Oct 2001 19:09:19 -0700
From: Stuart Lynne <sl@lineo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups
Message-ID: <20011012190919.J7155@fireplug.net>
Reply-To: Stuart Lynne <sl@lineo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vonbrand@sleipnir.valparaiso.cl said:

> Matt_Domsch@Dell.com said:
> > > That leaves (a) unconditionally building 
> > > it into the kernel, or (b) Makefile and Config.in rules.
> 
> > (a) is simple, but needs a 1KB malloc (or alternately, a 1KB static const
> > array - I've taken the approach that the malloc is better)
> 
> Better static (less overhead in size and at runtime), initialized at build
> time (you could compute it then). In case of _dire_ kernel size problems, it
> can be left out anyway. AFAIU, there are now a _lot_ of copies of this
> around, so you'll win overall in any case.
> 
> > (b) isn't that much harder, but requires drivers to be sure to call
> > init_crc32 and cleanup_crc32.  If somehow they manage not to do that, Oops.
> > I don't want to add a runtime check for the existance of the array in
> > crc32().

I have to agree. A single global config that controls if CRC32 is available
as a static table, and an inline function that allows me to use it. 

Any module that tries to use it will either not compile or if will not load 
due an unresolved address.

Least impact. Simplest API. The lowest overhead for kernels that do or do
not need CRC. 

We should probably provide CRC10 and CRC16 as well.

-- 
                                            __O 
Lineo - Where Open  Meets Smart           _-\<,_ 
PGP Fingerprint: 28 E2 A0 15 99 62 9A 00 (_)/ (_) 88 EC A3 EE 2D 1C 15 68
Stuart Lynne <sl@lineo.com>            www.lineo.com         604-461-7532
