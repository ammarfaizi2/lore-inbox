Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278758AbRJZRE4>; Fri, 26 Oct 2001 13:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278746AbRJZREr>; Fri, 26 Oct 2001 13:04:47 -0400
Received: from t2.redhat.com ([199.183.24.243]:60663 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S278758AbRJZREm>;
	Fri, 26 Oct 2001 13:04:42 -0400
Date: Fri, 26 Oct 2001 10:03:46 -0700
From: Richard Henderson <rth@redhat.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: alpha 2.4.13: fix taso osf emulation
Message-ID: <20011026100346.C1663@redhat.com>
In-Reply-To: <20011026013101.A1404@redhat.com> <Pine.GSO.3.96.1011026113847.14048A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1011026113847.14048A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Oct 26, 2001 at 12:01:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2001 at 12:01:10PM +0200, Maciej W. Rozycki wrote:
>  The following trivial patch reportedly fixes OSF/1 programs using 31-bit
> addressing.  It's already present in the -ac tree; I guess it just got
> lost during a merge.  It applies fine to 2.4.13. 

This is the patch that Jay Estabrook forwarded me that I rejected
in favour of writing a special arch_get_unmapped_area.

> It used to do so.  It breaks things such as dynamic linking of shared
> objects linked at high load address.

Err, how?

> It breaks mmap() in principle, as it shouldn't fail when invoked with
> a non-zero, non-MAP_FIXED, invalid address if there is still address
> space available elsewhere. 

No, it doesn't.  Or rather, it only does if you only bothered
to search once.  IMO one should search thrice: once at addr,
once at TASK_UNMAPPED_BASE, and once at PAGE_SIZE.



r~
