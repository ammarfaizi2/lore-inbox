Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbUKWTys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbUKWTys (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbUKWTxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:53:02 -0500
Received: from holomorphy.com ([207.189.100.168]:30375 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261525AbUKWTvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:51:19 -0500
Date: Tue, 23 Nov 2004 11:51:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Debugging a memory leak in the 2.6.X kernel - how-to?
Message-ID: <20041123195113.GN2714@holomorphy.com>
References: <200411231929.iANJTe4w031449@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411231929.iANJTe4w031449@turing-police.cc.vt.edu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 02:29:40PM -0500, Valdis.Kletnieks@vt.edu wrote:
> That's checking every 2-3 seconds - about as fast as I could hit
> uparrow, enter, and read the numbers and repeat.  After I killed
> gkrellm, it's sat solidly in the 10380-10400 range for well over an
> hour.
> *Possibly* related: I'm sitting at about 90% idle, but the load
> average is showing as 1.15 - however, I'm *NOT* seeing any processes
> stuck in 'D' state in the ps output.
> Any advice how to shoot this one?

Use the profile_hit() stuff to register a new profiling type for the
slab allocations you're interested in, then the offending allocators
should show up close to the top there unless there is a lot of turnover.
In that case, fiddling with the profiling and slab code to unregister
hits from whoever allocated a buffer should get solid results.


-- wli
