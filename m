Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWJDVjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWJDVjK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWJDVjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:39:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:21006 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751158AbWJDVjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:39:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hp2bvpKJLM493ViLmyDtfvbVK8M85/QW0+P5m6TwPPqmqJQKk+FYgGu7S4CG7/yeS87NMyxlBjS0fpwc+fkJuBhjlmBvOuRjuV4ZUHBPCPxb+RDys+TLXf6m3KuOZZs8IUip2TOljwIT4lWRCRAu/rmGfYbkmAgLz0YdDyileFc=
Message-ID: <28bb77d30610041438r3c3dfd8ejc7344761704747fd@mail.gmail.com>
Date: Wed, 4 Oct 2006 14:38:53 -0700
From: "Steven Truong" <midair77@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: kexec / kdump kernel panic
In-Reply-To: <200610040346.k943kvwM006684@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <28bb77d30610031718r51dfb003ge22c082d3b4cacb@mail.gmail.com>
	 <200610040346.k943kvwM006684@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Valdis.  No, I actually used 2 different kernels for this:  one
for system kernel and the other for captured/crash kernel.

System kernel .config file with these options

CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_SYSFS=y
CONFIG_DEBUG_INFO=y

make; make modules_install; make install

System kernel Grub entry

title CentOS (2.6.18)
      root (hd0,0)
      kernel /vmlinuz-2.6.18 ro root=/dev/sda3 crashkernel=128M@16M rhgb quiet
      initrd /initrd-2.6.18.img


Crash/captured kernel .config file with these options
CONFIG_LOCALVERSION="-kdump"
# CONFIG_SMP is not set
CONFIG_KEXEC=y    <-------------------------------------------------------------
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_PROC_VMCORE=y

the /boot/vmlinux is found in the linux-2.6.18kdump directory after I
make and make install_modules for the crash kernel.

Am I missing something? Or did I do something wrong?  Is my vmlinux ok
or how I go about to obtain an uncompressed ELF image of the crash
kernel?

Thank you for all the helps.
Steven.

On 10/3/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Tue, 03 Oct 2006 17:18:21 PDT, Steven Truong said:
>
> > /usr/sbin/kexec -p /boot/vmlinux
> > --initrd=/boot/initrd-2.6.18-kdump.img --args-linux
> > --append="root=/dev/sda3  irqpoll init 1"
>
> If the /boot/vmlinux is the one you usually use to boot, that won't work.
>
> Your usual vmlinux is almost certainly linked to load at the 1M line,
> and you need a kernel linked to load at the 16M line (as set in crashkernel=).
>
> See the CONFIG_PHYSICAL_START config option, and there's other details
> in Documentation/kdump/kdump.txt - it looks like you have most of it right,
> except you need to build *TWO* specially configured kernels (your production
> one with KEXEC support and a few other things, and then the dump kernel
> with a different PHYSICAL_START and a few settings).
>
>
>
