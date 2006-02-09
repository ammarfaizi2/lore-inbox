Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422737AbWBIBFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422737AbWBIBFf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 20:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422738AbWBIBFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 20:05:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59810 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422737AbWBIBFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 20:05:34 -0500
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] fix handling of st_nlink on procfs root
References: <E1F6vyO-00009r-3a@ZenIV.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Feb 2006 18:04:36 -0700
In-Reply-To: <E1F6vyO-00009r-3a@ZenIV.linux.org.uk> (Al Viro's message of
 "Wed, 08 Feb 2006 20:31:32 +0000")
Message-ID: <m17j855om3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> writes:

> Date: 1139427460 -0500
>
> 1) it should use nr_processes(), not nr_threads; otherwise we are getting
> very confused find(1) and friends, among other things.
> 2) better do that at stat() time than at every damn lookup in procfs root.
>
> Patch had been sitting in FC4 kernels for many months now...

Ack.

There are some other similar problems still in /proc.

In my pid namespace work I have some managed to clean most of
this up, and finally split proc into two filesystems.

The only was I was able to get the union to work was
to let lookup return files in an internal mount.

The only problem was that /proc/irq/..  != /proc/

I will finish all of this up shortly but do you know a good
way to do a union mount when we mount proc?

Eric
