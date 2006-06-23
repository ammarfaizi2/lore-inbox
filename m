Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752075AbWFWVTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbWFWVTg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbWFWVTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:19:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45501 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752075AbWFWVTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:19:35 -0400
Date: Fri, 23 Jun 2006 14:19:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: jlan@engr.sgi.com, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in
 taskstats
Message-Id: <20060623141926.b28a5fc0.akpm@osdl.org>
In-Reply-To: <449C2181.6000007@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
	<20060609010057.e454a14f.akpm@osdl.org>
	<448952C2.1060708@in.ibm.com>
	<20060609042129.ae97018c.akpm@osdl.org>
	<4489EE7C.3080007@watson.ibm.com>
	<449999D1.7000403@engr.sgi.com>
	<44999A98.8030406@engr.sgi.com>
	<44999F5A.2080809@watson.ibm.com>
	<4499D7CD.1020303@engr.sgi.com>
	<449C2181.6000007@watson.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 13:14:41 -0400
Shailabh Nagar <nagar@watson.ibm.com> wrote:

> The results show that differential between tgid on and off
> starts becoming significant once the exit rate crosses roughly 1000
> threads/second. Below that exit rate, the difference is negligible.
> Above it, the difference starts climbing rapidly.
> 
> So I guess the question is whether this rate of exit is representative
> enough of real life to warrant making any more changes to the existing
> patchset, beyond the locking changes in 2. above.
> 
> >From my limited experience, I think this is too high an exit rate
> to be worrying about overhead.
> 

1000/sec isn't terribly high.  CGI servers, shell scripts.

And kernel development ;) A `pushpatch 1500' here does 992 fork/exec/exit
per second.

>         %ovhd of tgid on over off
>         (higher is worse)
> 
> Exit     User     Sys     Elapsed
> Rate     Time     Time    Time
> 
> 2283      25.76  649.41   -0.14
> 1193     -10.53   88.81   -0.12
> 963      -11.90    3.28   -0.10
> 806       -8.54   -0.84    0.16
> 694       -4.41    2.38    0.03

Oh wow.  Something's gone quadratic there.
