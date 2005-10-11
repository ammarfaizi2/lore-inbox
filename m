Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbVJKJWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbVJKJWe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 05:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbVJKJWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 05:22:34 -0400
Received: from unthought.net ([212.97.129.88]:12930 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751428AbVJKJWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 05:22:34 -0400
Date: Tue, 11 Oct 2005 11:22:33 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Leif Nixon <nixon@nsc.liu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cache invalidation bug in NFS v3 - trivially reproducible
Message-ID: <20051011092232.GA1625@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Leif Nixon <nixon@nsc.liu.se>, linux-kernel@vger.kernel.org
References: <m33bn8bet4.fsf@nammatj.nsc.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m33bn8bet4.fsf@nammatj.nsc.liu.se>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2005 at 11:09:27AM +0200, Leif Nixon wrote:
...
> 
> Now client n2 is stuck in a state where it uses its old cached data
> forever (or at least for several hours):
> 
>   NFS client n1                NFS client n2
> 
>   $ cat f
>   2
> 			       $ cat f
> 			       1

I can confirm this on NFSv3 UDP export from patched 2.6.11.11 server
(dual opteron 64-bit kernel) to two different SMP (32-bit x86) clients
with 2.6.12.4 and 2.6.11.11 kernels.

There are definitely timing issues - in order to reproduce the problem I
had to use "touch . ; echo 2 > r" and "touch r; cat r" on the clients -
I couldn't type the commands quickly enough one-by-one.

But right now I have:

[phoenix:joe] $ cat r
2

[raven:joe] $ cat r
1

Beautiful :)

-- 

 / jakob

