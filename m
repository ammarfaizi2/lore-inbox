Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271140AbTHLVkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 17:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271177AbTHLVkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 17:40:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:3299 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271140AbTHLVjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 17:39:06 -0400
Date: Tue, 12 Aug 2003 14:25:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3-mm1 and rootflags
Message-Id: <20030812142519.69a04b7c.akpm@osdl.org>
In-Reply-To: <200308121855.h7CIt6St002437@turing-police.cc.vt.edu>
References: <200308121855.h7CIt6St002437@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> OK.. I'm stumped..
> 
> While testing something, I tried to boot with 'rootflags=noatime', and
> found the system wouldn't boot, as ext3, ext2, and reiserfs all failed to
> recognize the option.  Looking at the code in fs/ext3/super.c:parse_options()
> and init/do_mounts.c:root_data_setup(), it appears to be impossible
> to set any of the filesystem-independent flags via rootflags, which explains
> the special-case code for the 'ro' and 'rw' flags.  However, there doesn't
> seem to be any way to pass nodev, noatime, nodiratime, or any of the other
> flags.  (And yes, all 3 of those make sense in my environment - it's a laptop
> and I don't need atime, and I use devfs so nodev on the root makes sense too).
> 

The fs-independent options are parsed in user space by mount(8), and are
passed into the kernel as individual bits in a `flags' argument.

So we'd need a new `rootopts=0x0040' thingy to support this.  But given
that most things can be set after boot with `mount / -o remount,noatime',
it may not be necessary.

