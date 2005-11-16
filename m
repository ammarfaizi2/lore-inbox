Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbVKPFzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbVKPFzh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 00:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbVKPFzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 00:55:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:8333 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030183AbVKPFzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 00:55:36 -0500
To: Steven Rostedt <rostedt@goodmis.org>
Cc: pavel@suse.cz, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -rt] race condition in fs/compat.c with compat_sys_ioctl
References: <1131821278.5047.8.camel@localhost.localdomain>
	<5bdc1c8b0511121725u6df7ad9csb9cb56777fa6fe64@mail.gmail.com>
	<Pine.LNX.4.58.0511122149020.25152@localhost.localdomain>
	<5bdc1c8b0511121914v12dc4402u424fbaf416bf3710@mail.gmail.com>
	<1131853456.5047.14.camel@localhost.localdomain>
	<5bdc1c8b0511130634h501fb565v58906bdfae788814@mail.gmail.com>
	<1131994030.5047.17.camel@localhost.localdomain>
	<5bdc1c8b0511141057l60a2e778x89155cd5484d532f@mail.gmail.com>
	<1132115386.5047.61.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 16 Nov 2005 06:55:28 +0100
In-Reply-To: <1132115386.5047.61.camel@localhost.localdomain>
Message-ID: <p73y83pp25r.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:
> 
> That's the problem. I found out that one ioctl might sleep holding the
> sem and won't be woken up until another process calls another ioctl to
> wake it up. But unfortunately, the one waking up the sleeper will block
> on the sem.  (the killer was tty_wait_until_sent)

You should have looked into mainline first. The semaphore is already gone
because it wasn't even needed anymore.

-Andi
