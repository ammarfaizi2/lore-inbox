Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbUEBBEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUEBBEN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 21:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUEBBEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 21:04:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:37088 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262874AbUEBBEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 21:04:11 -0400
Date: Sat, 1 May 2004 18:03:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: cw@f00f.org, koke@amedias.org, linux-kernel@vger.kernel.org
Subject: Re: strange delays on console logouts (tty != 1)
Message-Id: <20040501180347.31f85764.akpm@osdl.org>
In-Reply-To: <20040501232448.GA4707@vana.vc.cvut.cz>
References: <20040430195351.GA1837@amedias.org>
	<20040501214617.GA6446@taniwha.stupidest.org>
	<20040501232448.GA4707@vana.vc.cvut.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
>
> (2) tty hangup is scheduled for work_queue.

This is the problem, isn't it?

>From what context is tty_hangup() invoked?  (stick a dump_stack() in there>?)

If possible, we should simply call do_tty_hangup() synchronously and only
do the schedule_work() thing when the hangup is initiated from the hardware
side.
