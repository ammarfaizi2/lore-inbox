Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVBIABV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVBIABV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 19:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVBIABU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 19:01:20 -0500
Received: from trantor.org.uk ([213.146.130.142]:25784 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S261700AbVBIABH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 19:01:07 -0500
Subject: Re: Question about sendfile
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Xiuduan Fang <xf4c@cs.virginia.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <03cd01c50d8e$00dd2fe0$3b3f8f80@cs.virginia.edu>
References: <03cd01c50d8e$00dd2fe0$3b3f8f80@cs.virginia.edu>
Content-Type: text/plain
Date: Tue, 08 Feb 2005 23:59:52 +0000
Message-Id: <1107907193.5822.81.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-07 at 22:26 -0500, Xiuduan Fang wrote:
> Hi,
> 
> I am trying to beat the I/O bottleneck so as to speed up bulk data transfers 
> in high speed network. It seems that the system call sendfile() can help to 
> reduce CPU utilization and speedup data transfers. But I have one question 
> about the system call,
> 
> First,  Linux sendfile requires that the input file descriptor cannot be a 
> network socket. What are the reasons for such a restriction? Sending a 
> socket to a file via zero copy is definitely useful.  Actually this is one 
> approach I am trying to do to improve performance.  Some discussions on 
> Linux zero copy said this is because it is harder. Sending a socket to a 
> file via zero copy needs the support of NICs. I cannot understand this 
> explanation. It seems that FreeBSD has implemented bidirectional zero 
> copy(http://people.freebsd.org/~ken/zero_copy/#Download). So why Linux does 
> not support it? What shall I do to release the restriction that Linux 
> enforces on sendfile?

>From the URL you posted:

"[zero-copy receive] generally requires some sort of intelligence on the
NIC to make sure that the payload starts in its own buffer.  This is
called "header splitting".  Currently the only NICs with support for
header splitting are Alteon Tigon 2 based boards running slightly
modified firmware."

Perhaps that explains it.

Not to mention the other complications that are involved if you scroll
down the page and read the FAQ.

Have you done any profiling work to see where your CPU cycles are being
spent?

-- 
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import

