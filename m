Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVDRMx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVDRMx3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 08:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVDRMuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 08:50:22 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:45977 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262069AbVDRMtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 08:49:10 -0400
Subject: Re: question : is the init process of kernel running in kernel
	space or user space?
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomko <tomko@haha.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42630F26.3060503@haha.com>
References: <42630F26.3060503@haha.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 18 Apr 2005 08:49:05 -0400
Message-Id: <1113828545.4294.166.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 09:36 +0800, Tomko wrote:
> Hi all,
> 
> In the linux system , kernel is often starting up like this :
> 
> bootloader -> start_32() -> start_kernel() -> init()
> 
> i would like to ask what is the piority level in this starting procedure 
> ? 0 or 3 ? that means, this start up process are running in kernel space 
> or user space ?  or the level is keep changing ?
> If it is in kernel space from the very beginning , at which point the 
> system is switched into user space ? is it at the time when kernel open 
> the shell ?
> 

All the above functions you mentioned are running in kernel space. The
point that init switches to user space is at the bottom of the init
function, when it calls run_init_process, which calls execve. Which is
the same execve that a user program calls, and at that point the execve
would switch the process to a user space program, usually /sbin/init.

Also, the term priority is somewhat ambiguous. The priority level of a
task in linux is defined as the strength it has in respect to other
tasks when it comes down to scheduling.  I understand you are talking
about the x86 level that a process runs in (kernel or user) but not all
architectures use that, and linux is a multiple architecture OS.

-- Steve


