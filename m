Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbUCRVMZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 16:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262968AbUCRVMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 16:12:25 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:53683 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S262967AbUCRVKj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 16:10:39 -0500
Subject: Re: True  fsync() in Linux (on IDE)
From: Peter Zaitsev <peter@mysql.com>
To: Chris Mason <mason@suse.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1079643740.11057.16.camel@watt.suse.com>
References: <1079572101.2748.711.camel@abyss.local>
	 <20040318064757.GA1072@suse.de> <1079639060.3102.282.camel@abyss.local>
	 <20040318194745.GA2314@suse.de>  <1079640699.11062.1.camel@watt.suse.com>
	 <1079641026.2447.327.camel@abyss.local>
	 <1079642001.11057.7.camel@watt.suse.com>
	 <1079642801.2447.369.camel@abyss.local>
	 <1079643740.11057.16.camel@watt.suse.com>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1079644190.2450.405.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 18 Mar 2004 13:09:52 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 13:02, Chris Mason wrote:

> > In the former case cache is surely not flushed. 
> > 
> Hmmm, is it reiser?  For both 2.4 reiserfs and ext3, the flush happens
> when you commit.  ext3 always commits on fsync and reiser only commits
> when you've changed metadata.

Oh. Yes. This is Reiser, I did not think it is FS issue.
I'll know to stay away from ReiserFS now.

> 
> Thanks to Jens, the 2.6 barrier patch has a nice clean way to allow
> barriers on fsync, O_SYNC, O_DIRECT, etc, so we can make IDE drives much
> safer than the 2.4 code did.  

Great.

> > I was also surprised to see this simple test case has so different
> > performance with default and "deadline" IO scheduler   -  1.6 vs 0.5 sec
> > per 1000 fsync's.
> 
> Not sure on that one, both cases are generating tons of unplugs, the
> drive is just responding insanely fast.

Well why it would be slow if it has write cache off.


-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com

Meet the MySQL Team at User Conference 2004! (April 14-16, Orlando,FL)
  http://www.mysql.com/uc2004/

