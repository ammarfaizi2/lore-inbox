Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266664AbUGQAua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266664AbUGQAua (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 20:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUGQAua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 20:50:30 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:34461 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266664AbUGQAu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 20:50:29 -0400
Subject: Re: Preempt Violation
From: Lee Revell <rlrevell@joe-job.com>
To: Gabriel Devenyi <devenyga@mcmaster.ca>
Cc: ck@vds.kolivas.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200407162006.23456.devenyga@mcmaster.ca>
References: <200407162006.23456.devenyga@mcmaster.ca>
Content-Type: text/plain
Message-Id: <1090025439.2852.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Jul 2004 20:50:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-16 at 20:06, Gabriel Devenyi wrote:
> This one looks particularly nasty.
> 
> 20ms non-preemptible critical section violated 4 ms preempt threshold starting 
> a                                                                                        
> t sys_ioctl+0x42/0x260 and ending at sys_ioctl+0xbd/0x260
>  [<c015881d>] sys_ioctl+0xbd/0x260
>  [<c0116510>] dec_preempt_count+0x110/0x120
>  [<c015881d>] sys_ioctl+0xbd/0x260
>  [<c0103e95>] sysenter_past_esp+0x52/0x71

Yes, it looks like there are serious issues with ioctl.

Are you using either of the recent patches to fully daemonize softirqs? 
This should help a lot.  I am using this one:

http://lkml.org/lkml/2004/7/13/125

It applied against 2.6.8-mm1, with only one PPC-specific reject, I use
i386 so it doesn't matter.

Here is another:

http://lkml.org/lkml/2004/7/13/152

Have not tested yet.

Lee

