Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284122AbRLFPnp>; Thu, 6 Dec 2001 10:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284124AbRLFPnf>; Thu, 6 Dec 2001 10:43:35 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:61137 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S284122AbRLFPnX>; Thu, 6 Dec 2001 10:43:23 -0500
Date: Thu, 6 Dec 2001 10:43:17 -0500
From: Eric-Olivier Lamey <eric.olivier.lamey@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org
Cc: Cyrille =?iso-8859-1?Q?B=E9raud?= 
	<cyrille.beraud@savoirfairelinux.com>,
        Jeff Dike <jdike@karaya.com>, Tim Walberg <twalberg@mindspring.com>,
        Brian Gerst <bgerst@didntduck.org>
Subject: Re: Removing an executable while it runs
Message-ID: <20011206154317.GB14780@192.168.1.1>
In-Reply-To: <20011205145442.A12034@mindspring.com> <200112060025.TAA04538@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200112060025.TAA04538@ccure.karaya.com>
User-Agent: Mutt/1.3.24i
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 07:25, Jeff Dike wrote:
> twalberg@mindspring.com said:
> > mlockall() only locks those pages that are **currently** paged in, or
> > optionally those that will be paged in in the future. Unless you have
> > a way to make sure that all pages of the binary are actually in memory
> > before you call mlockall(), this gains you nothing.
> 
> No, mlockall will page in the entire process before returning if you ask it to.
> 
> See this snippet in mlock_fixup:
> 
> 		if (newflags & VM_LOCKED) {
> 			pages = -pages;
> 			make_pages_present(start, end);
> 		}
> 
> VM_LOCKED comes in through the mlockall system call.
> 
> 				Jeff

  Well, according to the man page, mister Walberg is right. How can I
  force mlockall to page in the entire process ? And if it is possible,
  I guess it won't resolve my problem since it is the filesystem which
  refuses to release the blocks, right ?
  To be more precise, here is my situation: the executable file is
  located on a ramfs filesystem. Once it is started, I would like to get
  the space back so that the RAM can be used. Is there a clean solution ?

  P.S: on behalf of Cyrille (who made the first post), I would like to
  thank you for your answers, it is greatly appreciated.

  P.P.S: is it required to include the people involved in the thread in
  the Cc: field ? I have looked in the mailing list FAQ and have not
  found the reason.

-- 
Eric-Olivier Lamey
