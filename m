Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWATMLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWATMLh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 07:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWATMLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 07:11:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24021 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750871AbWATMLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 07:11:36 -0500
Date: Fri, 20 Jan 2006 04:11:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Titov <a.titov@host.bg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM Killer killing whole system
Message-Id: <20060120041114.7f06ecd8.akpm@osdl.org>
In-Reply-To: <1137337516.11767.50.camel@localhost>
References: <1137337516.11767.50.camel@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Titov <a.titov@host.bg> wrote:
>
> Yesterday I accidently noticed few OOM killer messages in the system log
>  and leaved a console tailing the log for the night. In 6 in the morning
>  OOM killer got mad generating 500 lines in the log and 5 minutes later
>  system closed the ssh connection and became inresponsive. The guy in the
>  datacenter told me that when he attached keyboard even caps lock was not
>  working. Inspite of this the system still was responsive (only to) ping.
> 
>  The strange thing is this machine is relatively light loaded - now after
>  6 hours being up free shows:
>               total       used       free     shared    buffers    cached
>  Mem:       2075468    1148564     926904          0     123472    314516
>  -/+ buffers/cache:     710576    1364892
>  Swap:      1004020          0    1004020
> 
>  Load average stays under 0.5 most of the time. In 6 in the morning it
>  should be almost no load (there is no crons scheduled at that time).
> 
>  I'm attaching messages from the log and my .config.

What kernel version?  <looks in config.gz>.   2.6.15.


> Jan 15 06:05:09 vip Normal free:3700kB min:3756kB low:4692kB high:5632kB active:9964kB inactive:8532kB present:901120kB pages_scanned:19628 

Pretty much all of the ZONE_NORMAL memory is AWOL.

> Jan 15 06:05:09 vip 216477 pages slab

It's all in slab.  800MB.

I'd be suspecting a slab memory leak.  If it happens again, please take a
copy of /proc/slabinfo, send it.

