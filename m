Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVEXJeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVEXJeZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVEXJbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:31:20 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:34494 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261954AbVEXJPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:15:44 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091537.9E737F9EE@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:15:37 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id A8568FB6B

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:40 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261269AbVEXFmL (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 01:42:11 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVEXFmK

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 01:42:10 -0400

Received: from omx2-ext.sgi.com ([192.48.171.19]:48580 "EHLO omx2.sgi.com")

	by vger.kernel.org with ESMTP id S261269AbVEXFlZ (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 01:41:25 -0400

Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])

	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with SMTP id j4O7QNoS007911;

	Tue, 24 May 2005 00:26:24 -0700

Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id PAA17209; Tue, 24 May 2005 15:40:40 +1000

Received: by kao2.melbourne.sgi.com (Postfix, from userid 16331)

	id 470C270010B; Tue, 24 May 2005 15:40:40 +1000 (EST)

Received: from kao2.melbourne.sgi.com (localhost [127.0.0.1])

	by kao2.melbourne.sgi.com (Postfix) with ESMTP id 439671000F2;

	Tue, 24 May 2005 15:40:40 +1000 (EST)

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

Date:	Tue, 24 May 2005 15:40:40 +1000

Message-ID: <6261.1116913240@kao2.melbourne.sgi.com>

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

