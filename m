Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268137AbUH0B7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268137AbUH0B7R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 21:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269886AbUH0Byt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 21:54:49 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:59272 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S269794AbUH0Bul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 21:50:41 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alex Riesen <fork0@users.sourceforge.net>
Date: Fri, 27 Aug 2004 11:50:28 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16686.37732.565804.886087@cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc1: kernel BUG at mm/slab.c:1828 (sunrpc)
In-Reply-To: message from Alex Riesen on Thursday August 26
References: <20040826190019.GA3359@steel.home>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 26, fork0@users.sourceforge.net wrote:
> I get this running X and some gnome applications for a while (~10sec).
> After the bug, keyboard stays locked, mouse (usb) works, and I can
> finish the session. It brings me to a blank console:
> 
>     kernel:  <6>SysRq : Emergency Sync
>     kernel: Emergency Sync complete
>     gconfd (raa-3333): Received signal 1, shutting down cleanly
>     gconfd (raa-3333): Exiting
>     init: open(/dev/console): Input/output error
> 
> Ctrl-Alt-Del worked, though:
> 
>     init: Switching to runlevel: 6
> 
> It is reproducable with latest bk as of Aug 26 20:00 CET.
> The system is ht/smt P4 with preempt, Gentoo (no hotplug and udev).
> 
> There is a suspect:
>     struct auth_domain *auth_unix_lookup(struct in_addr addr)
> 	    ...
> 	    key.m_class = "nfsd";
> 	    key.m_addr = addr;
> 
> And ip_map_put contains a "kfree(im->m_class)".
> I wasn't able to reproduce the bug after removing the kfree.
> The strdups to m_class will leak now, I suppose.

Yep, thanks.
Andrew has received a patch so it should be fixed in the next
release.  For now, removing the "kfree" is safe enough.

NeilBrown
