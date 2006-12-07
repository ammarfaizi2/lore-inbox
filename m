Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032357AbWLGQGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032357AbWLGQGv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 11:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032359AbWLGQGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 11:06:50 -0500
Received: from amsfep19-int.chello.nl ([62.179.120.14]:62002 "EHLO
	amsfep19-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032357AbWLGQGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 11:06:49 -0500
Subject: Re: Simple OOM kill protection interface
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Menny Hamburger <menny@exanet.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6FDE6B975803043804A49F12F49028E0F5588@hawk.exanet-il.co.il>
References: <A6FDE6B975803043804A49F12F49028E0F5588@hawk.exanet-il.co.il>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 16:59:22 +0100
Message-Id: <1165507162.32332.10.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-07 at 17:50 +0200, Menny Hamburger wrote:
> Hi,
> 
> Following is a rather simple module implementation that adds an interface for protecting against the oom_killer by setting the oomkilladj in the task struct.


> There are two interfaces:
> 1) /proc interface (/proc/oom_kill_protection) that can be used inside scripts
> 2) A device that registers an ioctl, which can be issued via a calling c program.
> 
> To create the device after the module is loaded do the following from a script:
> major_name=$(dmesg | grep oom_protect |  grep dynamic | tail -n 1 | awk '{print $5}' | xargs)
> if [ -n "$major_name" ]; then
>       mknod /dev/oom_protect c $major_name 1
> fi
> if [ ! -r /dev/oom_protect ]; then
>      logger -p error "Unable to create /dev/oom_protect"
> else
>      logger -p notice "Created device /dev/oom_protect"
> fi
> 
> Usage via a script:
> echo "setprotection $$ 1 > /proc/oom_kill_protection/ctl"
> 
> Usage via a c prog:
> #include <sys/ioctl.h>
> 
> .........
> 
> #define OOMSETPROTECTCMD   _IOWR('O', 1, int)
> 
> int oom_protection = 1, oom_protected = 1, fd;
> 
> if ((fd = open("/dev/oom_protect", 0)) >= 0) {
>     if (ioctl(fd, OOMSETPROTECTCMD, &oom_protection) == 0)
>         oom_protected = 1;
> 
>         close(fd);
> }
> .....

Whatever for?
Why is writing to /proc/{<pid>,self}/oom_adj not good enough?

