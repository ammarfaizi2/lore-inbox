Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbTANVEn>; Tue, 14 Jan 2003 16:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbTANVEn>; Tue, 14 Jan 2003 16:04:43 -0500
Received: from fmr06.intel.com ([134.134.136.7]:26577 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S265255AbTANVEk>; Tue, 14 Jan 2003 16:04:40 -0500
Date: Tue, 14 Jan 2003 11:38:36 -0800
Message-Id: <200301141938.h0EJcaO8018734@penguin.co.intel.com>
From: Rusty Lynch <rusty@penguin.co.intel.com>
To: linux-kernel@vger.kernel.org
Subject: Unable to boot off kernel built on different machine
Reply-To: rusty@linux.co.intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having the strange problem (that I suspect is embarrassingly simple)
where I can only boot a kernel built on the same machine.  For example
my setup looks like:

* machine 'A' (RH 8.0 P4 system): 
  - contains a 2.5 kernel tree on an exported NFS drive
  - this is the machine where I do all my real work, and
    do not want to run test kernels on
* machine 'B' (RH 8.0 P3 system):
  - mounts the kernel tree on 'A' to make it easy to
    install new kernels on for testing

If I 'make clean', 'make', install kernel and rerun lilo from the kernel 
tree from 'B' then I can boot the new kernel with no issues.

If I 'make clean' and 'make' from the kernel tree from 'A' and then install
from 'B' then I get a boot failure when the kernel attempts to mount the 
root partition with an error message complaining "LABEL=/" is not valid. 

This has got to be something really basic.

    --rustyl

Here is my lilo.conf ==>

prompt
timeout=50
default=linux-orig
boot=/dev/hda
map=/boot/map
install=/boot/boot.b
message=/boot/message
linear

image=/boot/hack
        label=hack
        read-only
        append="hdc=ide-scsi root=LABEL=/"

image=/boot/vmlinuz-2.4.18-14smp
        label=linux-orig
        initrd=/boot/initrd-2.4.18-14smp.img
        read-only
        append="hdc=ide-scsi root=LABEL=/"
