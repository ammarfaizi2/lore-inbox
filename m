Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288878AbSBMU2S>; Wed, 13 Feb 2002 15:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288859AbSBMU2I>; Wed, 13 Feb 2002 15:28:08 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:51759 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S288878AbSBMU16>; Wed, 13 Feb 2002 15:27:58 -0500
Date: Wed, 13 Feb 2002 15:27:56 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: LDT_ENTRIES in ldt.h: why 8192?
Message-ID: <20020213152756.F21624@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20020213121848.A31469@mallard.plaza.ds.adp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020213121848.A31469@mallard.plaza.ds.adp.com>; from setha@plaza.ds.adp.com on Wed, Feb 13, 2002 at 12:18:48PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 12:18:48PM -0800, Seth D. Alford wrote:
> I'm getting "ldt allocation failures" on one of my systems.  I know of Manfred
> Spraul's patch for this for 2.4.17.  I'm using 2.4.12, though, and was
> wondering about an alternate solution.  What would happen if LDT_ENTRIES was
> reduced, to, say, 4096, or 512, instead of 8192?
> 
> .../include/asm-i386/ldt.h specifies:
> 
> 	/* Maximum number of LDT entries supported. */
> 	#define LDT_ENTRIES	8192
> 
> This was set to 8192 in version 0.99.15, in December, 1993, according to what I
> could find by retrieving different revisions of the kernel.

E.g. linuxthreads can eat up to 1024 LDT entries, but that's not very common.
IMHO there should be a single entry LDT, the emulation 5 entry LDT (current
default_ldt), 512 entries LDT (page) and then the full blown 8192 entries
LDT variants. Will post a patch once I finish it.

	Jakub
