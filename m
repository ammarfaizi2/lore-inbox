Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTDGT43 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 15:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbTDGT43 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 15:56:29 -0400
Received: from [12.47.58.221] ([12.47.58.221]:56875 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263620AbTDGT42 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 15:56:28 -0400
Date: Mon, 7 Apr 2003 12:06:45 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: zwane@linuxpower.ca, felipe_alfaro@linuxmail.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-bk12: acpi_power_off: sleeping function called from il
 legal context
Message-Id: <20030407120645.19842977.akpm@digeo.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A24D@orsmsx401.jf.intel.com>
References: <F760B14C9561B941B89469F59BA3A84725A24D@orsmsx401.jf.intel.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2003 20:07:57.0116 (UTC) FILETIME=[618D7FC0:01C2FD41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" <andrew.grover@intel.com> wrote:
>
> However, we also have to execute control methods early in the boot
> sequence. down() would never block but it thinks it might, so we want to
> call down_trylock instead. in_atomic() seemed to be a good (?) way to
> tell whether we need to avoid down() or not.
> 
> Thoughts on better ways to do this, perhaps? I guess I should at least
> add a comment above that line.
> 

So really it's just the debug code which is being misleading?  hm.

Couldn't you set some magical global ACPI flag:

acpi_super_early_init()
{
	acpi_in_super_early_init = 1;
	do_stuff();
	acpi_in_super_early_init = 0;
}

And test that flag in acpi_os_wait_semaphore()?

It's a bit grubby, but so is the problem.

We do have this `system_running' flags in init/main.c which perhaps should be
fleshed out into a more fine-grained way of communicating the kernel's
start/run/stop state.

