Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbUBZW4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUBZWzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:55:01 -0500
Received: from dp.samba.org ([66.70.73.150]:42959 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261227AbUBZWyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:54:09 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Corey Minyard <minyard@acm.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IPMI driver updates, part 3 
In-reply-to: Your message of "Mon, 23 Feb 2004 10:02:50 MDT."
             <403A242A.6000802@acm.org> 
Date: Fri, 27 Feb 2004 09:48:33 +1100
Message-Id: <20040226225419.20A032C360@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <403A242A.6000802@acm.org> you write:
> +  insmod ipmi_smb_intf.o
> +	smb_addr=<adapter1>,<i2caddr1>[,<adapter2>,<i2caddr2>[,...]]
> +	smb_dbg=<flags1>,<flags2>...
> +	[smb_defaultprobe=0] [smb_dbg_probe=1]

Please use "modprobe" not "insmod" in examples, and drop the ".o"
extension.

> +When compiled into the kernel, the addresses can be specified on the
> +kernel command line as:
> +
> +  ipmi_smb=[<adapter1>.]<addr1>[:<debug1>],[<adapter2>.<addr2>[:<debug1>]....

I realize this is traditional.  However, I suggest you:
1) Rename the module to impi_smb.
2) Change the variable names to addr, debug, debug_probe and
   default_probe.
3) Change MODULE_PARM to module_param
4) Get rid of the #ifndef MODULE code.

The results will be symmetry, and less code:

	modprobe ipmi_smb addr=<adapter1>,<i2caddr1>[,<adapter2>,<i2caddr2>[,...]]
		debug=<flags1>,<flags2>...
		default_probe=0 debug_probe=1

and

	boot ipmi_smb.addr=... ipmi_smb.debug=... ipmi.default_probe=0 ipmi.debug_probe=1

Of course, if you really want to you can use module_param_named and
keep the variable names the same as they are now, and "#undef
KBUILD_MODNAME // #define KBUILD_MODNAME ipmi_smb", to avoid renaming
your module.

But I really think the module name wants a revisit (although I have no
idea what it does, so might be wrong).

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
