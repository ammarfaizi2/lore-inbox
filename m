Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268970AbUJKOBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268970AbUJKOBU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268971AbUJKOBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:01:19 -0400
Received: from main.gmane.org ([80.91.229.2]:9643 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268970AbUJKOBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:01:11 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jack Byer <ojbyer@usa.net>
Subject: Re: 2.6.9-rc4-mm1
Date: Mon, 11 Oct 2004 09:43:12 -0400
Message-ID: <cke3fj$eoh$1@sea.gmane.org>
References: <20041011032502.299dc88d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 69.37.187.166.adsl.snet.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040927
X-Accept-Language: en-us, en
In-Reply-To: <20041011032502.299dc88d.akpm@osdl.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to compile this kernel, I get the following error:

   Using /usr/src/linux-2.6.9-rc4-mm1 as source for kernel
   CHK     include/linux/version.h
make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
   CHK     include/asm-i386/asm_offsets.h
   CHK     include/linux/compile.h
   GEN_INITRAMFS_LIST usr/initramfs_list
Using shipped usr/initramfs_list
   CPIO    usr/initramfs_data.cpio
ERROR: unable to open 'usr/initramfs_list': No such file or directory

Usage:
         ./usr/gen_init_cpio <cpio_list>

<cpio_list> is a file containing newline separated entries that
describe the files to be included in the initramfs archive:

# a comment
file <name> <location> <mode> <uid> <gid>
dir <name> <mode> <uid> <gid>
nod <name> <mode> <uid> <gid> <dev_type> <maj> <min>

<name>      name of the file/dir/nod in the archive
<location>  location of the file in the current filesystem
<mode>      mode/permissions of the file
<uid>       user id (0=root)
<gid>       group id (0=root)
<dev_type>  device type (b=block, c=character)
<maj>       major number of nod
<min>       minor number of nod

example:
# A simple initramfs
dir /dev 0755 0 0
nod /dev/console 0600 0 0 c 5 1
dir /root 0700 0 0
dir /sbin 0755 0 0
file /sbin/kinit /usr/src/klibc/kinit/kinit 0755 0 0
make[2]: *** [usr/initramfs_data.cpio] Error 1
make[1]: *** [usr] Error 2
make: *** [bzImage] Error 2

My .config has:

# CONFIG_BLK_DEV_RAM is not set
CONFIG_INITRAMFS_SOURCE=""

