Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267327AbSKPSQn>; Sat, 16 Nov 2002 13:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267328AbSKPSQn>; Sat, 16 Nov 2002 13:16:43 -0500
Received: from pop015pub.verizon.net ([206.46.170.172]:48884 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S267327AbSKPSQl>; Sat, 16 Nov 2002 13:16:41 -0500
Date: Sat, 16 Nov 2002 13:22:51 -0500
From: Akira Tsukamoto <at541@columbia.edu>
To: Andi Kleen <ak@suse.de>
Subject: Re: [CFT][PATCH]  2.5.47 Athlon/Druon, much faster copy_user function
Cc: linux-kernel@vger.kernel.org, Hirokazu Takahashi <taka@valinux.co.jp>,
       Andrew Morton <akpm@digeo.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <20021116115652.A26519@wotan.suse.de>
References: <20021115235234.8DE4.AT541@columbia.edu> <20021116115652.A26519@wotan.suse.de>
Message-Id: <20021116131403.9FB5.AT541@columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop015.verizon.net from [138.89.33.207] at Sat, 16 Nov 2002 12:23:31 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Nov 2002 11:56:52 +0100
Andi Kleen <ak@suse.de> mentioned:
> 
> You don't seem to save/restore the FPU state, so it will be likely 
> corrupted after your copy runs.

This is the main question for me that I was wondering for all week. 
My first version was using fsave and frstore, so 
just changing three lines will accomplish this.
Is it all I need?  Any thing elase needed to consider using fpu register?
> 
> Also I'm pretty sure that using movntq (= forcing destination out of 
> cache) is not a good strategy for generic copy_from_user(). It may 
> be a win for the copies in write ( user space -> page cache ),

Yes, that why I included postfetch in the code because movntq does not leave 
them in the L2 cache.
Anygood idea to 
> but 
> will hurt for all the ioctls and other things that actually need the
> data in cache afterwards. I am afraid it is not enough to do micro benchmarks
> here.

check above?

> 
> 
> -Andi



