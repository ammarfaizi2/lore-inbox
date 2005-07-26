Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVG1A5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVG1A5o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 20:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVG1A5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 20:57:44 -0400
Received: from [203.171.93.254] ([203.171.93.254]:65206 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261216AbVG1A5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 20:57:43 -0400
Subject: Re: [PATCH 1/23] Add missing device_suspsend(PMSG_FREEZE) calls.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	 <m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1122400462.4382.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 27 Jul 2005 03:54:23 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Could you please send PMSG_* related patches to linux-pm at
lists.osdl.org as well?

Thanks!

Nigel

On Wed, 2005-07-27 at 03:21, Eric W. Biederman wrote:
> In the recent addition of device_suspend calls into
> sys_reboot two code paths were missed.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
> 
>  kernel/sys.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> 5f0fb00783b94248b5a76c161f1c30a033fce4d3
> diff --git a/kernel/sys.c b/kernel/sys.c
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -391,6 +391,7 @@ asmlinkage long sys_reboot(int magic1, i
>  	case LINUX_REBOOT_CMD_RESTART:
>  		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
>  		system_state = SYSTEM_RESTART;
> +		device_suspend(PMSG_FREEZE);
>  		device_shutdown();
>  		printk(KERN_EMERG "Restarting system.\n");
>  		machine_restart(NULL);
> @@ -452,6 +453,7 @@ asmlinkage long sys_reboot(int magic1, i
>  		}
>  		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
>  		system_state = SYSTEM_RESTART;
> +		device_suspend(PMSG_FREEZE);
>  		device_shutdown();
>  		printk(KERN_EMERG "Starting new kernel\n");
>  		machine_shutdown();
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

