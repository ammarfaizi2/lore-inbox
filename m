Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbWJDASX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbWJDASX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbWJDASX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:18:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:11276 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030426AbWJDASX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:18:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RcRLguS8NvvWgb2TCh2KPx4/L4ehQGpr+Z47d0uBs1Y5x8yt2oYNjTMJf30ucmAVSiwrFH19PKKHRaKmZEK9oAAtlOAXla63bLkfUlkpzsPmkOPg9ZBpIwuM8yH0oFjsxD7zGgt60uTlilhUNGuLHTduB+Co1h+/Fr3iENhJNzI=
Message-ID: <28bb77d30610031718r51dfb003ge22c082d3b4cacb@mail.gmail.com>
Date: Tue, 3 Oct 2006 17:18:21 -0700
From: "Steven Truong" <midair77@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kexec / kdump kernel panic
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have a dual Xeon 3.2 GHz with Cent OS 4.3 and this box is in a
cluster. It keeps bailling out with kernel panic type of error and I
can not determine for sure what type of kernel or hardware problem. I
have tried to play with kexec and kdump with the hope to set up and
capture the kernel dump to debug.

I have followed the instruction in linux-2.16.18
Documentation/kdump/kdump.txt closely but still have not been able to
get it to work for loading the caputured kernel for panic kernel
situation.

I have the system kernel with Linux 2.16.18 booted up and set with
crashkernel=128M@16M. I compiled this system kernel with KEXEC, SYSFS,
DEBUG_INFO and CRASH_DUMP enabled. When this box is up with this
system kernel and can see that the total memory is 128 MB less than
the physical memory.

For the crash/captured kernel, I had SMP disable and KEXEC,
CRASH_DUMP, and VMCORE enabled.  PHYSICAL_START=0x1000000.

I first tested with the following command and saw that the
crash/captured kernel booted up the box without going through the BIOS
initialization.

/usr/sbin/kexec -l /boot/vmlinux
--initrd=/boot/initrd-2.6.18-kdump.img --args-linux
--append="root=/dev/sda3  init  1"

However, when I tried to load the crash/captured kernel for kernel
panic situation, I just got failed to load kernel /boot/vmlinux error
message. I used the following command to load :

/usr/sbin/kexec -p /boot/vmlinux
--initrd=/boot/initrd-2.6.18-kdump.img --args-linux
--append="root=/dev/sda3  irqpoll init 1"

I did make sure that vmlinux is not a bzImage file by using this command

readelf -h /boot/vmlinux

and I was able to see the output of this command. If I used this one
with bzImage file, I won't see anything. So I am pretty sure the
kernel file vmlinux is ok.

I did strace the second command but did not gain any special knowledge
here and no error message could be found in any log files.

I used kexec-tools-1.101 and kexec-tools-1.101-kdump10.patch.
