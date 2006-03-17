Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752554AbWCQJ0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbWCQJ0O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 04:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbWCQJ0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 04:26:14 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:38350 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1752554AbWCQJ0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 04:26:14 -0500
Date: Fri, 17 Mar 2006 10:23:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Jan Altenberg <tb10alj@tglx.de>,
       Sastien Dugu <sebastien.dugue@bull.net>
Subject: Re: 2.6.16-rc6-rt3
Message-ID: <20060317092351.GA18491@elte.hu>
References: <20060314084658.GA28947@elte.hu> <4416C6DD.80209@cybsft.com> <20060314142458.GA21796@elte.hu> <4416F14E.1040708@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4416F14E.1040708@cybsft.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

>  [<c0103c3b>] die+0xf3/0x16f (56)
>  [<c0111e19>] do_page_fault+0x36f/0x48a (88)
>  [<c010357f>] error_code+0x4f/0x54 (76)
>  [<c0132cc6>] resolve_symbol+0x22/0x5d (44)
>  [<c013321c>] simplify_symbols+0x81/0xf4 (40)
>  [<c0133e2d>] load_module+0x637/0x968 (168)
>  [<c01341c1>] sys_init_module+0x3d/0x1d3 (28)
>  [<c0102a1b>] sysenter_past_esp+0x54/0x75 (-8116)

S�bastien Dugu� found a bug that might explain your crash: during the 
2.6.16 rebase we lost a section marker which missing marker placed 
assembly code into the ksymtabs table. That could cause confusion in the 
ksymtab parser.

I've released 2.6.16-rc6-rt9 with this fix - could you check whether the 
crash you are seeing is fixed?

	Ingo
