Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTKTC5j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 21:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264203AbTKTC5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 21:57:38 -0500
Received: from holomorphy.com ([199.26.172.102]:48555 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264178AbTKTC5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 21:57:36 -0500
Date: Wed, 19 Nov 2003 18:57:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christopher Li <lkml@chrisli.org>
Cc: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-ID: <20031120025730.GD22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christopher Li <lkml@chrisli.org>,
	Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar> <20031119223425.GA20549@64m.dyndns.org> <20031120014718.GA22764@holomorphy.com> <20031119232246.GA20840@64m.dyndns.org> <20031120023457.GC22764@holomorphy.com> <20031119234037.GC20840@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119234037.GC20840@64m.dyndns.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 06:34:57PM -0800, William Lee Irwin III wrote:
>> I'm going to ruminate on non-fatal methods of complaining loudly.

On Wed, Nov 19, 2003 at 06:40:37PM -0500, Christopher Li wrote:
> SPARSE checker?

I was thinking of teaching the fault handlers to complain about
->nopage() methods returning invalid results in a non-fatal manner,
possibly with code consolidation.

e.g. every arch does:

	switch (handle_mm_fault(...)) {
		case VM_FAULT_MINOR:
			tsk->min_flt++;
			break;
		case VM_FAULT_MAJOR:
			tsk->maj_flt++;
			break;
		case VM_FAULT_SIGBUS:
			goto do_sigbus;
		case VM_FAULT_OOM:
			goto out_of_memory;
		default:
			BUG();
	}

which is vaguely repetitive. It's not immediately clear how to
consolidate gotos, which is where the thought starts happening.

The other part was replacing default: BUG() with something that
complained (e.g. putting print_symbol() to use on the ->nopage()
method) and treating the invalid statuses like OOM, but that's
not really very hard to do (I posted something that did some
crude reporting of that kind already to handle the sound/ bogons).


-- wli
