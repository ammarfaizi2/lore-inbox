Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbVKJUn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVKJUn3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVKJUn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:43:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61956 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932096AbVKJUn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:43:27 -0500
Date: Thu, 10 Nov 2005 21:43:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Oliver Neukum <oliver@neukum.org>
Cc: Matthew Dobson <colpatch@us.ibm.com>,
       Pekka J Enberg <penberg@cs.helsinki.fi>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] Inline 3 functions
Message-ID: <20051110204325.GG5376@stusta.de>
References: <436FF51D.8080509@us.ibm.com> <200511101904.23114.oliver@neukum.org> <20051110182001.GF5376@stusta.de> <200511102022.52702.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511102022.52702.oliver@neukum.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 08:22:52PM +0100, Oliver Neukum wrote:
> Am Donnerstag, 10. November 2005 19:20 schrieb Adrian Bunk:
> > On Thu, Nov 10, 2005 at 07:04:22PM +0100, Oliver Neukum wrote:
> > > Am Donnerstag, 10. November 2005 18:38 schrieb Adrian Bunk:
> > > > > So are you suggesting that we don't mark these functions 'inline', or are
> > > > > you just pointing out that we'll need to drop the 'inline' if there is ever
> > > > > another caller?
> > > > 
> > > > I'd suggest to not mark them 'inline'.
> > > 
> > > It seems you have found one more use for sparse. How about a tag
> > > like __single_inline that will cause a warning if a function having it
> > > is called from more than one place?
> > 
> > Why should such a function be manually marked "inline" at all?
> > 
> > If a static function is called exactly once it is the job of the 
> > compiler to inline the function.
> 
> It should indeed. This documentation says it does:
> http://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
> That makes me wonder what is the problem.

On i386, we have the problem that we are using -fno-unit-at-a-time to 
avoid stack usage problems.

But the proper solution will be to remove -fno-unit-at-a-time from the 
CFLAGS for gcc >= 4.1 or >= 4.2 and check whether this will cause any 
new stack usage problems.

> 	Puzzeled
> 		Oliver

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

