Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbTEDNja (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 09:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTEDNja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 09:39:30 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20159 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263596AbTEDNj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 09:39:29 -0400
Date: Sun, 4 May 2003 09:51:51 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Yoav Weiss <ml-lkml@unpatched.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
In-Reply-To: <Pine.LNX.4.44.0305041337590.31429-100000@marcellos.corky.net>
Message-ID: <Pine.LNX.4.44.0305040948390.31649-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 4 May 2003, Yoav Weiss wrote:

> I don't see how the case of mprotect(HIGH_ADDRESS, LEN, PROT_EXEC) be
> handled.  Unlike mremap, mprotect doesn't offer a way to inform the user
> about a change of address.
> 
> If I understand correctly, such case will cause a call to
> arch_add_exec_range(current->mm, vma) without any remapping, thus
> breaking the protection.

yes - the patch does not put any limit on which areas can be PROT_EXEC -
if the executable area is 'too wide' then there's no protection. The patch
tries to relocate areas which are freely relocatable, to make sure that in
the usual case the exec-limit will be quite low.

> One case where this would happen is some of the ancient loaders.  IIRC,
> libc4's loader did just that.  (right, nobody uses it anymore :)

yeah, we should not be worried about old loaders.

> For that reason, maybe X_workaround should be controlled per-executable
> by another ELF flag and not as a system-wide property.

i'll remove X_workaround from the next patch altogether - X can be fixed
by enabling an executable stack for the binary.

	Ingo

