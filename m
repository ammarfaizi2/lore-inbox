Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317365AbSFDLpE>; Tue, 4 Jun 2002 07:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317464AbSFDLpC>; Tue, 4 Jun 2002 07:45:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29348 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316592AbSFDLoI>;
	Tue, 4 Jun 2002 07:44:08 -0400
Date: Tue, 04 Jun 2002 03:39:03 -0700 (PDT)
Message-Id: <20020604.033903.42777297.davem@redhat.com>
To: trond.myklebust@fys.uio.no
Cc: akpm@zip.com.au, aia21@cantab.net, linux-kernel@vger.kernel.org
Subject: Re: [2.5.20-BUG] 3c59x + highmem + acpi + nfs -> kernel panic
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206041339.32899.trond.myklebust@fys.uio.no>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Trond Myklebust <trond.myklebust@fys.uio.no>
   Date: Tue, 4 Jun 2002 13:39:32 +0200
   
   >From what I can see, the only other place where KM_USER0 is employed would be 
   in the *_highpage() helper routines in include/linux/highmem.h. These 
   routines are used in various places, but are usually not protected against 
   (soft and hard) interrupts or kernel pre-emption. Could it be that the latter 
   is what is causing trouble?

Any sort of interrupt whatsoever would be enough to cause a problem
here.  It is enough of a condition to allow the sunrpc code to
run.

This has nothing specific to do with preemption, although the fact
that KM_USER0 usage does not block preemption is worrysome.
