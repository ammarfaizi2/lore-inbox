Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271941AbTHHWDC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 18:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271973AbTHHWDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 18:03:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:36297 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271941AbTHHWDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 18:03:00 -0400
Date: Fri, 8 Aug 2003 14:49:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Romeyke <art1@it-netservice.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.5:  mlock broken?
Message-Id: <20030808144937.6055a798.akpm@osdl.org>
In-Reply-To: <20030808233213.4ffb2c84.art1@it-netservice.de>
References: <20030808233213.4ffb2c84.art1@it-netservice.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Romeyke <art1@it-netservice.de> wrote:
>
> Hi folks,
> 
> By testing 2.6.0-test2, I detected that the glibc-function mlock(),
> provided by /sys/mlock.h seems to be a deadlock in some cases on 2.5
> 
> If you want to lock more memory than physical RAM could be freed, the
> mlock() does not return with an errorcode as under 2.4.21 does.
> The system hangs around. This problem was catched under x86 and s390
> architecture by using Debian distribution (woody and unstable) and
> others  with the well known memtest program written by Charles Cazabon
> from   http://www.qcc.ca/~charlesc/software/memtester/ (ver. 2.93.1).
> 

2.4 kernels have a little check which prevents a single process from
mlocking more than half of physical memory.  So you need to run two
processes to kill a 2.4 box with mlock.

Some people want to be able to mlock more memory than that in a single
process, so the check was removed in 2.6.  It was pretty pointless.

