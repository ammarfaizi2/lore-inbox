Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265936AbVBDRWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265936AbVBDRWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265662AbVBDRWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:22:08 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:55720 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263722AbVBDRU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:20:59 -0500
Date: Fri, 4 Feb 2005 11:20:41 -0600
To: Pekka Enberg <penberg@gmail.com>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
       trini@kernel.crashing.org, benh@kernel.crashing.org, hpa@zytor.com,
       akpm@osdl.org, penberg@cs.helsinki.fi
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
Message-ID: <20050204172041.GA17586@austin.ibm.com>
References: <20050204072254.GA17565@austin.ibm.com> <84144f0205020400172d89eddf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f0205020400172d89eddf@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040523i
From: olof@austin.ibm.com (Olof Johansson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 10:17:48AM +0200, Pekka Enberg wrote:
> Please drop the CPU_FTR_##x macro magic as it makes grepping more
> complicated. If the enum names are too long, just do s/CPU_FTR_/CPU_/g
> or something similar. Also, could you please make this a static inline
> function?

I considered that for a while, but decided against it because:

* cpu-has-feature(cpu-feature-foo) v cpu-has-feature(foo): I picked the
latter for readability.
* Renaming CPU_FTR_<x> -> CPU_<x> makes it less obvious that
it's actually a cpu feature it's describing (i.e. CPU_ALTIVEC vs
CPU_FTR_ALTIVEC).
* Renaming would clobber the namespace, CPU_* definitions are used in
other places in the tree.
* Can't make it an inline and still use the preprocessor concatenation.

That being said, you do have a point about grepability. However,
personally I'd be more likely to look for CPU_HAS_FEATURE than the
feature itself when reading the code, and would find that easily. The
other way around (finding all uses of a feature) is harder, but the
concatenation macro is right below the bit definitions and easy to spot.


-Olof
