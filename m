Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTDGBJv (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 21:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263175AbTDGBJv (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 21:09:51 -0400
Received: from [12.47.58.55] ([12.47.58.55]:2516 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263173AbTDGBJv (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 21:09:51 -0400
Date: Sun, 6 Apr 2003 18:21:23 -0700
From: Andrew Morton <akpm@digeo.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: felipe_alfaro@linuxmail.org, linux-kernel@vger.kernel.org,
       andrew.grover@intel.com
Subject: Re: 2.5.66-bk12: acpi_power_off: sleeping function called from
 illegal context
Message-Id: <20030406182123.0b8ce4f4.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.50.0304061847220.2268-100000@montezuma.mastecende.com>
References: <1049668212.725.13.camel@teapot.felipe-alfaro.com>
	<Pine.LNX.4.50.0304061847220.2268-100000@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2003 01:21:18.0416 (UTC) FILETIME=[FD967500:01C2FCA3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> -	if (in_atomic())
> +	if (in_atomic() || irqs_disabled())
>  		timeout = 0;

Andy, why does the ACPI code have this test?

Is it to determine whether a caller of this functon is currently holding a
spinlock?  If so then it will only work on a preemptible kernel.

A non-preempt kernel will not increment preempt_count() when it takes a
spinlock and ACPI could mistakenly schedule away and cause a system deadlock.

