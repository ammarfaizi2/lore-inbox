Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263563AbUEGLxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263563AbUEGLxE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 07:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUEGLxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 07:53:04 -0400
Received: from S01060050bfec5d4e.cg.shawcable.net ([68.144.57.107]:34688 "EHLO
	eviltron.local.lan") by vger.kernel.org with ESMTP id S263563AbUEGLxC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 07:53:02 -0400
Date: Fri, 7 May 2004 05:52:51 -0600
From: Steve Young <sdyoung@vt220.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] change pts allocation behaviour in
Message-ID: <20040507115251.GA4873@eviltron.local.lan>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040507084242.GA11389@eviltron.local.lan> <20040507041442.7e67c15e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040507041442.7e67c15e.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 04:14:42AM -0700, Andrew Morton wrote:
> >  in the range of 0-255 first.  However, if that fails, then it will search the
> >  higher ranges. 
> 
> Wouldn't we be better off with plain old first-fit-from-zero?

  In the typical case where <256 pts devices are allocated, you're right that
there will be no benefit over the first-fit-from-zero implementation.  However 
when there are a lot of pts devices in use, the algorithm used for searching 
the high ranges ought to generally find a new pts in fewer iterations than
just linearly searching from 0 to the maximum pts number.  For example, if a 
system allocates 5000 ptses in a row, when it goes to look for a new one with 
first-fit-from-zero, that's 5001 iterations to find an available pts.  Using
the patch though, it will only take 257 iterations.  As time goes on and 
ptses get allocated and freed the situation becomes a bit murkier, but 
the patch should still cut down the number of iterations required to find
a free pts.

  Thanks,
  Steve.
