Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbUEGB3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUEGB3q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 21:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUEGB3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 21:29:46 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:10445 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S262398AbUEGB3o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 21:29:44 -0400
Subject: Re: Random file I/O regressions in 2.6
From: Peter Zaitsev <peter@mysql.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, alexeyk@mysql.com, linuxram@us.ibm.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <409ACF04.8010805@yahoo.com.au>
References: <200405022357.59415.alexeyk@mysql.com>
	 <200405050301.32355.alexeyk@mysql.com>
	 <20040504162037.6deccda4.akpm@osdl.org>
	 <200405060204.51591.alexeyk@mysql.com>
	 <20040506014307.1a97d23b.akpm@osdl.org>
	 <1083867233.2420.29.camel@abyss.local>
	 <20040506144933.1918317f.akpm@osdl.org>  <409ACF04.8010805@yahoo.com.au>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1083893376.2420.194.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 06 May 2004 18:29:37 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-06 at 16:49, Nick Piggin wrote:

> > 
> > `nomtime' would be simpler and safer to implement, but not as nice.
> > 
> > But we need those numbers first.  I'll take a look.
> > 
> 
> Can they use fdatasync? Does it do the right thing on Linux?

Nick,

You're right. fdatasync suppose to be solution in this case and actually
test supports this mode as well as MySQL does :)

On other hand if you rather use O_DSYNC it does not seems to work being
mapped to O_SYNC. 

But the thing I'm mostly interested in is O_DIRECT. It seems to be the
best solution for many database needs, especially used together with
asynchronous IO. There is however no matching option which should not
flush MetaData.



-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com



