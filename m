Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265604AbUAJWqd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 17:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265609AbUAJWqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 17:46:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:26850 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265604AbUAJWqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 17:46:32 -0500
Date: Sat, 10 Jan 2004 14:46:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: suspend/resume support for PIT (time.c)
Message-Id: <20040110144624.1571488f.akpm@osdl.org>
In-Reply-To: <20040110200332.GA1327@elf.ucw.cz>
References: <20040110200332.GA1327@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> +static int pit_resume(struct sys_device *dev)
>  +{
>  +	write_seqlock_irq(&xtime_lock);
>  +	xtime.tv_sec = get_cmos_time() + clock_cmos_diff;
>  +	xtime.tv_nsec = 0; 
>  +	write_sequnlock_irq(&xtime_lock);
>  +	return 0;
>  +}

Have you checked the lock ranking here?  get_cmos_time() takes a ton of
locks, especially if EFI is enabled.  Do all those rank inside xtime_lock?

It _looks_ right, but perhaps it would be saner to move the get_coms_time()
call outside the lock?


