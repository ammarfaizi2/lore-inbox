Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWD2Hsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWD2Hsg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 03:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWD2Hsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 03:48:36 -0400
Received: from ozlabs.org ([203.10.76.45]:22927 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751012AbWD2Hsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 03:48:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17491.6735.199209.247913@cargo.ozlabs.ibm.com>
Date: Sat, 29 Apr 2006 17:48:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: PCI init vs. memory init
In-Reply-To: <20060428230401.GF22621@austin.ibm.com>
References: <20060428230401.GF22621@austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas writes:

> You mentioned that the sequence of inits seemed wrong, that the 
> PCI init should be done later, after the memory init. I think
> I agree; but when I took a very very quick look at the code, there 
> was no obvious hook in later init to move the PCI init over to. 
> 
> Are you pursuing this further? Should I dig into it?  Any bright
> ideas? Am I missing something obvious?  

I assume you're talking about find_and_init_phbs() and eeh_init(),
which are currently called from pSeries_setup_arch().

Would a core_initcall be early enough for those?  It seems to me that
it probably would be.  What are the actual dependencies?  Clearly it
needs to be before pcibios_init(), which is a subsys_initcall.  Is
there anything else that they need to come before?

> There are several spots in in the powerpc PCI init code where 
> a boot_mem alloc is used instead of kmalloc, and this boot_mem is 
> then hacked around in the case of a PCI hotplug remove.  It would 
> be nice to fix this...

Indeed.

Paul.
