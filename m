Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbTKJSG4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 13:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbTKJSGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 13:06:55 -0500
Received: from zero.aec.at ([193.170.194.10]:10764 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264043AbTKJSGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 13:06:53 -0500
To: Adam Litke <agl@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Smarter stack traces using the frame pointer
From: Andi Kleen <ak@muc.de>
Date: Mon, 10 Nov 2003 19:06:03 +0100
In-Reply-To: <QouH.36G.7@gated-at.bofh.it> (Adam Litke's message of "Mon, 10
 Nov 2003 19:00:15 +0100")
Message-ID: <m3wua85cac.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <OhH5.6Y2.13@gated-at.bofh.it> <QouH.36G.7@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Litke <agl@us.ibm.com> writes:

> -static int kstack_depth_to_print = 24;
> +static int kstack_depth_to_print = 128;

I would not do that. It makes too much of the oops scroll away.

> +	show_stack_frame((unsigned long) stack, ebp+4);

I think this needs much more sanity checking, otherwise the risk
of recursive oops etc is too big.

I would always check first if the stack value read from ebp is inside the 
stack page of the current process. If you're paranoid you could even use 
__get_user() to catch exceptions.

-Andi
