Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263101AbUENW4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUENW4l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 18:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbUENW4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 18:56:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:46251 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263101AbUENW4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 18:56:40 -0400
Date: Fri, 14 May 2004 15:59:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/7] perfctr-2.7.2 for 2.6.6-mm2: core
Message-Id: <20040514155907.36246829.akpm@osdl.org>
In-Reply-To: <200405141409.i4EE9Uhd018397@alkaid.it.uu.se>
References: <200405141409.i4EE9Uhd018397@alkaid.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> - core driver files and kernel changes

Looks like we need six system calls if we're going to do it that way.

All that marshalling and unmarshalling code is a bit evil.  I wonder if
there's some way in which it can be flattened out.

One option would be to present all the info to userspace as a virtual
filesystem, although it would be a bit weird that the contents of the
"files" depends upon the process which reads them.

Maybe a mkdir() on that filesystem could create a directory which contains
files which contain the counters for the process which made the directory? 
The directory would need to be auto-rmdir'ed on process exit.  It's
basically the same semantics as /proc/pid.

But /proc/pid can be read by processes other than "pid".  Does the same
apply to the perfcntr instrumentation?  (Being able to read another
process's perfcntr info sounds useful.  Is it?)

