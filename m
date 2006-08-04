Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161474AbWHDXeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161474AbWHDXeJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 19:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161580AbWHDXeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 19:34:09 -0400
Received: from smtpout.mac.com ([17.250.248.181]:43509 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1161474AbWHDXeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 19:34:08 -0400
In-Reply-To: <44D3CFB9.9020208@gmail.com>
References: <44D3BF62.10202@gmail.com> <1154729992.3573.35.camel@brianb> <44D3CFB9.9020208@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F493D385-0915-442A-853A-00B3ED75B8B2@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: ACLs
Date: Fri, 4 Aug 2006 19:34:02 -0400
To: RazorBlu <razorblu@gmail.com>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 04, 2006, at 18:52:41, RazorBlu wrote:
> Because instead of having an all-powerful account (which we so  
> lovingly know as root), you can separate specific roles to  
> different accounts. To use Windows' ACLs as an example:
>
> - Adjust memory quotas for a process
> - Allow/deny access to this computer from the network
> - Backup files and directories
> - Bypass traverse checking
> - Change system time
> - Increase scheduling priority
> - Load and unload device drivers
> - Manage auditing and security logs
> - Restore files and directories
> - Shutdown the system
> - Take ownership of files or other objects

This is _exactly_ what SELinux does for you.  You can break down  
permissions on very nearly a per-syscall basis (not quite, for  
efficiency reasons, but pretty damn close).

> As you can see, those are finely-grained controls. Why would these  
> be useful on Linux? Because you can have a root account which can  
> bind Apache to a port <1024, and even if it is compromised it  
> cannot "shutdown the system," or "deny access to this computer from  
> the network," thus the attacker will be able to cause minimal  
> damage. Yes, the same can be done on Linux using SELinux, AppArmor,  
> or some other ACL system, but again - those aren't part of the  
> kernel. They are extra apps, and adding layers is not always the  
> best solution when it comes to security.

You're quite wrong about SELinux; it _is_ part of the kernel.   
Admittedly it requires a policy to be built and loaded from  
userspace, but your "ACLs" would require some ACL utilities to apply  
those from userspace.  In any case SELinux is an extremely powerful  
model; you can define your arbitrary RBAC+TE state machine and  
constraints, then the kernel applies it to your system; as simple (or  
horribly complicated, as the case may be) as that.

> Um.. Forgive me for a second, but are you suggesting that a Linux  
> system running a service(s) under full root privileges (such as  
> Apache) is just as secure as a Linux system running the same  
> process but with compartmentalisation to make sure that each  
> service has access to just the files and directories it needs,  
> achieved (currently) via AppArmor, SELinux, or a similar ACL system?

Here's a better security model:  SELinux lets you give root access to  
everybody and still have a 100% secure system (although it's not  
really recommended).  Google around for the public SSH-accessible  
SELinux testbeds with root's password set to "password" or "1234" or  
whatever and feel free to log in and have a look.  Besides, we do  
have POSIX ACLs on files; if that's what you're looking for, but  
that's not extensible enough to cover processes too.

Cheers,
Kyle Moffett



