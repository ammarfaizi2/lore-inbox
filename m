Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314526AbSEFP0b>; Mon, 6 May 2002 11:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314525AbSEFP0a>; Mon, 6 May 2002 11:26:30 -0400
Received: from dsl-213-023-043-254.arcor-ip.net ([213.23.43.254]:11200 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314526AbSEFP03>;
	Mon, 6 May 2002 11:26:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Mon, 6 May 2002 17:26:19 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0205061046180.23113-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E174kNX-0004KS-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 May 2002 10:54, Roman Zippel wrote:
> Hi,
> 
> On Mon, 6 May 2002, Daniel Phillips wrote:
> 
> > I must be guilty of not explaining clearly.  Suppose you have the following
> > physical memory map:
> > 
> > 	          0: 128 MB
> > 	  8000,0000: 128 MB
> > 	1,0000,0000: 128 MB
> > 	1,8000,0000: 128 MB
> > 	2,0000,0000: 128 MB
> > 	2,8000,0000: 128 MB
> > 	3,0000,0000: 128 MB
> > 	3,8000,0000: 128 MB
> > 
> > The total is 1 GB of installed ram.  Yet the kernel's 1G virtual space,
> > can only handle 128 MB of it.  The rest falls out of the addressable range and
> > has to be handled as highmem, that is if you preserve the linear relationship
> > between kernel virtual memory and physical memory, as config_discontigmem does.
> > Even if you go to 2G of kernel memory (restricting user space to 2G of virtual)
> > you can only handle 256 MB.
> 
> Why do you want to preserve the linear relationship between virtual and
> physical memory?

I don't, I observed that in all known instances of config_discontigmem, that
linear relationship is preserved.  Now, you and Andrea are suggesting that no
such linear relation is strictly necessary and I believe its worth investigating
further, to see how it would work and how it compares to config_nonlinear.

> There is little common code (and only during
> initialization), which assumes a direct mapping. I can send you the
> patches to fix this.

I already have patches to do that, that is, config_nonlinear.  I'm interested in
looking at your patches though, because we might as well give all the different
approaches a fair examination.

> Then you can map as much physical memory as you want
> into a single virtual area and you only need a single pgdat.

You're talking about your 68K solution with the loops that search through
memory regions?  If so, I've already looked at it and understand it.  Or, if
it's a new approach, then naturally I'd be interested.

-- 
Daniel
