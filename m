Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTDUBcc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 21:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263753AbTDUBcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 21:32:32 -0400
Received: from adsl-66-120-100-11.dsl.sndg02.pacbell.net ([66.120.100.11]:5903
	"HELO glacier.arctrix.com") by vger.kernel.org with SMTP
	id S263752AbTDUBcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 21:32:31 -0400
Date: Sun, 20 Apr 2003 18:46:04 -0700
From: Neil Schemenauer <nas@python.ca>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] new IO scheduler for 2.4.20
Message-ID: <20030421014603.GA18971@glacier.arctrix.com>
References: <20030417172818.GA8848@glacier.arctrix.com> <20030417134103.4e69fc1b.akpm@digeo.com> <20030420182648.GA18120@glacier.arctrix.com> <200304210006.23762.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304210006.23762.m.c.p@wolk-project.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen wrote:
> what about i/o throughput, bonnie or such?

bonnie++
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
               Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
2.4.20           1G           36236  18 13423   7           29948  11 210.1   0
2.4.20-nas1      1G           35998  18 12076   7           19056   9 206.7   0
2.4.20-nas2      1G           37450  18 12101   7           19363   9 210.7   0

Read throughput has definitely taken a hit.  I don't know why.  Perhaps
the elevator needs to have a little more relaxed definition of
contiguous requests.  Right now it only puts requests together if they
are perfectly contiguous (the first sector in one request is the next
after the last sector of another).  I'll try to test that.

Any other theories?

  Neil
