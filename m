Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbUKWJ7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbUKWJ7i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 04:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbUKWJ7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 04:59:38 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:61616 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S262104AbUKWJ72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 04:59:28 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Message-Id: <200411230959.AUF58392@mira-sjc5-e.cisco.com>
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Guillaume Thouvenin'" <Guillaume.Thouvenin@Bull.net>,
       "'lkml'" <linux-kernel@vger.kernel.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>
Subject: RE: [PATCH 2.6.9] fork: add a hook in do_fork()
Date: Tue, 23 Nov 2004 01:59:20 -0800
Organization: Cisco Systems
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <1101189797.6210.53.camel@frecb000711.frec.bull.fr>
Thread-Index: AcTRI3f3XGvuId1HTB6uxqR1OeVbxAAHy/TA
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	static int fork_hook_id = 0;
> +
> +	/* We can set the hook if it's not already used */
> +	if ((func != NULL) && (fork_hook_id == 0)) {
> +		fork_hook = func;
> +		fork_hook_id = id;
> +		return 0;
> +	}

What happens if two modules are calling the same function at the same time?

> +
> +	if (fork_hook != NULL)
> +		fork_hook(current->pid, pid);
> +
>  	return pid;

What happens if the module is unloaded between the test and the call to
fork_hook?

Hua

