Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319204AbSH2Nkn>; Thu, 29 Aug 2002 09:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319205AbSH2Nkn>; Thu, 29 Aug 2002 09:40:43 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:57067 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319204AbSH2Nkm>; Thu, 29 Aug 2002 09:40:42 -0400
Date: Thu, 29 Aug 2002 06:42:44 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG+FIX] 2.4 buggercache sucks
Message-ID: <318656043.1030603363@[10.10.2.3]>
In-Reply-To: <200208291000.46618.roy@karlsbakk.net>
References: <200208291000.46618.roy@karlsbakk.net>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Summary: the code below probably isn't the desired solution.
> 
> Very well - but where is the code to run then?

Not quite sure what you mean?
 
> I mean - this code solved _my_ problem. Without it the server OOMs within 
> minutes of high load, as explained earlier. I'd rather like a clean fix in 
> 2.4 than this, although it works.

I'm sure Andrew could explain this better than I - he wrote the
code, I just whined about the problem. Basically he frees the
buffer_head immediately after he's used it, which could at least
in theory degrade performance a little if it could have been reused.
Now, nobody's ever really benchmarked that, so a more conservative
approach is likely to be taken, unless someone can prove it doesn't
degrade performance much for people who don't need the fix. One
of the cases people were running scared of was something doing 
continual overwrites of a file, I think something like:

for (i=0;i<BIGNUMBER;i++) {
	lseek (0);
	write 4K of data;
}

Or something. 

Was your workload doing lots of reads, or lots of writes? Or both?

M.

