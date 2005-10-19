Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVJSLKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVJSLKg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVJSLKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:10:36 -0400
Received: from webmail.LF.net ([212.9.160.14]:24841 "EHLO webmail.LF.net")
	by vger.kernel.org with ESMTP id S964796AbVJSLKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:10:35 -0400
Message-ID: <1129720232.435629a8753d3@webmail.LF.net>
Date: Wed, 19 Oct 2005 13:10:32 +0200
From: gfiala@s.netic.de
To: linux-kernel@vger.kernel.org
Subject: Re: large files unnecessary trashing filesystem cache?
References: <200510182201.11241.gfiala@s.netic.de> <200510182302.59604.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20051018213721.236b2107.akpm@osdl.org>
In-Reply-To: <20051018213721.236b2107.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 170.56.58.152
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zitat von Andrew Morton <akpm@osdl.org>:

> An obvious approach would be an LD_PRELOAD thingy which modifies read() and
> write(), perhaps controlled via an environment variable.  AFAIK nobody has
> even attempted this.

Sounds interesting.

> A decent kernel implementation would be to add a max_resident_pages to
> struct file_struct and to use that to perform drop-behind within read() and
> write().  That's a bit of arithmetic and a call to
> invalidate_mapping_pages().  The userspace interface to that could be a
> linux-specific extension to posix_fadvise() or to fcntl().

Would still like to have a way to configure a "default file policy/heuristics"
for the system, just like i can choose IO-scheduler.

> 
> But that still requires that all the applications be modified.
> 
> So I'd also suggest a new resource limit which, if set, is copied into the
> applications's file_structs on open().  So you then write a little wrapper
> app which does setrlimit()+exec():
> 
> 	limit-cache-usage -s 1000 my-fave-backup-program <args>
> 
> Which will cause every file which my-fave-backup-program reads or writes to
> be limited to a maximum pagecache residency of 1000 kbytes.

Or make it another 'ulimit' parameter...

