Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267334AbSKPSoI>; Sat, 16 Nov 2002 13:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267337AbSKPSoI>; Sat, 16 Nov 2002 13:44:08 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:54489 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S267334AbSKPSoH>; Sat, 16 Nov 2002 13:44:07 -0500
Date: Sat, 16 Nov 2002 13:50:17 -0500
From: Akira Tsukamoto <at541@columbia.edu>
To: Andi Kleen <ak@suse.de>
Subject: Re: [CFT][PATCH]  2.5.47 Athlon/Druon, much faster copy_user function
Cc: linux-kernel@vger.kernel.org, Hirokazu Takahashi <taka@valinux.co.jp>,
       Andrew Morton <akpm@digeo.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <20021116193003.A11205@wotan.suse.de>
References: <20021116131403.9FB5.AT541@columbia.edu> <20021116193003.A11205@wotan.suse.de>
Message-Id: <20021116133839.9FC4.AT541@columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at out001.verizon.net from [138.89.33.207] at Sat, 16 Nov 2002 12:50:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 16 Nov 2002 19:30:03 +0100
Andi Kleen <ak@suse.de> mentioned:
> 
> The proper way to save it is to use kernel_fpu_begin()

Thanks! I will look into it. This is what I was looking for.

I been running this kernel with my copy for three days, and never had
oops, but I was really worried.

> > > Also I'm pretty sure that using movntq (= forcing destination out of 
> > > cache) is not a good strategy for generic copy_from_user(). It may 
> > > be a win for the copies in write ( user space -> page cache ),
> > 
> > Yes, that why I included postfetch in the code because movntq does not leave 
> > them in the L2 cache.
> 
> That looks rather wasteful - first force it out and then trying to get it in 
> again. I have my doubts on it being a good strategy for speed.

It tried both, use just normal mov or movq <-> use movntq + postfetch, and the later 
was much much faster, because postfetch needs to read only every 64 bytes.

I will ckeck kernel_fpu_begin() fisrt and if using fpu register is too much
overhead than I will remove them.

Akira


