Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbUJWQtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbUJWQtY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 12:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbUJWQtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 12:49:23 -0400
Received: from colin2.muc.de ([193.149.48.15]:56836 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261243AbUJWQtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 12:49:05 -0400
Date: 23 Oct 2004 18:49:02 +0200
Date: Sat, 23 Oct 2004 18:49:02 +0200
From: Andi Kleen <ak@muc.de>
To: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
Cc: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: lost memory on a 4GB amd64
Message-ID: <20041023164902.GB52982@muc.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au> <200409241315.42740.andrew@walrond.org> <Pine.LNX.4.58.0410221053390.17491@fb07-2go.math.uni-giessen.de> <200410221026.22531.andrew@walrond.org> <20041022182446.GA77384@muc.de> <Pine.LNX.4.58.0410231220400.17491@fb07-2go.math.uni-giessen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410231220400.17491@fb07-2go.math.uni-giessen.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 12:26:38PM +0200, Sergei Haller wrote:
> On Fri, 22 Oct 2004, Andi Kleen (AK) wrote:
> 
> AK> > I've cc'ed Andi Kleen (x86_64 supremo) who might have some insights, but I'm 
> AK> > guessing he'll say "Bios problem - tough luck". I might be wrong ;)
> AK> 
> AK> Is there a full boot log of the system? 
> 
> yes. attached two files: 
> 
>   dmesg-2.6.9-smp-NUMA   (crashing one)
>   dmesg-2.6.9-smp-noNUMA (working one)

I bet that if you fill all memory on the non NUMA setup
it will crash too.

e.g. run something like this

#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdio.h>

#define MEMSIZE 
main()
{ 
	unsigned long len = (sysconf(_SC_AVPHYS_PAGES) - 10)* getpagesize();
	char *mem = malloc(len);
	for (;;)  {
		memset(mem, 0xff, len); 
		printf(".");
	}
} 


-Andi

