Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbVJ3P41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbVJ3P41 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbVJ3P41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:56:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53006 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932106AbVJ3P4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:56:24 -0500
Date: Sun, 30 Oct 2005 16:56:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: grundler@parisc-linux.org, linux-kernel@vger.kernel.org,
       parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] [2.6 patch] parisc: "extern inline" -> "static inline"
Message-ID: <20051030155624.GG4180@stusta.de>
References: <20051030000301.GO4180@stusta.de> <20051030152215.GB9235@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030152215.GB9235@parisc-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 08:22:15AM -0700, Matthew Wilcox wrote:
> On Sun, Oct 30, 2005 at 02:03:01AM +0200, Adrian Bunk wrote:
> > "extern inline" doesn't make much sense.
> 
> Are you sure?  It used to.  Taking just one sample, pgd_none:
> 
> extern inline: alpha, parisc, s390
> static inline: frv, ppc, sh64
> define: arm, arm26, frv, h8300, m68knommu, ppc64, v850
> 
> I really don't think it makes any difference.  Such a function (returning
> always 0) is always going to be inlined, and the only difference between
> static inline and extern inline is what happens when it can't be inlined.

On !alpha we are defining inline to __attribute__((always_inline)) for 
any non-ancient gcc making this a zero difference.

The bigger issue is that "extern inline" generates a warning with 
-Wmissing-prototypes and I'm currently working on getting the kernel 
cleaned up for adding this to the CFLAGS since it will help us to avoid 
a nasty class of runtime errors.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

