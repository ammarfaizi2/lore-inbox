Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264592AbUEDTKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbUEDTKd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 15:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264596AbUEDTKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 15:10:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:4281 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264592AbUEDTKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 15:10:31 -0400
Date: Tue, 4 May 2004 12:10:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH] mxcsr patch for i386 & x86-64
In-Reply-To: <E305A4AFB7947540BC487567B5449BA802CA7BEC@scsmsx402.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0405041201440.3271@ppc970.osdl.org>
References: <E305A4AFB7947540BC487567B5449BA802CA7BEC@scsmsx402.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 May 2004, Kamble, Nitin A wrote:
>
>      Attached is the patch to enable proper mxcsr register masking in
> the Linux Kernel. 
> 
> Please refer to IA32 Software Developer's Manual, Volume 1, Section
> 11.6.6 for more details.

Ahh. Have we verified that the new semantics of that MXCSR_MASK field 
works on non-intel CPU's too?

It would also (in my opinion) make sense to just export the 
"common_mxcsr_mask" (and probably just rename it as "mxcsr_feature_mask" 
or something - where does that "common" come from? Is it just to imply 
that it's the bits that all CPU's support "in common", or what?

Right now you export a function that does just a simple mask operation, 
and quite frankly, that just seems to make it less clear what the code is 
doing. So who not get rid of that "set_fpu_mxcsr()" function, and just 
replace all the "0xffbf" uses with "mxcsr_feature_mask"?

Hmm?

		Linus
