Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbVJLVsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbVJLVsm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 17:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbVJLVsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 17:48:42 -0400
Received: from mx1.suse.de ([195.135.220.2]:54411 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751486AbVJLVsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 17:48:41 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [Patch 1/2] x86, x86_64: Intel HT, Multi core detection fixes
Date: Wed, 12 Oct 2005 23:49:04 +0200
User-Agent: KMail/1.8.2
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20051005161706.B30098@unix-os.sc.intel.com> <200510081228.39492.ak@suse.de> <20051012143641.B29292@unix-os.sc.intel.com>
In-Reply-To: <20051012143641.B29292@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510122349.05312.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 October 2005 23:36, Siddha, Suresh B wrote:

> Fields obtained through cpuid vector 0x1(ebx[16:23]) and
> vector 0x4(eax[14:25], eax[26:31]) indicate the maximum values and might not
> always be the same as what is available and what OS sees.  So make sure
> "siblings" and "cpu cores" values in /proc/cpuinfo reflect the values as seen
> by OS instead of what cpuid instruction says. This will also fix the buggy BIOS
> cases (for example where cpuid on a single core cpu says there are "2" siblings,
> even when HT is disabled in the BIOS. 
> http://bugzilla.kernel.org/show_bug.cgi?id=4359)

I'm not too fond of this new booted_core variable. How about
you just put the true number of cores into x86_num_cores? 
What should x86_num_cores be in your setup anyways if not
"booted cores"? 

Also I must admit the number of different variables to keep
track of multicore and siblingness starts to become mindboggling,
so I would recommend you add a fat overview comment somewhere
that describes their definition and relationship. Or better put
something into Documentation, it is probably as confusing for 
user space /proc/cpuinfo consumer too.

-Andi
