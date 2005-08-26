Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbVHZMrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbVHZMrk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 08:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbVHZMrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 08:47:40 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:17244 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750980AbVHZMrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 08:47:40 -0400
Date: Fri, 26 Aug 2005 14:47:38 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Cc: linux-kernel@vger.kernel.org, dhommel@gmail.com
Subject: Re: syscall: sys_promote
Message-ID: <20050826124738.GD28640@harddisk-recovery.com>
References: <20050826092537.GA3416@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050826092537.GA3416@localhost.localdomain>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 05:25:37PM +0800, Coywolf Qi Hunt wrote:
> I just wrote a tool with kernel patch, which is to set the uid's of a running
> process without FORK.
> 
> The tool is at http://users.freeforge.net/~coywolf/pub/promote/
> Usage: promote <pid> [uid]
> 
> I once need such a tool to work together with my admin in order to tune my web
> configuration.  I think it's quite convenient sometimes. 
> 
> The situations I can image are:
> 
> 1) root processes can be set to normal priorities, to serve web
> service for eg.

Most (if not all) web servers can be told to drop all privileges and
run as a normal user. If not, you can use selinux to create a policy
for such processes (IIRC that's what Fedora does).

> 2) admins promote trusted users, so they can do some system work without knowing
>    the password

Use sudo for that, it allows even much finer grained control.

> 3) admins can `promote' a suspect process instead of killing it.

Why would that change anything? You only change a process's UID,
nothing else. You don't change things like resource limits, so a
process started as root with unlimited limits is still allowed to use
those limits. AFAIK setrlimit() can't be used to change resource limits
of other processes.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
