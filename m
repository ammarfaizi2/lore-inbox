Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbULJO2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbULJO2H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 09:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbULJO2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 09:28:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43672 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261209AbULJO2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 09:28:03 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200412100408.33482.ioe@axxeo.de> 
References: <200412100408.33482.ioe@axxeo.de>  <3e47b0ba-49f4-11d9-9df1-0002b3163499@redhat.com> <200412091508.iB9F8wja027564@warthog.cambridge.redhat.com> 
To: linux-kernel@vger.kernel.org
Cc: uclinux-dev@uclinux.org
Subject: Re: [PATCH 4/5] NOMMU: Make POSIX shmem work on ramfs-backed files 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Fri, 10 Dec 2004 14:28:00 +0000
Message-ID: <27481.1102688880@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ioe@axxeo.de> wrote:

> What about this pattern instead:
> 
> file-mmu-y := file-mmu.o
> file-mmu-n := file-nommu.o
> file-mmu- := file-nommu.o
> ramfs-objs += file-mmu-$(CONFIG_MMU)
>
> Requires more work while writing it, but removes the ifeq, 
> which should be avoided in makefiles as hell

Your suggestion adds duplicate information. This solution is worse than the
thing you're trying to fix.

Do we really need both the file-mmu-n and file-mmu- variants?

Actually, this would probably do instead:

	file-mmu-y := file-nommu.o
	file-mmu-$(CONFIG_MMU) := file-mmu.o
	ramfs-objs := inode.o file-mmu-y

Will this work? Or should it be $(file-mmu-y) on the last line?

David
