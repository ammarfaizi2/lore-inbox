Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbTIOQeH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 12:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbTIOQeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 12:34:07 -0400
Received: from iafilius.xs4all.nl ([213.84.160.212]:9186 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id S261549AbTIOQeC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 12:34:02 -0400
Date: Mon, 15 Sep 2003 18:34:00 +0200 (CEST)
From: Arjan Filius <iafilius@xs4all.nl>
X-X-Sender: arjan@sjoerd.sjoerdnet
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: Oleg Drokin <green@namesys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Another ReiserFS (rpm database) issue (2.6.0-test5)
In-Reply-To: <20030915084031.GA510@namesys.com>
Message-ID: <Pine.LNX.4.53.0309151824230.24113@sjoerd.sjoerdnet>
References: <Pine.LNX.4.53.0309141826030.9944@sjoerd.sjoerdnet>
 <20030915084031.GA510@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 15 Sep 2003, Oleg Drokin wrote:

> Hello!
>
> On Sun, Sep 14, 2003 at 06:30:33PM +0200, Arjan Filius wrote:
> > lseek(9, 36110336, SEEK_SET)            = 36110336
> > read(9, "\4\0\354\377\3\0\n0\344\377\326\377\344\377\0\0\0\0\0\0"..., 65536) = 65536
> > lseek(9, 7995392, SEEK_SET)             = 7995392
> > read(9, "\2\0t@\0\0\366\377\0\0\341\377\357\377\0\0\0\0\0\0\0\0"..., 65536) = 65536
> > lseek(9, 37879808, SEEK_SET)            = 37879808
> > read(9, "\4\0\352\377\3\0=@\342\377\324\377\342\377\0\0\0\0\0\0"..., 65536) = 65536
> > lseek(9, 34275328, SEEK_SET)            = 34275328
> > read(9, "\0\0\372\377\0\0\366\377\0\0\337\377\355\377\0\0\0\0\0"..., 65536) = 65536
> > <and here it "hangs" forever>
>
> You mean, strace does not log more syscalls?
That is correct, but it still keeps consuming a lot CPU time.

>
> What if you mount your reiserfs partition with "-o nolargeio=1" mount option?

Hey! this seems to "fix" it!
With this option even my original "problem rpm databse" is rebuild in a
few minutes, and without consuming that much memory, and without any
errors!

Without the "nolargeio=1" i'd had to add a lot of swap (on my 1.5Gb RAM
system), else it got just terminated. And adding a lot of swap i still got
some fatal rpm errors.

So it seems the "nolargeio=1" solves all my problems.

Thanks!


>
> > -rw-r--r--    1 root     root        16384 Sep 14 18:16 conflictsindex.rpm
> > -rw-r--r--    1 root     root     83431424 Sep 14 18:16 fileindex.rpm
> > -rw-r--r--    1 root     root        57344 Sep 14 18:16 groupindex.rpm
> > -rw-r--r--    1 root     root        94208 Sep 14 18:16 nameindex.rpm
> > -rw-r--r--    1 root     root     54840904 Sep 14 18:16 packages.rpm
> > -rw-r--r--    1 root     root       331776 Sep 14 18:16 providesindex.rpm
> > -rw-r--r--    1 root     root     42246144 Sep 14 18:16 requiredby.rpm
> > -rw-r--r--    1 root     root        16384 Sep 14 18:16 triggerindex.rpm
>
> None of that fits into "bigger than 4G" cathegory.

I'd tried for just to be sure the largefile patch recently on this list,
however no success.

>
> Bye,
>     Oleg
>
>

-- 
Arjan Filius
mailto:iafilius@xs4all.nl
