Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVBBOrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVBBOrS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 09:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVBBOrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 09:47:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1517 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262424AbVBBOrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 09:47:07 -0500
To: Itsuro Oda <oda@valinux.co.jp>
Cc: Koichi Suzuki <koichi@intellilink.co.jp>, Vivek Goyal <vgoyal@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
References: <41FF381B.4080904@intellilink.co.jp>
	<m1fz0gbqe5.fsf@ebiederm.dsl.xmission.com>
	<20050202161108.18D7.ODA@valinux.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 Feb 2005 07:45:11 -0700
In-Reply-To: <20050202161108.18D7.ODA@valinux.co.jp>
Message-ID: <m1fz0f9g20.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And the feedback begins :)

Itsuro Oda <oda@valinux.co.jp> writes:

> Hi,
> 
> I don't like calling crash_kexec() directly in (ex.) panic().
> It should be call_dump_hook() (or something like this).
> 
> I think the necessary modifications of the kernel is only:
> - insert the hooks that calls a dump function when crash occur
crash_kexec()
> - binding interface that binds a dump function to the hook
>   (like register_dump_hook())
sys_kexec_load(...);
> - supply the information of valid physical address regions
/proc/iomem or possibly /proc/cpumem.  At least until someone
actually implements hot plug memory support.

> (- maybe some existent functions and variables need to be exported ?)
> 
> I think this makes any sort of dump functions can be implemented
> as a kernel module. I don't think it is best way that the "kexec based 
> crashdump" is built in the kernel.

For people developing code outside of the kernel I can see where
this is a problem.  Given the insane auditing requirements necessary
to get a reliable code path I don't see how not putting the implementation
in the kernel is sane.  Anything that needs to be touched at that point
is core kernel functionality GPL_ONLY if it is exported at all.
Touching anything from a module at that point is not sane.

Basically the code path setup with crash_kexec is little more
than a jump instruction.  And it should be audited and reduced
as much as possible.  I don't see how you get simpler or what
piece of functionality could possibly improve by having multiple
implementations in kernel modules.

Eric


