Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267708AbUIPWCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267708AbUIPWCi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267831AbUIPWCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:02:38 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:36327 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S267708AbUIPWCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:02:34 -0400
Subject: Re: [PATCH] Suspend2 merge: New exports.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040916143322.GB32352@kroah.com>
References: <1095333619.3327.189.camel@laptop.cunninghams>
	 <20040916143322.GB32352@kroah.com>
Content-Type: text/plain
Message-Id: <1095372242.5897.10.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 17 Sep 2004 08:04:03 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-09-17 at 00:33, Greg KH wrote:
> On Thu, Sep 16, 2004 at 09:20:19PM +1000, Nigel Cunningham wrote:
> > 
> > This patch adds exports for functions used by suspend2. Needed, of
> > course, when suspend is compiled as modules.
> 
> Why even allow suspend as a module?  It seems like a pretty core chunk
> of code that should be present all the time.

It only needs to be loaded when you're suspending/resuming, so it's not
really core. Building it as modules also allows upgrading (at least
sometimes) without rebooting. Finally, my version of suspend is a lot
bigger than the implementation in the kernel at the moment because it
includes many more features.

[...]

> Why this change?  buffer_busy() is not exported now.

You're right. It's a holdover from 2.4 that I missed cleaning.

> > -#ifdef CONFIG_COMPAT
> >  EXPORT_SYMBOL(sys_ioctl);
> > -#endif
> 
> What ioctls does suspend2 call?  That seems very strange.

The console driver. People objected to direct usage of console functions
and suggested I use /dev/console for doing output. That's what I'm doing
now, although I do still have some direct usage to seek to get rid of.
(I'm not claiming my code is finished and perfect!)

> Why is the include needed here just to export a symbol (nevermind the
> fact that we should never export tainted in the first place.)

They're unrelated, actually. There used to be a couple of lines in here
that stopped us syncing if we oops part way through suspending. With
recent changes, it's no longer necessary. The fact that the include
isn't needed anymore wasn't noticed.

As to exporting tainted, I thought about this on the way to bed last
night, after another email. As I said previously, I was exporting it so
I could set a tainted flag when we've suspended, to save driver authors
headaches. It never occurred to me - as it has now - that this also
allows unscrupulous people to turn off flags. I don't think tainting is
necessary any more, so I'll happily drop this.

Regards,

Nigel

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

