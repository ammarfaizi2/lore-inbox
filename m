Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268085AbUJJDab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268085AbUJJDab (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 23:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268095AbUJJDaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 23:30:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:49608 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268085AbUJJDa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 23:30:29 -0400
Date: Sat, 9 Oct 2004 20:30:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: CaT <cat@zip.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: promise controller resource alloc problems with ~2.6.8
In-Reply-To: <Pine.LNX.4.58.0410092002070.3897@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0410092023160.3897@ppc970.osdl.org>
References: <20040927084550.GA1134@zip.com.au> <Pine.LNX.4.58.0409301615110.2403@ppc970.osdl.org>
 <20040930233048.GC7162@zip.com.au> <Pine.LNX.4.58.0409301646040.2403@ppc970.osdl.org>
 <20041001103032.GA1049@zip.com.au> <Pine.LNX.4.58.0410010731560.2403@ppc970.osdl.org>
 <20041002045725.GC1049@zip.com.au> <Pine.LNX.4.58.0410021211120.2301@ppc970.osdl.org>
 <20041010021929.GA1322@zip.com.au> <Pine.LNX.4.58.0410092002070.3897@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Oct 2004, Linus Torvalds wrote:
> 
> I wonder if request_resource() is broken. "insert_resource()" had been 
> broken for a _loong_ time (since its inception), maybe 
> "request_resource()" also is. Hmm..

I tested your resource list with my user-level resource test harness, and 
it definitely returned EBUSY for the clashing resource. So either you have 
something strange going on with finding the parent resource (the DBG() 
statement in the previous email should hopefully tell), or there's 
something else going on.

I'd suspect you had some clock drift problems and the i386.c file didn't
actually get recompiled when you changed it to "request_resource()", but
since the DBG() output shows up in your dmesg, that doesn't seem to
explain it either - the file clearly _did_ get recompiled for the debug
output.

Maybe the parent resource thing shows some smoking gun.

		Linus
