Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755139AbWKMQ6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755139AbWKMQ6N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755206AbWKMQyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:54:11 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:5802 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1755214AbWKMQyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:54:05 -0500
Date: Mon, 13 Nov 2006 11:21:35 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com
Subject: [RFC] [PATCH 0/16] x86_64: Relocatable bzImage Support (V2)
Message-ID: <20061113162135.GA17429@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Eric Biederman implemented the relocatable bzImage for x86_64 and posted
patches for comments quite some time back.

http://marc.theaimsgroup.com/?l=linux-kernel&m=115443019026302&w=2

We have been testing the patches in RHEL kernels since then and things are
looking up. I think this is the time that patches can be included in -mm
and get more testing done and get rest of the issues sorted out.

Eric is currently held up with other things, so I have taken his patches
and forward ported to 2.6.19-rc5-git2. Did few cleanups and fixed few
bugs as faced in our testing. I have also accomodated the review comments
received last time.

These changes make a bzImage and vmlinux relocatable hence kernel can be
loaded at and run from a non-1MB location. These changes are especially
useful for kdump where a single kernel can be used both as production 
kernel and dump capture kernel hence making the life easier both for
distros and developers.

Following is a brief account of changes I have done since patches were
posted last time.

- Forward ported the changes to latest kernel.
- Extended bzImage protocol to handle relocatable kernel
- Dropped support for elf bzImage
- Dropped support for the serial debugging in decompressor code.
- Fixed a bug related to memory hotplug.
- Fixed a bug related to setting NX bit  (Thanks to larry woodman)
- Fixed a bug regarding jumping to secondary_startup_64 instead of
  assuming that align fills empty space with "nop".
- Fixed a bug regarding phys_base being put in initdata section.
- Fixed a but where bss was not being zeroed properly
- Reverted the change back to cotinue to compile the kernel for 2MB so
  that loaders loading vmlinux directly are not broken.
- Aligned data segment to 4K boundary to make kexec using vmlinux work.
- Tested to patch for making sure suspend/resume to/from memory is working.
  (Required due to ACPI wake up code changes)

Your comments/suggestions are welcome.

Thanks
Vivek
