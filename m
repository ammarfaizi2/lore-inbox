Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945937AbWBONce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945937AbWBONce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 08:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945938AbWBONce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 08:32:34 -0500
Received: from cantor2.suse.de ([195.135.220.15]:49058 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1945937AbWBONcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 08:32:32 -0500
From: Andi Kleen <ak@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 2.6.16-rc3-mm1: i386 compilation broken
Date: Wed, 15 Feb 2006 14:32:16 +0100
User-Agent: KMail/1.8.2
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060214014157.59af972f.akpm@osdl.org> <200602141427.49763.ak@suse.de> <Pine.LNX.4.61.0602151404141.9696@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0602151404141.9696@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602151432.16648.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 February 2006 14:19, Roman Zippel wrote:
> Hi,
> 
> On Tue, 14 Feb 2006, Andi Kleen wrote:
> 
> > Ok then the -ffreestanding was apparently still needed on other architectures too.
> > I guess that part of the patch can be just dropped.
> 
> The main problem is still the sprintf optimization, so 
> --fno-builtin-sprintf should fix it too.

Currently it will just use out of line strcpy etc. on x86-64.
Not quite optimal - probably need to go back to fix this


> That leaves only the single strchr, which is caused by an strpbrk 
> optimization in zoran_procfs.c, where we could use --fno-builtin-strpbrk 
> or simply directly replace that strpbrk with strchr.
> 
> If we really want to keep -ffreestanding, 

I think we should drop it, just i386 has to be fixed first.

> we have to rework how string.h  
> is organized to allow enabling builtin functions, but still provide fall 
> back functions. For example we had to add a lot of "#define foo 
> __builtin_foo" to linux/string.h and "#undef foo" to lib/string.c. 

Yes it would be ugly.


-Andi
