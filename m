Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbVL2VDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbVL2VDi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 16:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbVL2VDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 16:03:37 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:31927 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750972AbVL2VDh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 16:03:37 -0500
Date: Thu, 29 Dec 2005 21:03:36 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/36] m68k: fix macro syntax to make current binutils happy
Message-ID: <20051229210336.GJ27946@ftp.linux.org.uk>
References: <E1EpIOj-0004qc-HA@ZenIV.linux.org.uk> <200512262259.19230.zippel@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512262259.19230.zippel@linux-m68k.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2005 at 10:59:18PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Thursday 22 December 2005 05:49, Al Viro wrote:
> 
> > recent as(1) doesn't think that . terminates a macro name, so
> > getuser.l is _not_ treated as invoking getuser with .l as the
> > first argument.
> 
> Could you please hold back with the binutils changes? Eventually this should 
> rather be fixed in gas or they have to properly document the expected 
> behaviour, so it doesn't break the next time they change it.

Unfortunately, that one _is_ documented.  BS they've pulled with macro
arguments ("if you have ( in it, forget about sanity and just quote")
is not, but I'm afraid that the only real way to deal with that
properly is to do as(1) from scratch for targets we care about and
make sure it produces binaries identical to gas(1) output on everything
gcc is likely to throw at it.

Alternatively, we could simply stop using as(1) macros and do it in C
preprocessor, or, (much) better yet, m4.  At least those have documented
semantics that is not likely to change at random...
