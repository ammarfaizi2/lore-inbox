Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280149AbRKEDNq>; Sun, 4 Nov 2001 22:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280150AbRKEDNh>; Sun, 4 Nov 2001 22:13:37 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:52236 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S280149AbRKEDNZ>;
	Sun, 4 Nov 2001 22:13:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Jeff Dike <jdike@karaya.com>
Subject: Re: Special Kernel Modification
Date: Sun, 4 Nov 2001 19:13:15 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200111050402.XAA05891@ccure.karaya.com>
In-Reply-To: <200111050402.XAA05891@ccure.karaya.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E160aCK-0001Fs-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff, 
>  Mounting it synchronous will  disable caching in the VM. 
Who told you that? Synchronous mounting turns off write buffering. Even with 
"-o sync" writes will still end up in the page cache, they'll just be 
commited immediately. In case you don't believe me, here's a trivial test on 
a block device mounted -o sync (ext3):

bodnar42:/mnt# time cat linux-2.4.13.tar.bz2 > /dev/null

real    0m2.837s
user    0m0.040s
sys     0m0.350s
bodnar42:/mnt# time cat linux-2.4.13.tar.bz2 > /dev/null

real    0m0.328s
user    0m0.010s
sys     0m0.240s
bodnar42:/mnt#

Trust me, the factor of 8 performace improvement the second time is not due 
to lucky head positioning or anything, that's coming straight out of cache.

> Another possibility is hostfs.  You can directly mount a host directory
> inside UML.  That can obviously be shared between UMLs, so you again
> eliminate all the duplication.
Er, it will be shared in the host's context, but each VM will still have 
their own copy in the page cache. This is no better than a COW'ed block device

-Ryan
