Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWDUVNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWDUVNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWDUVNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:13:54 -0400
Received: from tayrelbas01.tay.hp.com ([161.114.80.244]:17093 "EHLO
	tayrelbas01.tay.hp.com") by vger.kernel.org with ESMTP
	id S964781AbWDUVNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:13:53 -0400
Date: Fri, 21 Apr 2006 17:13:51 -0400
From: Amy Griffis <amy.griffis@hp.com>
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 5/11] security: AppArmor - Filesystem
Message-ID: <20060421211351.GA1903@zk3.dec.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419174946.29149.40949.sendpatchset@ermintrude.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419174946.29149.40949.sendpatchset@ermintrude.int.wirex.com>
X-Mailer: Mutt http://www.mutt.org/
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Jones wrote:     [Wed Apr 19 2006, 01:49:46PM EDT]
> This patch implements the AppArmor file structure underneath securityfs.
> Securityfs is normally mounted as /sys/kernel/security
> 
> The following files are created under /sys/kernel/security/apparmor
> 	control
> 		audit	   - Controls the global setting for auditing all
> 			     accesses.
> 		complain   - Controls the global setting for learning mode
> 			     (usually this is set per profile rather than
> 			     globally)
> 		debug	   - Controls whether debugging is enabled.
> 			     This needs to be made more fine grained
> 		logsyscall - Controls whether when logging to the audit 
> 			     subsystem full syscall auditing is enabled.

Why not use audit's audit_enabled toggle instead?  This would
eliminate the overhead of data collection for syscall auditing, in
addition to eliminating the extra log data.

Is it likely that a user will want to keep syscall auditing on for
some applications, while having it disabled for AppArmor's use?

> 
> 		The values by default for all of the above are 0.
> 
> 	matching - Returns the features of the installed matching submodule
> 	profiles - Returns the profiles currently loaded and for each whether
> 		   it is in complain (learning) or enforce mode.
> 	.load
> 	.remove
> 	.replace - Used by userspace tools to load, remove and replace new 
> 		   profiles.
