Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWAUUrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWAUUrb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 15:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWAUUrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 15:47:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51600 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932336AbWAUUra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 15:47:30 -0500
Date: Sat, 21 Jan 2006 12:47:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [BUG] Timer subsystem broken for Pentium M / early XEON / P6
 family
Message-Id: <20060121124709.28756a2d.akpm@osdl.org>
In-Reply-To: <43D22139.2000208@t-online.de>
References: <43D22139.2000208@t-online.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Knut Petersen <Knut_Petersen@t-online.de> wrote:
>
> Obviously printk time jumps. But it is also inaccurate compared against 
>  system time: 10:33:18 is
>  1116 seconds after 10:14:42, and so the printk time at 10:33:18 should 
>  be 1260+1116==2376 and not 2362.
>  That means printk time lost 14 seconds against system time in less that 
>  20 Minutes.

printk-time is really just a debugging/development thing - it doesn't try
to be serious.

We _could_ use some more accurate time function for this, but most of them
take locks, and taking locks inside printk isn't a great idea.

Plus syslogd already adds timestamps.
