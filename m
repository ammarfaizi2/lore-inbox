Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWGEQO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWGEQO6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 12:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWGEQO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 12:14:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19931 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964817AbWGEQO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 12:14:57 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] kdump: add a missing notifier before crashing
References: <20060704213301.4701055e.akiyama.nobuyuk@jp.fujitsu.com>
Date: Wed, 05 Jul 2006 10:14:20 -0600
In-Reply-To: <20060704213301.4701055e.akiyama.nobuyuk@jp.fujitsu.com>
	(Nobuyuki Akiyama's message of "Tue, 4 Jul 2006 21:33:01 +0900")
Message-ID: <m1fyhg3u77.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com> writes:

> Hi all,
>
> The attached patch adds a missing notifier before crashing.
NAK

It's not missing.  It should not exist.

> This patch is remade for 2.6.17-git22.
> I tested this patch on a i386-box.
>
> Please refer to the previous discussions for details:
> http://lists.osdl.org/pipermail/fastboot/2006-May/003018.html
> http://lists.osdl.org/pipermail/fastboot/2006-June/003113.html
>
> Description:
> We don't have a simple and light weight way to know the
> kernel dies. The panic notifier does not be called if kdump
> is activated because crash_kexec() does not return,
> and there is no mechanism to notify of a crash before
> crashing by SysRq-c.
> Although notify_die() exists, but the function depends on
> architecture. If notify_die() is added in panic and SysRq
> respectively like existing implementation, the code will be
> very ugly. I think that adding a generic hook in crash_kexec()
> is better to simplify the code.
>
> For example, the clustering system can take advantage of this
> notifier. On a mission critical system, failover needs to start
> within a few milli-second. The notifier could be called on
> 2nd kernel, but it is no use because it takes the time of
> second order to boot up.
>
> On an actual system, the notifier turns off HBA's power to
> stop accessing shared disk, and then notifies standby node
> that the current node died. 

And again NAK.
Just call the stupid HBA routine directly if this is necessary.
The call can compile to nothing when you HBA is not compiled in.

This is completely unacceptable until we see the code that you are
calling.

If we do export your notifier list it needs to be at least a
GPL only export as this is very much in the guts of the kernel.

As written this seriously destabilizes the kexec on panic support.

I will happy to have a solution to this problem but not this solution.
Especially not without an in-kernel user.

Nacked-by: Eric Biederman <ebiederm@xmission.com>

Eric
