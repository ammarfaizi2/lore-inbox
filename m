Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264409AbTCXUo1>; Mon, 24 Mar 2003 15:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264406AbTCXUo1>; Mon, 24 Mar 2003 15:44:27 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:10763 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264409AbTCXUo0>; Mon, 24 Mar 2003 15:44:26 -0500
Date: Mon, 24 Mar 2003 21:55:29 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries.Brouwer@cwi.nl
cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] revert register_chrdev_region change
In-Reply-To: <UTC200303241907.h2OJ75619479.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0303242032310.5042-100000@serv>
References: <UTC200303241907.h2OJ75619479.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 24 Mar 2003 Andries.Brouwer@cwi.nl wrote:

> > I'm personally not yet completly happy with his interface either
> > because he still uses the major/minor split
> 
> Yes, it is more elegant to register one or more ranges.
> (But ranges of what? Ranges in dev_t space? Or in kdev_t space?

Ok, I'm slightly confused now, what is the difference between the "dev_t 
space" and the "kdev_t space"? The answer I'd like to hear is: none.
A difference might be the encoding, that's why I mentioned the ext2 
example. How will be e.g. 0x0301 encoded on disk with your changes?
So far I understood kdev_t as a marker, which has to be replaced with 
either struct block_device or char_device, so that at some point kdev_t 
goes away completely. (Especially Al did some great work here with the 
block layer.) You removed now part of this work by removing the i_cdev 
pointer from the inode. What will you replace it with?

> Also, you'll notice that the current simple hash scheme is insufficient
> if we want to have subranges that override larger ranges.
> But life is easier if we postpone that discussion a bit.

I'd prefer to have the discussion now, as I still don't know what we need 
ranges or even subranges for. What problem are you trying to solve?

> # It would help a lot if you would explain what the next stages are.
> 
> - Polish the kernel until a change of the size of dev_t is possible.
> - Agree on a new size for dev_t, major, minor.  Make the change.
> - Ask Ulrich to update glibc.

I don't care much about the specific major/minor encoding, I want to know 
how it will be used at the kernel level.

bye, Roman

