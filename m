Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271333AbTHDAFa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 20:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271335AbTHDAF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 20:05:29 -0400
Received: from waste.org ([209.173.204.2]:57236 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S271333AbTHDAFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 20:05:24 -0400
Date: Sun, 3 Aug 2003 19:05:14 -0500
From: Matt Mackall <mpm@selenic.com>
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Cc: Andrew Morton <akpm@osdl.org>, Shane Shrybman <shrybman@sympatico.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm3 and mysql
Message-ID: <20030804000514.GY22824@waste.org>
References: <1059871132.2302.33.camel@mars.goatskin.org> <20030802180410.265dfe40.akpm@osdl.org> <200308032258.17450.rathamahata@php4.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308032258.17450.rathamahata@php4.ru>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 10:58:17PM +0400, Sergey S. Kostyliov wrote:
> Hello Andrew,
> 
> On Sunday 03 August 2003 05:04, Andrew Morton wrote:
> > Shane Shrybman <shrybman@sympatico.ca> wrote:
> 
> >
> > > One last thing, I have started seeing mysql database corruption
> > > recently. I am not sure it is a kernel problem. And I don't know the
> > > exact steps to reproduce it, but I think I started seeing it with
> > > -test2-mm2. I haven't ever seen db corruption in the 8-12 months I have
> > > being playing with mysql/php.
> >
> > hm, that's a worry.  No additional info available?
> 
> I also suffer from this problem (I'm speaking about heavy InnoDB corruption
> here), but with vanilla 2.6.0-test2. I can't blame MySQL/InnoDB because
> there are a lot of MySQL boxes around of me with the same (in fact the box
> wich failed is replication slave) or allmost the same database setup.
> All other boxes (2.4 kernel) works fine up to now.

All Linux kernels prior to 2.6.0-test2-mm3-1 would silently fail to
complete fsync() and msync() operations if they encountered an I/O
error, resulting in corruption. If a particular disk subsystem was
producing these errors, the symptoms would likely be:

- no error reported
- no messages in logs
- independent of kernel version, etc.
- suddenly appear at some point in drive life
- works flawlessly on other machines 

If you can reproduce this corruption, please try running against mm3-1
and seeing if it reports problems (both to fsync and in logs).

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
