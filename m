Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263890AbTJ1IdV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 03:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTJ1IdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 03:33:20 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:60934 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263890AbTJ1IdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 03:33:19 -0500
Subject: Re: [pm] fix time after suspend-to-*
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: George Anzinger <george@mvista.com>, Pavel Machek <pavel@suse.cz>,
       John stultz <johnstul@us.ibm.com>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0310271535160.13116-100000@cherise>
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise>
Content-Type: text/plain
Message-Id: <1067329994.861.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-5) 
Date: Tue, 28 Oct 2003 09:33:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-28 at 00:43, Patrick Mochel wrote:

> Userspace behavior on suspend transitions is still a bit fuzzy at best. I 
> am beginning to look at userspace requirements, so if anyone wants to send 
> me suggestions, no matter how trivial or wacky, please feel free (on- or 
> off-list). 

Many userspace applications are not prepared for suspension, like
Evolution. When suspending the machine for a long time, all IMAP
sessions are broken as their counterpart TCP sockets timeout. While
resuming, Evolution is unable to handle this condition and simply
informs the network connection has been dropped.

What about sending the SIGPWR signal to all userspace processes before
suspending so applications like Evolution can be improved to handle this
signal, drop their IMAP connections and then, when resuming, reestablish
them?

