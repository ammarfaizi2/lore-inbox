Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317365AbSH0VWY>; Tue, 27 Aug 2002 17:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317392AbSH0VWY>; Tue, 27 Aug 2002 17:22:24 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:49158 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S317365AbSH0VWX>; Tue, 27 Aug 2002 17:22:23 -0400
Date: Tue, 27 Aug 2002 14:26:38 -0700
To: Mark Atwood <mra@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: How can a process easily get a list of all it's open fd?
Message-ID: <20020827212638.GB7541@bluemug.com>
Mail-Followup-To: Mark Atwood <mra@pobox.com>, linux-kernel@vger.kernel.org
References: <200208270138.g7R1ckGx001985@eeyore.valparaiso.cl> <m38z2s1fkj.fsf@khem.blackfedora.com> <20020827160842.GA16092@riesen-pc.gr05.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020827160842.GA16092@riesen-pc.gr05.synopsys.com>
X-PGP-Key: http://web.bluemug.com/~miket/OpenPGP/5C09BB33.asc
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 06:08:42PM +0200, Alex Riesen wrote:
> tricky. You can use /proc/<getpid>/fd, and close all
> handles listed here, but this has some caveats:
> it's _very_ slow if you have many open files.
> it's not portable.
> it's not safe if you have a thread/signal handler running.
> 
> i never heard of a right way to do this.
> 
> -alex
> 
> int close_all_fd()
> {
>     char fdpath[PATH_MAX];
>     DIR * dp;
>     struct dirent * de;
>     int fd;
> 
>     sprintf(fdpath, "/proc/%d/fd", getpid());
>     dp = opendir(fdpath);

This can just be:

	dp = opendir("/proc/self/fd/");

then you don't need fdpath.

You can use sigprocmask() if you're worried about signals coming
in during this operation.

miket
