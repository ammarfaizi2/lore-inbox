Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262876AbUKXWOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbUKXWOZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 17:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbUKXWLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 17:11:43 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:59628 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262873AbUKXWJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 17:09:57 -0500
Subject: Re: Suspend 2 merge: 7/51: Reboot handler hook.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041124130750.GA12730@infradead.org>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101293507.5805.212.camel@desktop.cunninghams>
	 <20041124130750.GA12730@infradead.org>
Content-Type: text/plain
Message-Id: <1101327568.3425.14.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 07:19:28 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-25 at 00:07, Christoph Hellwig wrote:
> > -#ifdef CONFIG_SOFTWARE_SUSPEND
> > +#ifdef CONFIG_SOFTWARE_SUSPEND2
> >  	case LINUX_REBOOT_CMD_SW_SUSPEND:
> >  		{
> > -			int ret = software_suspend();
> > +			int ret = -EINVAL;
> > +			if (!(test_suspend_state(SUSPEND_DISABLED))) {
> > +				suspend_try_suspend();
> > +				ret = 0;
> > +			}
> >  			unlock_kernel();
> 
> total crap.  Thbis patch breaks the existing swsusp and turns a clean
> interface into a horrible one.  Just implement am

It doesn't break the existing suspend; rather it overrides the action. I
will however tidy it up. Sorry about that; I reversed the test a while
ago and didn't notice that it could be tidier. I note though that your
solution fails to unlock_kernel().

Regards,

Nigel

> int software_suspend(void)
> {
> 	if (test_suspend_state(SUSPEND_DISABLED))
> 		return -EINVAL;
> 	suspend_try_suspend();
> 	return 0;
> }
> 
> in your code.
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

