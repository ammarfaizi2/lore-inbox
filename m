Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267263AbSKPKt6>; Sat, 16 Nov 2002 05:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267264AbSKPKt5>; Sat, 16 Nov 2002 05:49:57 -0500
Received: from ns.suse.de ([213.95.15.193]:34323 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267263AbSKPKt5>;
	Sat, 16 Nov 2002 05:49:57 -0500
Date: Sat, 16 Nov 2002 11:56:52 +0100
From: Andi Kleen <ak@suse.de>
To: Akira Tsukamoto <at541@columbia.edu>
Cc: linux-kernel@vger.kernel.org, Hirokazu Takahashi <taka@valinux.co.jp>,
       Andrew Morton <akpm@digeo.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andi Kleen <ak@suse.de>
Subject: Re: [CFT][PATCH]  2.5.47 Athlon/Druon, much faster copy_user function
Message-ID: <20021116115652.A26519@wotan.suse.de>
References: <20021115235234.8DE4.AT541@columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115235234.8DE4.AT541@columbia.edu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You don't seem to save/restore the FPU state, so it will be likely 
corrupted after your copy runs.

Also I'm pretty sure that using movntq (= forcing destination out of 
cache) is not a good strategy for generic copy_from_user(). It may 
be a win for the copies in write ( user space -> page cache ), but 
will hurt for all the ioctls and other things that actually need the
data in cache afterwards. I am afraid it is not enough to do micro benchmarks
here.


-Andi
