Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268690AbTBZJRI>; Wed, 26 Feb 2003 04:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268691AbTBZJRI>; Wed, 26 Feb 2003 04:17:08 -0500
Received: from packet.digeo.com ([12.110.80.53]:36293 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268690AbTBZJRH>;
	Wed, 26 Feb 2003 04:17:07 -0500
Date: Wed, 26 Feb 2003 01:27:51 -0800
From: Andrew Morton <akpm@digeo.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: torvalds@transmeta.com, davej@codemonkey.org.uk, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] fix preempt-issues with smp_call_function()
Message-Id: <20030226012751.61842c39.akpm@digeo.com>
In-Reply-To: <200302251908.55097.schlicht@uni-mannheim.de>
References: <200302251908.55097.schlicht@uni-mannheim.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Feb 2003 09:27:17.0491 (UTC) FILETIME=[413A3430:01C2DD79]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
>
> Hello,
> 
> here is a patch to solve all (I hope I missed none) possible problems that 
> could occur on SMP machines running a preemptible kernel when 
> smp_call_function() calls a function which should be also executed on the 
> current processor.
> 

Patch looks pretty good, thanks.  Fixes a real bug.

I worry a little about the s390/s390x change.  smp_ctl_set_bit() and
smp_ctl_clear_bit().  The functions which are being called on local and
remote are fairly different.  I'm sure it's OK, but...  I changed that bit
to open-code the preempt_disable/enable.

The arch/x86_64/kernel/bluesmoke.c change looks right.  Seems that someone
didn't understand the smp_call_function() API in there.

