Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317444AbSGOMGM>; Mon, 15 Jul 2002 08:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317446AbSGOMGM>; Mon, 15 Jul 2002 08:06:12 -0400
Received: from mail.zmailer.org ([62.240.94.4]:38288 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S317444AbSGOMGL>;
	Mon, 15 Jul 2002 08:06:11 -0400
Date: Mon, 15 Jul 2002 15:09:04 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Sam Vilain <sam@vilain.net>
Cc: Dax Kelson <dax@gurulabs.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020715150904.S28720@mea-ext.zmailer.org>
References: <1026490866.5316.41.camel@thud> <1026679245.15054.9.camel@thud> <E17U1BD-0000m0-00@hofmann> <1026736251.13885.108.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026736251.13885.108.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Jul 15, 2002 at 01:30:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 01:30:51PM +0100, Alan Cox wrote:
> On Mon, 2002-07-15 at 09:26, Sam Vilain wrote:
> > You are testing for a mail server - how many mailboxes are in your spool 
> > directory for the tests?  Try it with about five to ten thousand
> > mailboxes and see how your results vary.
> 
> If your mail server can't get heirarchical mail spools right, get one
> that can. 

   Long ago (10-15 internet-years ago..) I followed testing of
   FFS-family of filesystems in Squid cache.

   We noticed at Solaris machines using UFS, than when the directory
   data size grew above the number of blocks directly addressable by
   the direct-index pointers in the i-node, system speed plummeted.
   (Or perhaps it was something a bit smaller, like 32 kB)

   Consider:  4 kB block size, 12 direct indexes: 48 kB directory size.

   Spend 16 bytes for each file name + auxiliary data: 3000 files/subdirs

   Optimal would be to store the files inside only the first block,
   e.g. the directory shall not grow over 4k (or 1k, or ..)

   Name subdirs as:  00 thru 7F (128+2, 12 bytes ?)
   Possibly do that in 2 layers:  128^2 = 16384 subdirs, each
   with 50 long named users (even more files?): 820 000 users.

   Tune the subdir hashing function to suit your application, and
   you should be happy.


   Putting all your eggs in one basket (files in one directory)
   is not a smart thing.


> Alan

/Matti Aarnio
