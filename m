Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbVFXPbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbVFXPbb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbVFXPbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:31:31 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:47492 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262675AbVFXPb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:31:27 -0400
Date: Fri, 24 Jun 2005 08:19:25 -0400
From: Christopher Li <hg@chrisli.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andrea Arcangeli <andrea@suse.de>,
       Petr Baudis <pasky@ucw.cz>, mercurial@selenic.com,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Message-ID: <20050624121925.GB9519@64m.dyndns.org>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624130604.GK17715@g5.random> <20050624133952.GB7445@thunk.org> <4d8e3fd3050624064620a4945e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8e3fd3050624064620a4945e@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Jun 24, 2005 at 03:46:21PM +0200, Paolo Ciarrocchi wrote:
> > 
> > Which do you think is going to be faster to operate from a cold start
> > using 4200 rpm laptop drives?  :-)
> > 
> >                                                - Ted
> 
> That's quite intersting, what the rational behind such a difference in
> terms of disk occupation ?
>

Let me see. Mercurial using delta or full storage for the repository.
It insert a full node when it detect that delta it need to reach
certain node is too big. It just like MPEG movies, most of the frame
is delta to the previous frame.  Once a while you have full frame to
allow you seek to.

But git has delta as well right? Another factor is that all file has
same path in mercurial using the same storage file. So in mercurial
it has far less file to store in the repository. Each file has two repository
files, the data storage file and the index file. Remember that file system
like ext3 is using blocks, if you store very small stuff on a file, it is
still going to take at least one block on disk. So that will defeat the delta
compression if the delta is always on a new file.


Chris

