Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278235AbRJMBUM>; Fri, 12 Oct 2001 21:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278236AbRJMBUC>; Fri, 12 Oct 2001 21:20:02 -0400
Received: from nsd.mandrakesoft.com ([216.71.84.35]:22113 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S278235AbRJMBTs>; Fri, 12 Oct 2001 21:19:48 -0400
Date: Fri, 12 Oct 2001 20:20:02 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
cc: Matt_Domsch@Dell.com, linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups 
In-Reply-To: <200110130109.f9D19cZj023657@sleipnir.valparaiso.cl>
Message-ID: <Pine.LNX.3.96.1011012201638.20962A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001, Horst von Brand wrote:
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
> 
> KISS: Keep It Simple, Stupid. Unless it won't cut it, that is.

Currently we are only talking about one CRC table, but we can set up
two crc tables, if we consider ether_crc_be as well.

Being static definitely has the advantage of not needing the refcounting
scheme; it really depends on what the code size looks like in the end,
with and without a statically-calculated CRC table.

	Jeff



