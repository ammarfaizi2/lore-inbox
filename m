Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424348AbWKJEXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424348AbWKJEXf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 23:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424254AbWKJEXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 23:23:35 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:34688 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S966083AbWKJEXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 23:23:34 -0500
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: KDB blindly reads keyboard port 
In-reply-to: Your message of "Tue, 26 Sep 2006 13:54:30 CST."
             <200609261354.30722.bjorn.helgaas@hp.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 Nov 2006 15:23:20 +1100
Message-ID: <14134.1163132600@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas (on Tue, 26 Sep 2006 13:54:30 -0600) wrote:
>get_kbd_char() in arch/ia64/kdb/kdba_io.c does "inb(KBD_STATUS_REG)".
>
>But we don't know whether there's even an i8042 keyboard controller
>present.  On HP ia64 boxes, there is no i8042, and trying to read
>from it can cause an MCA.
>
>This depends on the specific platform and how it is configured.  I
>observed this MCA while booting the SLES10 install kernel on an
>HP rx7620 in "default" acpiconfig mode.  The supported acpiconfig
>mode on this box is "single-pci-domain", which also puts some
>legacy ports into "soft-fail" mode, where the read will just return
>0xff instead of causing an MCA.  But I think it's wrong to blindly
>poke around in I/O port space.

Bjron, could you try kdb-v4.4-2.6.19-rc5-{common,ia64}-2 on your
problem system?  I changed kdb so it only uses the keyboard if at least
one console matches the pattern /^tty[0-9]*$/.  IOW, if the user
specifies an i8042 style console on the command line (or uses the
default with CONFIG_VT=y) then kdb will attempt to use that keyboard.
Otherwise kdb ignores a VT style console, even when the kernel is
compiled with CONFIG_VT=y.

