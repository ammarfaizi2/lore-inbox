Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbWGUMGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbWGUMGd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 08:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbWGUMGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 08:06:33 -0400
Received: from pat.uio.no ([129.240.10.4]:38596 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161051AbWGUMGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 08:06:32 -0400
Subject: Re: ext4 features
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44C045B4.3040609@tmr.com>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com>
	 <20060705125956.GA529@fieldses.org>
	 <1152128033.22345.17.camel@lade.trondhjem.org>  <44AC2D9A.7020401@tmr.com>
	 <1152135740.22345.42.camel@lade.trondhjem.org>  <44B01DEF.9070607@tmr.com>
	 <1152562135.6220.7.camel@lade.trondhjem.org>  <44B2D6AA.3090707@tmr.com>
	 <1152585383.10156.9.camel@lade.trondhjem.org>  <44C045B4.3040609@tmr.com>
Content-Type: text/plain
Date: Fri, 21 Jul 2006 08:06:10 -0400
Message-Id: <1153483570.21909.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5, required 12,
	autolearn=disabled, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-20 at 23:10 -0400, Bill Davidsen wrote:
> Trond Myklebust wrote:
> 
> >On Mon, 2006-07-10 at 18:37 -0400, Bill Davidsen wrote:
> >  
> >
> >Linus might accept it, but I won't. It is totally unnecessary.
> >  
> >
> 
> By "totally unnecessary" you mean "I don't see why it's useful."
> 
> The reason for using noatime is to avoid generating disk activity while 
> the data is being accessed. It's not usually used to hide the fact that 
> the data has been used and is therefore useful to someone. In a perfect 
> world, where money is no object, all data is on very fast storage which 
> never fails. In my world I would like to identify which data, source or 
> documentation, has been referenced over some period of time. This is 
> useful for moving some data to slower (yes I mean less expensive) storage.
> 
> It's also useful to identify stuff which no one has used in a very long 
> time and which is a candidate for not being on line at all.
> 
> By keeping lazy track of access time it's possible to still have that 
> data, with minimal disk access cost. And to some people that can be 
> really useful, such as those of us who have to justify expenditures.

What you propose violates both POSIX and SuSv3. close() does not update
the atime on a file. I can't see anyone accepting that there is a need
for this.
If you want to force close to update atime automatically on your system,
then you should already be able to hack up libc to do it. There are no
discernable advantages to doing it in the kernel.

