Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbTLOWvV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 17:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTLOWuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 17:50:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:17126 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264155AbTLOWsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 17:48:42 -0500
Date: Mon, 15 Dec 2003 14:48:09 -0800
From: Chris Wright <chrisw@osdl.org>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: request: capabilities that allow users to drop privileges further
Message-ID: <20031215144809.A14552@osdlab.pdx.osdl.net>
References: <20031215213912.GA29281@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031215213912.GA29281@codeblau.de>; from felix-kernel@fefe.de on Mon, Dec 15, 2003 at 10:39:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Felix von Leitner (felix-kernel@fefe.de) wrote:
> I would like to be able to drop capabilities that every normal user has,
> so that network servers can limit the impact of possible future security
> problems further.  For example, I want my non-cgi web server to be able
> to drop the capabilities to

Using existing capabilities system you can limit many of these.  Just
dropping privs from uid = 0 to anything else is a good start.

>   * fork

rlimit

>   * execve

mount fs noexec

>   * ptrace

drop CAP_SYS_PTRACE

>   * load kernel modules

drop CAP_SYS_MODULE

>   * mknod

drop CAP_MKNOD

>   * write to the file system

mount fs r/o.

In general, most of what you ask for is already there.  Otherwise use
some MAC policy that gives you the control you want (check out SELinux
for example).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
