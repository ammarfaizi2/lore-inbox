Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbWEOSBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWEOSBo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWEOSBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:01:44 -0400
Received: from ns2.suse.de ([195.135.220.15]:19673 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965028AbWEOSBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:01:43 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86 NUMA panic compile error
Date: Mon, 15 May 2006 20:01:16 +0200
User-Agent: KMail/1.9.1
Cc: Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060515005637.00b54560.akpm@osdl.org> <20060515140811.GA23750@shadowen.org> <20060515175306.GA18185@elte.hu>
In-Reply-To: <20060515175306.GA18185@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605152001.16813.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 May 2006 19:53, Ingo Molnar wrote:
> 
> * Andy Whitcroft <apw@shadowen.org> wrote:
> 
> >  	if (use_cyclone == 0) {
> >  		/* Make sure user sees something */
> > -		static const char s[] __initdata = "Not an IBM x440/NUMAQ. Don't use i386 CONFIG_NUMA anywhere else."
> > +		static const char s[] __initdata = "Not an IBM x440/NUMAQ. Don't use i386 CONFIG_NUMA anywhere else.";
> >  		early_printk(s);
> >  		panic(s);
> >  	}
> 
> i still strongly oppose the original Andi hack... numerous reasons were 
> given not to apply it (it's nice to simulate/trigger rarer features on 
> mainstream hardware too, and this ability to boot NUMA on my flat x86 
> testbox found at least one other NUMA bug already). Furthermore, the 
> crash i reported was fixed by the NUMA patchset. Andrew, please drop:

The problem is that it's not regularly used on a wide range
of boxes so it will eventually break again. We had this cycle several
times already.

It's also missing a lot of the workarounds for broken SRATs that
are needed for many of the existing NUMA systems.

If there's consensus i386 NUMA is useful I can drop it, but I predict
it will just eventually break again.

>   x86_64-mm-i386-numa-summit-check.patch
> 
> (which has nothing to do with x86_64 anyway)

I have a lot of i386 or combined i386/x86-64 patches in my tree - just Andrew's 
merge script doesn't pick that up.

-Andi
