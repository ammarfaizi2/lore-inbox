Return-Path: <linux-kernel-owner+w=401wt.eu-S1754971AbXABWSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971AbXABWSK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 17:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754996AbXABWSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 17:18:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37877 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754971AbXABWSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 17:18:07 -0500
Date: Tue, 2 Jan 2007 14:13:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Adrian Bunk <bunk@stusta.de>,
       "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: kernel + gcc 4.1 = several problems
In-Reply-To: <200701022156.48919.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.64.0701021408280.4473@woody.osdl.org>
References: <200612201421.03514.s0348365@sms.ed.ac.uk>
 <200612311655.51928.s0348365@sms.ed.ac.uk> <20070102211045.GY20714@stusta.de>
 <200701022156.48919.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jan 2007, Alistair John Strachan wrote:
> 
> At any rate, I have absolute confirmation that it is GCC 4.1.1, because with 
> GCC 3.4.6 the same kernel I reported booting three days ago is still 
> cheerfully working. I regularly get uptimes of 60+ days on that machine, 
> rebooting only for kernel upgrades. 2.6.19 seems to be no worse in this 
> regard.
> 
> Perhaps fortunately, the configs I've tried have consistently failed to shake 
> the crash, so I have a semi-reproducible test case here on C3-2 hardware if 
> somebody wants to investigate the problem (though it still takes 6-12 hours).

Historically, some people have actually used horrible hacks like trying to 
figure out which particular C file gets miscompiled by basically having 
both compilers installed, and then trying out different subdirectories 
with different compilers. And once the subdirectory has been pinpointed, 
pinpointing which particular file it is.. etc.

Pretty damn horrible to do, and I'm afraid we don't have any real helpful 
scripts to do any of the work for you. So it's all effectively manual 
(basically boils down to: "compile everything with known-good compiler. 
Then replace the good compiler with the bad one, remove the object files 
from one directory, and recompile the kernel". "Rinse and repeat".

I don't think anybody has ever done that with something where triggering 
the cause then also takes that long - that just ends up making the whole 
thing even more painful. 

What are the exact crash details? That might narrow things down enough 
that maybe you could try just one or two files that are "suspect".

		Linus
