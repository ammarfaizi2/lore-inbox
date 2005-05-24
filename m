Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVEXA3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVEXA3F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 20:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVEXA3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 20:29:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:33940 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261151AbVEXA2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 20:28:51 -0400
Date: Mon, 23 May 2005 17:29:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: george@mvista.com
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc4-mm2 2/2] posix-timers: use try_to_del_timer_sync()
Message-Id: <20050523172923.26068053.akpm@osdl.org>
In-Reply-To: <42926F83.9050608@mvista.com>
References: <42909DC2.7922E05D@tv-sign.ru>
	<42926F83.9050608@mvista.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger <george@mvista.com> wrote:
>
> Oleg Nesterov wrote:
> > sys_timer_settime/sys_timer_delete needs to delete k_itimer->real.timer
> > synchronously while holding ->it_lock, which is also locked in posix_timer_fn.
> > 
> > This patch removes timer_active/set_timer_inactive which plays with
> > timer_list's internals in favour of using try_to_del_timer_sync(),
> > which was introduced in the previous patch.
> 
> Is there a particular reason for this, like it does not work, for example, or 
> are you just trying to clean up code?

The posix-timers code is poking about in the internals of the timer_list
implementation.  It shouldn't, and finding some way to fix that up is
desirable.
