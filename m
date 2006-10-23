Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbWJWUJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWJWUJB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWJWUJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:09:01 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:29843 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965024AbWJWUJA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:09:00 -0400
Date: Mon, 23 Oct 2006 15:24:56 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: [RFC][PATCH 0/11] i386: Relocatable BzImage (V3)
Message-ID: <20061023192456.GA13263@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the third attempt on implementing relocatable bzImage for i386.
Eric has done all the ground work and I am just giving it final finish.
Generated patches against (2.6.19-rc2-git7).

V2 ran into issues with lilo on Andrew's machine. I can't reproduce the
problem. For the sake of simpilicity, I have dropped the bit which added
and ELF header to bzImage. Instead, I have extended the bzImage protocol
to enable boot loaders to load protected mode kernel at a non 1MB address.
Hopefully this should not break any existing behaviour.

This functionality is especially useful for kdump where a single kernel
can be used both as production kernel and dump capture kernel and distors
don't have to maintain an additional kernel just for capturing the dump.

I have tested it with grub (.97) and lilo (lilo 22.7.3). 

Note: One has to upgrade the binutils if you want to use
      CONFIG_RELOCATABLE=y. Previous ld version will make section relative
      symbols absolute, if section containing the symbols has zero size.
      These absolute symbols are not relocated. This issue has been fixed
      in latest binutils. I am using the one built on 09th octoer 2006 and
      it works fine for me.   

Chages since version V2
----------------------
- Dropped adding and ELF header to bzImage.
- Extended bzImage protocol for relocatable bzImage (version 2.05)
- Added support to display warning message at compilation time if
  relocations relative to absolute symbols are present.
- Fixed a bug where some intermediate files were not being cleaned up
  by "make clean"
- Avoid building vmlinux.bin.all if CONFIG_RELOCATABLE is not set.

Looking forward for your suggestions and any test results.

Thanks
Vivek
