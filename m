Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbTDGAHY (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 20:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbTDGAHY (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 20:07:24 -0400
Received: from [12.47.58.55] ([12.47.58.55]:55249 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263162AbTDGAHW (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 20:07:22 -0400
Date: Sun, 6 Apr 2003 17:18:55 -0700
From: Andrew Morton <akpm@digeo.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: felipe_alfaro@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5: NFS troubles
Message-Id: <20030406171855.6bd3552d.akpm@digeo.com>
In-Reply-To: <shsbrzjn5of.fsf@charged.uio.no>
References: <1049630768.592.24.camel@teapot.felipe-alfaro.com>
	<shsbrzjn5of.fsf@charged.uio.no>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2003 00:18:50.0401 (UTC) FILETIME=[4398C110:01C2FC9B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> >>>>> " " == Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> writes:
> 
>      > Hello, I'm testing 2.5.66-bk11 on my NFS server running
>      > RH9. When I run the "find" command on the NFS share from my
>      > client computer, it hangs forever after a while, but it always
>      > hangs *exactly* at the same place every time. However, if I
>      > boot into NFS with RH9's standard kernel (2.4.20), the "find"
>      > command works as expected and is able to complete with any
>      > hangs or delays.
> 
>      > My NFS server (hostname glass) has a whole ext3 partition -
>      > mounted under /data - formatted as ext3.
> 
> The 2.5.66 ext3 code still has some issues with respect to NFS readdir
> cookies.

It might do.  I have Ted's htree/NFS fixes in there though.

Felipe, please do 

	dumpe2fs /dev/hdXX | grep features

if it shows dir_index then it might be an ext3 problem.  If not then it is
probably an NFS problem.

If it does have dir_index set then please run

	tune2fs -O ^dir_index /dev/hdXX

and reboot and retest.

