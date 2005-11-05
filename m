Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbVKERY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbVKERY3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 12:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbVKERY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 12:24:28 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15626 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750826AbVKERY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 12:24:28 -0500
Date: Sat, 5 Nov 2005 17:24:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Ian Campbell <icampbell@arcom.com>, Wim Van Sebroeck <wim@iguana.be>,
       linux-kernel@vger.kernel.org
Subject: Re: [WATCHDOG] sa1100_wdt.c sparse cleanups
Message-ID: <20051105172420.GC12228@flint.arm.linux.org.uk>
Mail-Followup-To: Al Viro <viro@ftp.linux.org.uk>,
	Ian Campbell <icampbell@arcom.com>,
	Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org
References: <1130921809.12578.179.camel@icampbell-debian> <20051105101026.GA28438@flint.arm.linux.org.uk> <20051105145134.GL7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105145134.GL7992@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 02:51:34PM +0000, Al Viro wrote:
> On Sat, Nov 05, 2005 at 10:10:27AM +0000, Russell King wrote:
> > It's probably better to use a union with these, eg:
> > 
> > 	union {
> > 		void __user *arg;
> > 		struct watchdog_info __user *info;
> > 		int __user *i;
> > 	} u;
> > 
> > 	u.arg = (void __user *)arg;
> > 
> > ...
> > 
> > 	ret = copy_to_user(u.info, &ident, sizeof(ident)) ? -EFAULT : 0;
> 
> Just use void __user *.

That works for copy_to_user, but not for put_user() where the type of
the pointer matters.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
