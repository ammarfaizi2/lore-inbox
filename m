Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVEXFmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVEXFmL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 01:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVEXFmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 01:42:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:48580 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261269AbVEXFlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 01:41:25 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: akpm@osdl.org, tony.luck@intel.com, rohit.seth@intel.com,
       rusty.lynch@intel.com, prasanna@in.ibm.com, ananth@in.ibm.com,
       systemtap@sources.redhat.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] Kprobes support for IA64 
In-reply-to: Your message of "Mon, 23 May 2005 08:39:07 MST."
             <20050523154228.049327000@csdlinux-2.jf.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 May 2005 15:40:40 +1000
Message-ID: <6261.1116913240@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2005 08:39:07 -0700, 
Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com> wrote:
>
>This patch adds the kdebug die notification mechanism needed by Kprobes.
> 	      case 0: /* unknown error (used by GCC for __builtin_abort()) */
>+		if (notify_die(DIE_BREAK, "kprobe", regs, break_num, TRAP_BRKPT, SIGTRAP)
>+			       	== NOTIFY_STOP) {
>+			return;
>+		}
> 		die_if_kernel("bugcheck!", regs, break_num);
> 		sig = SIGILL; code = ILL_ILLOPC;
> 		break;

Nit pick.  Any break instruction in a B slot will set break_num 0, so
you cannot tell if the break was inserted by kprobe or by another
debugger.  Setting the string to "kprobe" is misleading here, change it
to "break 0".

