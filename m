Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbUDJKcO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 06:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUDJKcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 06:32:14 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:45260 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262005AbUDJKcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 06:32:11 -0400
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [PATCH, local root on 2.4, 2.6?] compute_creds race
References: <4076F02E.1000809@myrealbox.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sat, 10 Apr 2004 12:32:04 +0200
In-Reply-To: <4076F02E.1000809@myrealbox.com> (Andy Lutomirski's message of
 "Fri, 09 Apr 2004 11:49:18 -0700")
Message-ID: <87brm015uj.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@myrealbox.com> writes:

> The setuid program is now running with uid=euid=500 but full permitted
> capabilities.  There are two (or three) ways to effectively get local
> root now:
>
> 1. IIRC, linux 2.4 doesn't check capabilities in ptrace, so A could
> just ptrace B again.

In linux 2.4.25 there is no LSM and thus no vulnerability.

linux-2.4.25/fs/exec.c:
		lock_kernel();
		if (must_not_trace_exec(current)
		    || atomic_read(&current->fs->count) > 1
		    || atomic_read(&current->files->count) > 1
		    || atomic_read(&current->sig->count) > 1) {
			if(!capable(CAP_SETUID)) {
				bprm->e_uid = current->uid;
				bprm->e_gid = current->gid;
			}
			if(!capable(CAP_SETPCAP)) {
				new_permitted = cap_intersect(new_permitted,
							current->cap_permitted);
			}
		}
		do_unlock = 1;

Regards, Olaf.
