Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315599AbSECIUA>; Fri, 3 May 2002 04:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315600AbSECITv>; Fri, 3 May 2002 04:19:51 -0400
Received: from [195.39.17.254] ([195.39.17.254]:24723 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S315599AbSECITm>;
	Fri, 3 May 2002 04:19:42 -0400
Date: Fri, 3 May 2002 09:56:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
Message-ID: <20020503075634.GA232@elf.ucw.cz>
In-Reply-To: <9595.1020174038@ocs3.intra.ocs.com.au> <200205011416.g41EFnX04718@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'll repeat myself. What if some advanced fs has no sensible way of 
> generating inode? Does it have to 'fake' it, just like [v]fat does it now?
> (Yes, vfat is not 'advanced' fs, let's not discuss it...)
> 
> The fact that minix,ext[23],etc has inode #s is an *implementation detail*.
> Historically entrenched in Unix.
> 
> Bad:
> inum_a = inode_num(file1);
> inum_b = inode_num(file2);
> if(inum_a == inum_b) { same_file(); }
> 
> Better:
> if(is_hardlinked(file1,file2) { same_file(); }
> 
> Yes, new syscal, blah, blah, blah... Not worth the effort, etc...
> lets start a flamewar...

Its worse: You have 1000 files with same size, how do you find which
are hardlinked? With inode_num() it is hashtable, doable with
O(n). With syscall we are talking O(n^2).
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
