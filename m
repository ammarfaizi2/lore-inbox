Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751674AbWEaEe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbWEaEe5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 00:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbWEaEe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 00:34:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60801 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751674AbWEaEe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 00:34:56 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Ingo Molnar <mingo@elte.hu>
cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm1] lock validator: disable NMI watchdog if CONFIG_LOCKDEP, i386 
In-reply-to: Your message of "Tue, 30 May 2006 14:29:50 +0200."
             <20060530122950.GA10216@elte.hu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 31 May 2006 14:34:10 +1000
Message-ID: <7718.1149050050@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar (on Tue, 30 May 2006 14:29:50 +0200) wrote:
>
>* Mike Galbraith <efault@gmx.de> wrote:
>
>> > > BUG: warning at kernel/lockdep.c:2398/check_flags()
>> > 
>> > this one could be related to NMI. We are already disabling NMI on 
>> > x86_64, but i thought i had it fixed up for i386 - apparently not.
>> 
>> Booted with nmi_watchdog=0, no warning and no deadlock.
>
>ok, great. The patch below turns off NMI on i386 automatically.
>
>-------------------
>Subject: lock validator: disable NMI watchdog if CONFIG_LOCKDEP, i386
>From: Ingo Molnar <mingo@elte.hu>
>
>The NMI watchdog uses spinlocks (notifier chains, etc.),
>so it's not lockdep-safe at the moment.

Where?  Since 2.6.17-rc1 the notify_die() callback uses RCU, not
spinlocks.

