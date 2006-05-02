Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWEBIaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWEBIaV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 04:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWEBIaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 04:30:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29156 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932509AbWEBIaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 04:30:20 -0400
Subject: Re: [RFC] kernel facilities for cache prefetching
From: Arjan van de Ven <arjan@infradead.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
In-Reply-To: <20060502080619.GA5406@mail.ustc.edu.cn>
References: <20060502075049.GA5000@mail.ustc.edu.cn>
	 <1146556724.32045.19.camel@laptopd505.fenrus.org>
	 <20060502080619.GA5406@mail.ustc.edu.cn>
Content-Type: text/plain
Date: Tue, 02 May 2006 10:30:17 +0200
Message-Id: <1146558617.32045.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-02 at 16:06 +0800, Wu Fengguang wrote:
> On Tue, May 02, 2006 at 09:58:44AM +0200, Arjan van de Ven wrote:
> > 
> > > 
> > > PREVIOUS WORKS
> > > 
> > > 	There has been some similar efforts, i.e.
> > > 		- Linux: Boot Time Speedups Through Precaching
> > > 		  http://kerneltrap.org/node/2157
> > > 		- Andrew Morton's kernel module solution
> > > 		  http://www.zip.com.au/~akpm/linux/fboot.tar.gz
> > > 		- preload - adaptive readahead daemon
> > > 		  http://sourceforge.net/projects/preload
> > 
> > you missed the solution Fedora deploys since over a year using readahead
> 
> Thanks, and sorry for more previous works that I failed to mention here :)

one interesting thing that came out of the fedora readahead work is that
most of the bootup isn't actually IO bound. My test machine for example
can load all the data into ram in about 10 seconds, so that the rest of
the boot is basically IO-less. But that still takes 2 minutes....
So I'm not entirely sure how much you can win by just attacking this.

Another interesting approach would be to actually put all the data you
want to use in a non-fragmented, sequential area on disk somehow (there
is an OLS paper submitted about that by Ben) so that at least the disk
side is seekless... 

