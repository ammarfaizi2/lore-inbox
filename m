Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278125AbRJLUei>; Fri, 12 Oct 2001 16:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278126AbRJLUe2>; Fri, 12 Oct 2001 16:34:28 -0400
Received: from nsd.mandrakesoft.com ([216.71.84.35]:46965 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S278125AbRJLUeW>; Fri, 12 Oct 2001 16:34:22 -0400
Date: Fri, 12 Oct 2001 15:34:33 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Matt_Domsch@Dell.com
cc: vonbrand@inf.utfsm.cl, linux-kernel@vger.kernel.org
Subject: RE: crc32 cleanups
In-Reply-To: <71714C04806CD51193520090272892178BD709@ausxmrr502.us.dell.com>
Message-ID: <Pine.LNX.3.96.1011012153014.31508A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001 Matt_Domsch@Dell.com wrote:
> > That leaves (a) unconditionally building 
> > it into the kernel, or (b) Makefile and Config.in rules.
> 
> (a) is simple, but needs a 1KB malloc (or alternately, a 1KB static const
> array - I've taken the approach that the malloc is better)
> (b) isn't that much harder, but requires drivers to be sure to call
> init_crc32 and cleanup_crc32.  If somehow they manage not to do that, Oops.
> I don't want to add a runtime check for the existance of the array in
> crc32().

You are talking about the data; I was talking about the code.

I do not think kernels need the data table, kmalloc'd or statically
built, unless it will be used.  That implies a refcounting scheme.
[WRT "Oops", that is a driver bug, not a case to be considered.  In
Linuxland we do not write code to protect us from rogue code.]

I was pondering whether it was ok to unconditionally include the
lib/crc32.c code, regardless of need.  I am leaning towards "no," which
implies Makefile and Config.in rules which must be updated for each
driver that uses crc32.

	Jeff



