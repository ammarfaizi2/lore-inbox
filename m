Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264201AbTEWXiq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 19:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264203AbTEWXiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 19:38:46 -0400
Received: from fmr02.intel.com ([192.55.52.25]:38110 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S264201AbTEWXip convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 19:38:45 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: /proc/kcore - how to fix it
Date: Fri, 23 May 2003 16:51:43 -0700
Message-ID: <DD755978BA8283409FB0087C39132BD101B00E0A@fmsmsx404.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: /proc/kcore - how to fix it
Thread-Index: AcMhc934SBFcZuadQCitOASEoIEewgAEV5bg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@linuxia64.org>,
       <rmk@arm.linux.org.uk>, <davidm@napali.hpl.hp.com>, <akpm@digeo.com>
X-OriginalArrivalTime: 23 May 2003 23:51:43.0637 (UTC) FILETIME=[43628450:01C32186]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One alternative I considered was to use just do a page table lookup.
> But I fear that some architectures use direct mapping registers etc.
> with mappings not in the page tables for the direct mapping, so it 
> probably won't work for everybody.

You are right.  IA64 maps the kernel with some locked registers, so
there are no pagetables to show that the mapping exists.
 
> What I'm worrying about is that the kernel will oops when accessing
> unmapped memory. That certainly should not happen.

Agreed.  Oops is always a bad thing.

> > /proc/kcore is a bit different because it's trying to present
> > a regular file view, rather than a char-special file view to
> > any tool that wants to use it.  If someone fixes up gdb, objdump,
> > readelf, etc. then the macros can be easily removed to provide 1:1
> > (though even then it isn't quite 1:1 ... offset in file would be
> > "vaddr + elf_buflen" to allow space for the elf headers at the start
> > of the file.
> 
> You're doing this to handle tools that have signedness bugs while
> parsing core files? iirc gdb is clean. What other tools have the 
> problem? 

I don't know ... you'll have to dust off those fixes for /proc to let
the negative file offsets get as far as the kcore.c code so we can
see what utilities work.  In practice we probably don't care about
anything other than gdb.

-Tony
