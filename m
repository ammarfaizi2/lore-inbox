Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVEXQU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVEXQU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVEXQU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:20:29 -0400
Received: from fmr20.intel.com ([134.134.136.19]:15597 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262094AbVEXQUL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:20:11 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/4] Kprobes support for IA64 
Date: Tue, 24 May 2005 09:20:08 -0700
Message-ID: <032EB457B9DBC540BFB1B7B519C78B0E07340747@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/4] Kprobes support for IA64 
thread-index: AcVgIzVqtl8kdPD8QqaeK+hCxZejuAAWRF9A
From: "Lynch, Rusty" <rusty.lynch@intel.com>
To: "Keith Owens" <kaos@sgi.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
Cc: <akpm@osdl.org>, "Luck, Tony" <tony.luck@intel.com>,
       "Seth, Rohit" <rohit.seth@intel.com>, <prasanna@in.ibm.com>,
       <ananth@in.ibm.com>, <systemtap@sources.redhat.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 May 2005 16:19:47.0583 (UTC) FILETIME=[675608F0:01C5607C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Keith Owens [mailto:kaos@sgi.com]
>Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com> wrote:
>>
>>This patch adds the kdebug die notification mechanism needed by
Kprobes.
>> 	      case 0: /* unknown error (used by GCC for
__builtin_abort()) */
>>+		if (notify_die(DIE_BREAK, "kprobe", regs, break_num,
>TRAP_BRKPT, SIGTRAP)
>>+			       	== NOTIFY_STOP) {
>>+			return;
>>+		}
>> 		die_if_kernel("bugcheck!", regs, break_num);
>> 		sig = SIGILL; code = ILL_ILLOPC;
>> 		break;
>
>Nit pick.  Any break instruction in a B slot will set break_num 0, so
>you cannot tell if the break was inserted by kprobe or by another
>debugger.  Setting the string to "kprobe" is misleading here, change it
>to "break 0".

Good catch.  We'll update the informational string.

    --rusty
