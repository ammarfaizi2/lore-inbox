Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263698AbUEGT4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbUEGT4D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 15:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUEGT4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 15:56:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:41446 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263714AbUEGTzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 15:55:51 -0400
Date: Fri, 7 May 2004 12:09:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steve Young <sdyoung@vt220.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] change pts allocation behaviour in
Message-Id: <20040507120907.5e23e21c.akpm@osdl.org>
In-Reply-To: <20040507115251.GA4873@eviltron.local.lan>
References: <20040507084242.GA11389@eviltron.local.lan>
	<20040507041442.7e67c15e.akpm@osdl.org>
	<20040507115251.GA4873@eviltron.local.lan>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Young <sdyoung@vt220.org> wrote:
>
> On Fri, May 07, 2004 at 04:14:42AM -0700, Andrew Morton wrote:
> > >  in the range of 0-255 first.  However, if that fails, then it will search the
> > >  higher ranges. 
> > 
> > Wouldn't we be better off with plain old first-fit-from-zero?
> 
>   In the typical case where <256 pts devices are allocated, you're right that
> there will be no benefit over the first-fit-from-zero implementation.  However 
> when there are a lot of pts devices in use, the algorithm used for searching 
> the high ranges ought to generally find a new pts in fewer iterations than
> just linearly searching from 0 to the maximum pts number.  For example, if a 
> system allocates 5000 ptses in a row, when it goes to look for a new one with 
> first-fit-from-zero, that's 5001 iterations to find an available pts.

first-fit-from-zero does not imply linear search!  The idr.c code provides
a logarithmic-time search.
