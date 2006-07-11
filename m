Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWGKWYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWGKWYF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWGKWYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:24:05 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5384 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932076AbWGKWYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:24:01 -0400
Date: Wed, 12 Jul 2006 00:24:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: RFC: cleaning up the in-kernel headers
Message-ID: <20060711222400.GE13938@stusta.de>
References: <20060711160639.GY13938@stusta.de> <1152635323.3373.211.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152635323.3373.211.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 05:28:43PM +0100, David Woodhouse wrote:
> On Tue, 2006-07-11 at 18:06 +0200, Adrian Bunk wrote:
> > I'd like to cleanup the mess of the in-kernel headers, based on the 
> > following rules:
> > - every header should #include everything it uses
> > - remove unneeded #include's from headers
> > 
> > This would also remove all the implicit rules "before #include'ing 
> > header foo.h, you must #include header bar.h" you usually only see
> > when the compilation fails.
> > 
> > There might be exceptions (e.g. for avoiding circular #include's) but 
> > these would be special cases.
> 
> Seems eminently sensible. Please make sure you don't introduce
> regressions in the output of 'make headers_install' by unconditionally
> including files which don't exist in the export -- if something is only
> _used_ within #ifdef __KERNEL__ then it should only be #included within
> #ifdef __KERNEL__ too.

Sure, I have the userspace headers in mind, too.

> It would be nice in the general case if we could actually _compile_ each
> header file, standalone. There may be some cases where that doesn't
> work, but it's a useful goal in most cases, for bother exported headers
> _and_ the in-kernel version. For the former case it would be nice to add
> it to 'make headers_check' once it's realistic to do so.

That's what I meant with "every header should #include everything it 
uses".

Unfortunately, compiling alone is not enough due to:
- different config options affecting a header
- code only used in a #define

I got a problem caused by the combination of both just a few days ago...

>...
> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

