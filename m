Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVC1Jnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVC1Jnk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 04:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVC1Jnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 04:43:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24997 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261408AbVC1Jni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 04:43:38 -0500
To: Andrew Morton <akpm@osdl.org>
CC: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] /x86_64-machine_shutdown.patch breaks sysrq-b
References: <20050324212027.602fd885.akpm@osdl.org>
	<m1ll88nqo7.fsf@ebiederm.dsl.xmission.com>
	<20050328003621.658ab127.akpm@osdl.org>
	<m18y48nnbi.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Mar 2005 02:40:26 -0700
In-Reply-To: <m18y48nnbi.fsf@ebiederm.dsl.xmission.com>
Message-ID: <m1zmwom7lh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looking a little more closely at the users there
is a clear demand in the kernel for some kind of forced
reboot.  Coming from software watchdog timers and the like,
and it makes sense for sysrq-b to call the same thing.

However I'm not at all certain that we want the software is
hosed reboot dammit, to be the same as the graceful reboot
path.

There are a lot of things we can do on the graceful reboot
path like switch to the bootstrap cpu, attempt to make BIOS
calls to perform the reboot etc, that I'm not at all certain
we want to perform on the under more dire circumstances.

If it weren't simply overkill I'd say in the freaked out kernel
reboot case we want to kexec to a sane kernel and then reboot from
there.

Eric
