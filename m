Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264924AbSJ3VOP>; Wed, 30 Oct 2002 16:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264923AbSJ3VOP>; Wed, 30 Oct 2002 16:14:15 -0500
Received: from d196069.dynamic.cmich.edu ([141.209.196.69]:53905 "EHLO euclid")
	by vger.kernel.org with ESMTP id <S264922AbSJ3VON> convert rfc822-to-8bit;
	Wed, 30 Oct 2002 16:14:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Matthew J. Fanto" <mattf@mattjf.com>
Reply-To: mattf@mattjf.com
Organization: mattjf.com
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: The Ext3sj Filesystem
Date: Wed, 30 Oct 2002 16:20:18 -0500
User-Agent: KMail/1.4.3
References: <200210301434.17901.mattf@mattjf.com> <20021030205652.GC22178@marowsky-bree.de>
In-Reply-To: <20021030205652.GC22178@marowsky-bree.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210301620.18326.mattf@mattjf.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 October 2002 03:56 pm, Lars Marowsky-Bree wrote:

> Do you encrypt before the data has hit the data journal or after? Does that
> work for mmap etc?

I have not finished journaling support yet, but it will encrypt before it hits 
the journal. Yes, there should be no problem with mmap.

>
> This sounds like something you might want to abstract into a generic
> architecture to be shared with the loop device code, or anything which
> might need encryption in the kernel. Otherwise it is a PITA to maintain.

I will be going over the cryptoAPI code tonight and seeing if I can change the 
crypto routines to use the cryptoAPI, as it would be much easier to maintain. 

> And I thought some of those algorithms were strictly signature / hash
> algorithms, but you never stop learning ;-)

The SHA algorithms, as well as MD5 are used for message digests (hashing). 
This is used to transform the key prior to passing the key off to the 
specific algorithms key setup functions. I have also thought about, albeit 
not too much, about using message digests/signatures as a file integreity 
mechanism. 

I should also mention that deletion of files on ext3sj will use DoD standards 
for secure file deletion by overwriting the data with all 0's, all 1's, and 
then random data. So, before you delete a file, make sure you really want to 
delete it, because there won't be a way to recover it. 

-Matthew J. Fanto
