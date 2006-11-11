Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947119AbWKKGxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947119AbWKKGxF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 01:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947120AbWKKGxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 01:53:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10392 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1947119AbWKKGxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 01:53:02 -0500
Date: Fri, 10 Nov 2006 22:52:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Igor A. Valcov" <viaprog@gmail.com>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: XFS filesystem performance drop in kernels 2.6.16+
Message-Id: <20061110225257.63f91851.akpm@osdl.org>
In-Reply-To: <bde600590611100516u7b8ca1bfs74d3cc8b78eb3520@mail.gmail.com>
References: <bde600590611090930g3ab97aq3c76d7bca4ec267f@mail.gmail.com>
	<4553F3C6.2030807@sandeen.net>
	<Pine.LNX.4.61.0611101259490.6068@yvahk01.tjqt.qr>
	<bde600590611100516u7b8ca1bfs74d3cc8b78eb3520@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2006 16:16:27 +0300
"Igor A. Valcov" <viaprog@gmail.com> wrote:

> Below is a simplified version of the test program,

Boy, I hope not.  The results of this test program are of very little interest.

>     for (i = 0; i < 262144; i++) {
>         /* Write data to a big file */
>         write (nFiles [0], buf, __BYTES);
> 
>         /* Write data to small files */
>         for (f = 1; f < __FILES; f++)
>             write (nFiles [f], &f, sizeof (f));
>     }

This sits in a loop doing write(fd, buf, 4).  This is wildly inefficient -
you'd get a 10x throughput benefit and maybe 100x reduction in CPU cost
simply by switching to fwrite().

I suspect something went wrong here.
