Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbUJZXSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbUJZXSq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 19:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbUJZXSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 19:18:45 -0400
Received: from router.emperor-sw2.exsbs.net ([208.254.201.37]:56235 "EHLO
	sade.emperorlinux.com") by vger.kernel.org with ESMTP
	id S261535AbUJZXSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 19:18:30 -0400
From: "Lincoln D. Durey" <durey@EmperorLinux.com>
Organization: EmperorLinux
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Sony S170 + 1GB ram => Yenta: ISA IRQ mask 0x0000
Date: Tue, 26 Oct 2004 19:18:23 -0400
User-Agent: KMail/1.5.4
References: <200410261342.33924.durey@EmperorLinux.com> <Pine.LNX.4.58.0410261117530.28839@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410261117530.28839@ppc970.osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, David Hinds <dhinds@sonic.net>,
       Emperor Research <research@EmperorLinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410261918.23502.durey@EmperorLinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

> Anyway, the problem seems to be that you are doing something bad with the
> user-defined RAM map, for some reason that is not obvious at all. Your
> bootup clearly shows:

> which means that the BIOS marks the 0x000000003ff70000 - 0000000040000000
> region properly reserved, but you bave overridden this (incorrectly)
> with:

OK, we don't do anything explicit to set the RAM map.  so we looked at 
setup.c to see where that might get triggered, and it gets turned on by 
"mem=".  But we don't use mem=... (meanwhile someone runs cat 
/proc/cmdline...)

Where did that mem=1048000K come from ? (not me)

well, it must be the boot loader, as the kernel didn't add that, and we 
didn't ... looking at the GRUB source ... ARGH: we see in stage2/boot.c in 
that big comment about boot proto 2.03 that grub is indeed adding kernel 
command line options, (even to 2.4.24 and 2.6.8).  How can this be?  Their 
code says it shouldn't, but it does.

This now works fine with GRUB's --no-mem-option added.  Never in all this 
time have I seen GRUB trigger this piece of code and write mem= in on its 
own.  Oh well.

 -- Lincoln @ EmperorLinux     http://www.EmperorLinux.com

