Return-Path: <linux-kernel-owner+w=401wt.eu-S1754250AbWLRQlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250AbWLRQlA (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 11:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754251AbWLRQlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 11:41:00 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:22840 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbWLRQlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 11:41:00 -0500
Subject: Re: bug: crash in adummy_init()
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061218153145.GA17449@elte.hu>
References: <20061218153145.GA17449@elte.hu>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 08:40:31 -0800
Message-Id: <1166460032.11560.9.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 16:31 +0100, Ingo Molnar wrote:
> crash in adummy_init() - allyesconfig bootup.
> 
> 	Ingo
> 
> ---------------->
> Calling initcall 0xc1eb1f7e: adummy_init+0x0/0xb9()
> adummy: version 1.0
> swapper/1[CPU#0]: BUG in kref_get at lib/kref.c:32
>  [<c0106273>] show_trace_log_lvl+0x34/0x4a
>  [<c01063a9>] show_trace+0x2c/0x2e
>  [<c01063d6>] dump_stack+0x2b/0x2d
>  [<c0135acb>] __WARN_ON+0x63/0x75
>  [<c04f0fb9>] kref_get+0x31/0x3c
>  [<c04f028c>] kobject_get+0x1c/0x22
>  [<c06e296a>] class_get+0x1d/0x2d

Here, adummy_init() depends on atm_init() and they're both in the same
initcall level. I wonder if there's suppose to be a set ordering inside
any given initcall level, I don't think there is.

Daniel

