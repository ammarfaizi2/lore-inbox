Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbTDNSrq (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTDNSqg (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:46:36 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:40598 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263801AbTDNSq0 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 14:46:26 -0400
Date: Mon, 14 Apr 2003 20:58:06 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: James Bourne <jbourne@hardrock.org>, Ken Brownfield <brownfld@irridia.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       KML <linux-kernel@vger.kernel.org>
Subject: Re: Oops: ptrace fix buggy
Message-ID: <20030414185806.GA12740@wohnheim.fh-wedel.de>
References: <200304121154.32997.m.c.p@wolk-project.de> <Pine.LNX.4.44.0304140713510.22450-100000@cafe.hardrock.org> <20030414134603.GB10347@wohnheim.fh-wedel.de> <1050330667.4059.27.camel@workshop.saharact.lan> <20030414144709.GE10347@wohnheim.fh-wedel.de> <1050343825.4757.17.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1050343825.4757.17.camel@nosferatu.lan>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 April 2003 20:10:25 +0200, Martin Schlemmer wrote:
> 
> From include/linux/version.h:
> 
> ---------------------------------------------------------------
> #define UTS_RELEASE "2.5.67-bk2"
> #define LINUX_VERSION_CODE 132419
> #define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))
> ---------------------------------------------------------------
> 
> Your changes will definitely break things that do:
> 
> #if ((LINUX_VERSION_CODE > KERNEL_VERSION(2.4.0)) && \
>      (LINUX_VERSION_CODE < KERNEL_VERSION(2.5.0)))
> 
> Also, most docs explaining the version format, refer to
> 
>   major.minor.micro
> 
> Anyhow, I did not say it was set in stone, I just said if you
> start getting breakage when compiling/configuring things, do
> not wonder why =)

James Bourne:
> The problem comes in when you bump the FIXLEVEL for example, by one.  At
> that point the LINUX_VERSION_CODE would not change even though you have a
> new kernel and modules compiled for the previous version may not load or
> may load and not work correctly (just one example).
> 
> EXTRAVERSION on the other hand is not used for LINUX_VERSION_CODE
> calculation.

So basically, neither the existing EXTRAVERSION nor my new FIXLEVEL
are checked. Any code could potentially break with -ac1 to -ac2 or
with .1 to .2.

Did anyone experience such problems with -ac already? There are far
more changes in -ac than there are in your patch.

Driver compilation should not be an issue. Change the Makefile and
version.h should be changed as well, so any code depending on
version.h will be rebuild, whether necessary or not.

Module load sounds unrealistic for .[123...], as you shouldn't change
any interfaces with fixes. But it might be a real problem for -ac.

Jörn

PS: Or for -aa, -dj, -mm or whatever. It's just an example.

-- 
Do not stop an army on its way home.
-- Sun Tzu
