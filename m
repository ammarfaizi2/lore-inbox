Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424043AbWKIELi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424043AbWKIELi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 23:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424044AbWKIELi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 23:11:38 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:53467 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1424043AbWKIELh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 23:11:37 -0500
Date: Wed, 8 Nov 2006 20:14:00 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Chris Wright <chrisw@sous-sol.org>, Zack Weinberg <zackw@panix.com>,
       linux-kernel@vger.kernel.org, sds@tycho.nsa.gov, jmorris@namei.org
Subject: Re: RFC PATCH: apply security_syslog() only to the syslog() syscall, not to /proc/kmsg
Message-ID: <20061109041400.GB6602@sequoia.sous-sol.org>
References: <eb97335b0611072016y51e1625hcd6504fddfe9aa6c@mail.gmail.com> <20061108102037.GA6602@sequoia.sous-sol.org> <20061108154229.eb6d4626.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108154229.eb6d4626.vsu@altlinux.ru>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Sergey Vlasov (vsu@altlinux.ru) wrote:
> Then what would you think about another solution:
> 
>  1) When sys_syslog() is called with commands 2 (read) or 9 (get unread
>     count), additionally call security_syslog(1) to check that the
>     process has permissions to open the kernel log.  This change by
>     itself will not make any difference, because all existing
>     implementations of the security_ops->syslog hook treat the operation
>     codes 1, 2 and 9 the same way.
> 
>  2) Change cap_syslog() and dummy_syslog() to permit commands 2 and 9
>     for unprivileged users, in addition to 3 and 10 which are currently
>     permitted.  This will not really permit access through sys_syslog()
>     due to the added security_syslog(1) check, but if a process somehow
>     got access to an open file descriptor for /proc/kmsg, it would be
>     able to read from it.  Also, because selinux_syslog() is not
>     changed, under SELinux the process will still need to have
>     additional privileges even if it has /proc/kmsg open.

It's a bit clumsy in the extra caveats for sys_syslog and cap_syslog,
but does achieve what you're after.  We lose default checking on the
actual read access, but perhaps this is a fair tradeoff.  Stephen,
James do you have any issues with this for SELinux?

thanks,
-chris
