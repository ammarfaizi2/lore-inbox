Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269008AbUJERJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269008AbUJERJq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 13:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269068AbUJERJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 13:09:46 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:31911 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269008AbUJERJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 13:09:43 -0400
Message-ID: <4162D554.5010109@nortelnetworks.com>
Date: Tue, 05 Oct 2004 11:09:40 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: question on do_sigaltstack() -- want to allow nested calls
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The man page says that you can't call sigaltstack() while you are actually in 
the alternate stack.

I have an emulator app that wants to do some special stuff, and it seems to 
require nested calls. [1]

So...

Is it enough in this case to simply bypass the "if (on_sig_stack(sp))" check in 
do_sigaltstack()?

Chris









1: Here's why I want to do this, if anyone is interested.

case 1: --the segfault handler is set to run on alt stack, and tries to do some 
fancy stuff to trace the call chain
	--would like to set up alternate stack for SIGSEGV then drop block on that 
signal, while still in the handler for the first instance.  If we get the second 
fault, then we die a bit more messily.

case 2: --emulator software sets up handler for SIGTRAP on alt stack
	--some routines then have to run code in software being emulated, but we don't 
trust it
	--would like to set up alternate stacks for signals, then drop blocks on them 
and run code being emulated, while still running the first handler




