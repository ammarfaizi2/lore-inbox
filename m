Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263582AbTEDLGv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 07:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTEDLGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 07:06:50 -0400
Received: from corky.net ([212.150.53.130]:64197 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S263582AbTEDLGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 07:06:50 -0400
Date: Sun, 4 May 2003 14:19:09 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
Message-ID: <Pine.LNX.4.44.0305041337590.31429-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 May 2003, Ingo Molnar wrote:

> Furthermore, the kernel also remaps all PROT_EXEC mappings to the
> so-called ASCII-armor area, which on x86 is the addresses 0-16MB.

I don't see how the case of mprotect(HIGH_ADDRESS, LEN, PROT_EXEC) be
handled.  Unlike mremap, mprotect doesn't offer a way to inform the user
about a change of address.

If I understand correctly, such case will cause a call to
arch_add_exec_range(current->mm, vma) without any remapping, thus breaking
the protection.

One case where this would happen is some of the ancient loaders.  IIRC,
libc4's loader did just that.  (right, nobody uses it anymore :)

btw, I guess that now, at least when X_workaround==1, exploits will focus
on getting iopl(2) called before they get the actual shellcode called.
In some cases it may be easy to cause a call to iopl (param doesn't matter
as long as its not zero).  Once this is achieved, protection is disabled.

For that reason, maybe X_workaround should be controlled per-executable
by another ELF flag and not as a system-wide property.

	Yoav Weiss

--
Please CC me on any reply.

