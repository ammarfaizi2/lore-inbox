Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSG2JYC>; Mon, 29 Jul 2002 05:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSG2JYC>; Mon, 29 Jul 2002 05:24:02 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25860 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314083AbSG2JYC>; Mon, 29 Jul 2002 05:24:02 -0400
Date: Mon, 29 Jul 2002 10:27:21 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of PAGE_{CACHE_,}{MASK,ALIGN}
Message-ID: <20020729102721.B23843@flint.arm.linux.org.uk>
References: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0207281622350.8208-100000@home.transmeta.com> <3D448808.CF8D18BA@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D448808.CF8D18BA@zip.com.au>; from akpm@zip.com.au on Sun, Jul 28, 2002 at 05:10:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 05:10:48PM -0700, Andrew Morton wrote:
> - Remove ->virtual, do page_address() via a hash.  4(ish) bytes saved.

Hmmmmmmm.  page_address() is already 5 loads (on ARM) if page->virtual
isn't used.  I'm seriously considering changing page_address() to cover
the 3 cases more efficiently:

1. non-discontiguous case (should be around 2 loads + math)
2. discontiguous case (currently 5 loads + lots of math)
3. weirder setups where loading page->virtual is faster

We currently ignore (1) completely, and just assume its the same as (2).

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

