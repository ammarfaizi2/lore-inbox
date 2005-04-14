Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVDNRNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVDNRNG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 13:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVDNRNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 13:13:05 -0400
Received: from waste.org ([216.27.176.166]:57534 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261561AbVDNRMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 13:12:45 -0400
Date: Thu, 14 Apr 2005 10:11:27 -0700
From: Matt Mackall <mpm@selenic.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Pavel Machek <pavel@ucw.cz>,
       Andreas Steinmetz <ast@domdv.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050414171127.GL3174@waste.org>
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <20050414065124.GA1357@elf.ucw.cz> <20050414080837.GA1264@gondor.apana.org.au> <200504141104.40389.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504141104.40389.rjw@sisk.pl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 11:04:39AM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> On Thursday, 14 of April 2005 10:08, Herbert Xu wrote:
> > On Thu, Apr 14, 2005 at 08:51:25AM +0200, Pavel Machek wrote:
> > >
> > > > This solution is all wrong.
> > > > 
> > > > If you want security of the suspend image while "suspended", encrypt
> > > > with dm-crypt. If you want security of the swap image after resume,
> > > > zero out the portion of swap used. If you want both, do both.
> > 
> > Pavel, you're not answering our questions.
> > 
> > How is the proposed patch any more secure compared to swsusp over dmcrypt?
> 
> It is for different purpose.  It is to prevent swsusp from leaving a readable
> memory snapshot on the disk _after_ resume, even if the resume has _failed_
> (ie if you encrypt the image during suspend and then destroy the key after
> reading the image during resume, you don't need to zero out the swap partition,
> which you can't do anyway if the resume has failed).  IOW, please treat it as
> a more sophisticated method of zeroing out the swap partition. :-)

What is this resume failed case?

If it means the machine has crashed during resume, then so what? The
key is not on disk in the clear -ever- in the dm-crypt case. If the
attacker gets to poke around in the memory contents of the crashed
machine for the key (or the partially loaded suspend image).

If it means we fell back to a normal boot, normal boot can simply dd
over the swap at boot, generate a new ephemeral swap key, or whatever.

> Arguably, using dm-crypt is more secure, but it is also more
> complicated from the Joe User POV. IMHO we should not force users to
> set up dm-crypt, remember passwords etc., to get some basic
> security.

Any sensible solution here is going to require remembering passwords.
And arguably anywhere the user needs encrypted suspend, they'll want
encrypted swap as well.

-- 
Mathematics is the supreme nostalgia of our time.
