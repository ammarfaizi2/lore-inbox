Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267756AbUH2LtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267756AbUH2LtQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 07:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267754AbUH2LtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 07:49:16 -0400
Received: from clusterfw.beeline3G.net ([217.118.66.232]:27213 "EHLO
	crimson.namesys.com") by vger.kernel.org with ESMTP id S267745AbUH2LtI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 07:49:08 -0400
Date: Sun, 29 Aug 2004 15:42:26 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: Steve Bergman <steve@rueb.com>
Cc: Hans Reiser <reiser@namesys.com>, Nikita Danilov <nikita@clusterfs.com>,
       Christoph Hellwig <hch@lst.de>, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20040829114226.GJ5108@backtop.namesys.com>
References: <20040826130718.GB820@lst.de> <1093526273.11694.8.camel@leto.cs.pocnet.net> <20040826132439.GA1188@lst.de> <1093527307.11694.23.camel@leto.cs.pocnet.net> <20040826134034.GA1470@lst.de> <1093528683.11694.36.camel@leto.cs.pocnet.net> <412E786E.5080608@namesys.com> <16687.9051.311225.697109@thebsh.namesys.com> <412F7A59.8060508@namesys.com> <1093645747.17445.19.camel@voyager.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093645747.17445.19.camel@voyager.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 05:29:07PM -0500, Steve Bergman wrote:
> On Fri, 2004-08-27 at 11:15 -0700, Hans Reiser wrote:
> > >
> > If you ask real users, they say that reiser4 is fast, and their 
> > experience matches our benchmark.  You can criticize the benchmark if 
> > you want, but then you should run your own and publish it.
> > 
> 
> 
> As a "real" desktop user who just converted all his partitions from ext3
> to reiser4, I have not, as yet, noticed any startling performance
> increase.  Being slightly slightly irked to hear that the benchmark
> numbers that have been paraded around on Slashdot and the internet in
> general, at ext3's expense, have had reiser4's "bad" results surgically
> extracted, I am running my own benchmarks to get the real story on
> reiser4/ext3 mongo performance on my, rather average, desktop hardware.
> 
> I am using the latest Mongo on FC/rawhide and the 2.6.8.1-mm4 kernel.
> 
> Unfortunately, I get an error from mongo.pl that "Done" is not a numeric
> argument at line 439.
> 
> I have done this to fix it:
> 
> 
> --- mongo.pl    2004-08-27 17:07:01.681723313 -0500
> +++ mongo_fixed.pl      2004-08-27 17:06:51.369306735 -0500
> @@ -429,8 +429,8 @@
>         if ( -e ${ERR_FILE}) {
>             &DIE ("\nEXITED WITH FAIL\n");
>         }
> -       my $real = (split ' ', $time_output[0])[1];
> -       my $cpu  = (split ' ', $time_output[2])[1];
> +       my $real = (split ' ', $time_output[1])[1];
> +       my $cpu  = (split ' ', $time_output[3])[1];
>   
>         unless ( $real =~ /\s*\d+/ && $cpu =~ /\s*\d+/) {
>           LOG "@time_output";
> 
> 
> What it gets me is the "real" line of the "time" output for "STAT
> REAL_TIME" and the "sys" line of the "time" output for "STAT CPU_TIME".
> i.e. only system time is counted. I believe this was the intent of the
> original code, but want to verify before continuing.

it works on our test servers which are SuSE9.0/9.1.

I think there is a dependency on system utilities,  "Done" is not printed by
mongo.pl or any other program from the mongo package.

It would be nice to tell us what linux distro you are using and what mongo
phase fails. 

> Thanks,
> Steve Bergman

Thanks.

-- 
Alex.
