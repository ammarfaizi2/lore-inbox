Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWJMOPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWJMOPS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 10:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWJMOPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 10:15:18 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:14826 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750851AbWJMOPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 10:15:16 -0400
Date: Fri, 13 Oct 2006 10:14:46 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Steven Truong <midair77@gmail.com>
Cc: linux-kernel@vger.kernel.org, crash-utility@redhat.com,
       Dave Anderson <anderson@redhat.com>
Subject: Re: kdump/kexec/crash on vmcore file
Message-ID: <20061013141446.GA27375@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <28bb77d30610121450n6cfd9c6ejd6b0370d2400a378@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28bb77d30610121450n6cfd9c6ejd6b0370d2400a378@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 02:50:33PM -0700, Steven Truong wrote:
> Hi, all.  This is my first attempt to troubleshoot a kernel panic so I
> am quite newbie in this area. I have been able to obtain a kdump when
> my box had kernel panic.
> 
> I set up Kdump and Kexec and then the captured/crash kernel to boot
> into Level 1 and then copy /proc/vmcore file to the disk for later
> analysis.  However, after the server booted back to Level 3 and I
> utilized the crash command to analyzed the vmcore file.  I got error
> message:
> 
> ./crash /boot/vmlinux ../vmcore.test
> 
> 
> crash: read error: kernel virtual address: ffffffff8123d1e0  type:
> "kernel_config_data"
> WARNING: cannot read kernel_config_data
> crash: read error: kernel virtual address: ffffffff813b5180  type: "xtime"
> 

Hi Steven,

which vmlinux are you using for analysis? First kernel's vmlinux or
second kernel's vmlinux. You should be using first kernel's vmlinux.

crash is trying to read some symbols from the core file and crash thinks
that virtual address for kernel_config_data is ffffffff8123d1e0. I think
this is too high a address. I guess this will be the address if you
compile your kernel for physical address 16MB. So my first guess is that
you are using second kernel's vmlinux for analysis.

Which kernel version and kexec-tools version are you using?

I am also copying the mail to crash-utility mailing list where folks
keep a watch on crash related issues.

Thanks
Vivek
