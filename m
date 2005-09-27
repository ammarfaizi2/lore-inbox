Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbVI0QfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbVI0QfB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 12:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbVI0QfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 12:35:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32745 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965000AbVI0QfA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 12:35:00 -0400
Date: Tue, 27 Sep 2005 17:34:55 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Hirokazu Takata <takata@linux-m32r.org>, torvalds@odsl.org,
       linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH] m32r: set CHECKFLAGS properly
Message-ID: <20050927163455.GT7992@ftp.linux.org.uk>
References: <E1EJlNM-00059K-R8@ZenIV.linux.org.uk> <20050927.151301.189720995.takata.hirokazu@renesas.com> <20050927071025.GS7992@ftp.linux.org.uk> <CFD86C0A-0BE4-4D39-BAAE-F985D997AFD2@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFD86C0A-0BE4-4D39-BAAE-F985D997AFD2@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 11:13:44AM -0400, Kyle Moffett wrote:
> On Sep 27, 2005, at 03:10:25, Al Viro wrote:
> >You do realize that this way sparse will get neither?  It does not  
> >pick predefined symbols from gcc; thus the -D<your_arch>, etc.
> 
> How about sticking this in some global Makefile somewhere?  This will  
> give sparse the same list of defines that GCC uses:
> 
> CHECKFLAGS += $(shell echo | gcc -E - -dM | sed -re 's/^#define +([^ ] 
> +) +(.*)$/-D\1=\2/g')
> 
> Or you could do this:
> 
> include/linux/checkerdefines.h:
>         echo | gcc -E - -dM >$@

*Hell*, no.
	1) any use of cross-gcc is immediately b0rken
	2) anything like building i386 on amd64 (native toolchain, -m32
in arguments) is b0rken
	3) way, way, *WAY* too much spew.  gcc pre-defines shitloads of
stuff and some of that stuff very definitely should not be there for sparse.

IOW, it's not that simple.  You need final CC, CFLAGS and CPPFLAGS for
that.  Moreover, your variant won't do at all - change .config and you
might need to rebuild that file on biarch platforms (parisc and s390 at
the very least; ppc/ppc64 are also moving in that direction).
