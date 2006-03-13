Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWCMURb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWCMURb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWCMURb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:17:31 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:52147 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932425AbWCMURa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:17:30 -0500
Message-ID: <4415D362.4070703@vilain.net>
Date: Tue, 14 Mar 2006 09:17:38 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface proposal
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com>
In-Reply-To: <200603131758.k2DHwQM7005618@zach-dev.vmware.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:

>In OLS 2005, we described the work that we have been doing in VMware
>with respect a common interface for paravirtualization of Linux. We
>shared the general vision in Rik's virtualization BoF.
>[...]
>Unlike the full-virtualization techniques used in the traditional VMware
>products, paravirtualization is a technique where the operating system
>is modified to enlighten the hypervisor with timely knowledge about the
>operating system's activities. Since the hypervisor now depends on the
>kernel to tell it about common idioms etc, it does not need to write
>protect OS objects such as page and descriptor tables as a solution
>based on full-virtualization needs. This has two important effects (a)
>it shortens the critical path, since faulting is expensive on modern
>processors (b) by eliminating complex heuristics the hypervisor is
>simplified. While the former delivers performance, the latter is quite
>important too. 
>  
>

An interesting vision, especially if it merges the current VMWare / Xen
techno-social rift.

I think there will still be a place for the "complete" (eg, QEMU, or of
course your own product) and the "ultimately lightweight" (eg,
vserver/openvz/jails/containers) approaches to virtualisation, though.

While the same kernel may be able to run in these different situations,
having a "real" hardware emulator like QEMU/VMWare will allow you to
test all of those alternate code paths.  As time goes on this will no
doubt seem a more and more superfluous requirement, especially if the
actual code in those places is minimal as you suggest.

Looking the other way, there is no way that a system like this will ever
approach the performance of fork(), as vserver and related technology
does.  No doubt for certain common applications of virtualisation, such
as providing "complete" virtual servers, this will be seen as less and
less important as time goes on.  However, for other applications - such
as jailing services, or systems that make use of advantages of single
kernel virtualisation (such as shared VFS/network, visibility into other
systems' processes, etc) - the extra kernel that a virtualisation
context implies is simply unwanted.  No doubt still other users will
simply prefer the simplicity of system call level virtualisation, such
as only having one set of routing tables/iptables rules/VGs to manage, etc.

There are currently two debates on virtualisation happening here, on and
off.  We have Xen/VMI, and vserver/openvz/jails/containers.  Let's just
try not to get them confused :-).  From the perspective of the vserver
project, I consider your work orthogonal and complementary and wish you
well in the success of your gracious offering to the Linux community.

Sam.
