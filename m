Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSJUOpD>; Mon, 21 Oct 2002 10:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSJUOpD>; Mon, 21 Oct 2002 10:45:03 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:15780 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S261456AbSJUOpC>; Mon, 21 Oct 2002 10:45:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Robson <slarty2@ntlworld.com>
To: Amol Kumar Lad <amolk@ishoni.com>
Subject: Re: gzip compression of vmlinux
Date: Mon, 21 Oct 2002 15:51:07 +0100
X-Mailer: KMail [version 1.3.2]
References: <1035243705.2202.3.camel@amol.in.ishoni.com>
In-Reply-To: <1035243705.2202.3.camel@amol.in.ishoni.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021021145108.ZFJP292.mta03-svc.ntlworld.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 October 2002 12:41 am, Amol Kumar Lad wrote:
> Hi,
>  Currently we use gzip to compress vmlinux ( and finally form bzImage).
> I am planning to replace it with bzip2 . Should I go ahead with it ?
> Will it find its place in the latest kernel ?
> We save some 35k of compressed bzImage using bzip2

If you replace the gzip kernel compression with bzip2, will it be easy to 
also bzip2 initrd images?

If so, does the kernel then no longer need a gzip decompression routine? Does 
the current implementation use the same gunzipper for the kernel and initrd 
(possibly not? Is the kernel gunzipper real mode?)

If so then this is a good feature for some embedded systems which can trade a 
few seconds of boot time for smaller images, particularly if it removes the 
routine from the kernel.

How much slower is bunzip2?

On my system, bunzip2 decompresses a kernel image nearly 10x slower than gzip

[mark@athlon linux-2.4.19]$ time gunzip blah
0.08user 0.01system 0:00.09elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k

[mark@athlon linux-2.4.19]$ time bunzip2 blah.bz2 
0.83user 0.04system 0:00.87elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k

and it only gets 6% smaller

but this is a highly unscientific test.

Mark
