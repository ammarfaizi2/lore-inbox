Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbTEBU4O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 16:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbTEBU4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 16:56:14 -0400
Received: from [12.47.58.20] ([12.47.58.20]:7579 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262405AbTEBU4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 16:56:07 -0400
Date: Fri, 2 May 2003 14:05:08 -0700
From: Andrew Morton <akpm@digeo.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm4
Message-Id: <20030502140508.02d13449.akpm@digeo.com>
In-Reply-To: <1051908541.2166.40.camel@spc9.esa.lanl.gov>
References: <20030502020149.1ec3e54f.akpm@digeo.com>
	<1051905879.2166.34.camel@spc9.esa.lanl.gov>
	<20030502133405.57207c48.akpm@digeo.com>
	<1051908541.2166.40.camel@spc9.esa.lanl.gov>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2003 21:08:27.0414 (UTC) FILETIME=[F9B4C360:01C310EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> wrote:
>
> On Fri, 2003-05-02 at 14:34, Andrew Morton wrote:
> > Steven Cole <elenstev@mesatop.com> wrote:
> > >
> > > For what it's worth, kexec has worked for me on the following
> > > two systems.
> > > ...
> > > 00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
> > 
> > Are you using eepro100 or e100?  I found that e100 failed to bring up the
> > interface on restart ("failed selftest"), but eepro100 was OK.
> 
> CONFIG_EEPRO100=y
> # CONFIG_EEPRO100_PIO is not set
> # CONFIG_E100 is not set
> 
> I can test E100 again to verify if that would help.

May as well.

There's something in the driver shutdown which is failing to bring the
device into a state in which the driver startup can start it up.  Probably
just a missing device reset.  I'll bug Scott about it if we get that far.

> Also, I found that if I mistyped the argument to do-kexec.sh, the
> system would stay up, but the interface would get hosed, fixable with
> /etc/rc.d/init.d/network restart.

Yes, kexec userspace shuts down the network interfaces then tries to exec
the new kernel.  But none was loaded and the syscall returns -EINVAL. 
You're left with downed interfaces.  The script should be checking the
success of the initial image loading.


