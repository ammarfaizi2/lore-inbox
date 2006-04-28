Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWD1XEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWD1XEG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 19:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWD1XEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 19:04:06 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:922 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932070AbWD1XED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 19:04:03 -0400
Date: Fri, 28 Apr 2006 18:04:01 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: PCI init vs. memory init
Message-ID: <20060428230401.GF22621@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul,

I'd previously reported a problem where the PCI subsystem 
was getting inited before the memory subsystem. In the unusual
case of an EEH failure, this resulted in a crash in kmalloc,
which I hacked around with a if(!mem_init_done).

You mentioned that the sequence of inits seemed wrong, that the 
PCI init should be done later, after the memory init. I think
I agree; but when I took a very very quick look at the code, there 
was no obvious hook in later init to move the PCI init over to. 

Are you pursuing this further? Should I dig into it?  Any bright
ideas? Am I missing something obvious?  

There are several spots in in the powerpc PCI init code where 
a boot_mem alloc is used instead of kmalloc, and this boot_mem is 
then hacked around in the case of a PCI hotplug remove.  It would 
be nice to fix this...

--linas
