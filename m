Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTFIU6q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 16:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTFIU6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 16:58:46 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:48574 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262063AbTFIU6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 16:58:44 -0400
Date: Mon, 9 Jun 2003 14:08:34 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 (virgin) hangs running SDET
Message-Id: <20030609140834.11ad0d63.akpm@digeo.com>
In-Reply-To: <60380000.1055188542@flay>
References: <60380000.1055188542@flay>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jun 2003 21:12:24.0564 (UTC) FILETIME=[D2C17B40:01C32ECB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> I thought this was specific to the -mjb tree for a while, but I can
> reproduce it pretty easily on virgin 2.5.70 (but 2.5.69 didn't do
> this). Andrew looked and pointed out it seems to be an i_sem (ISTR
> some mention of /proc somewhere too?). Got a good sysrq+t trace out
> of the virgin kernel (on 16x NUMA-Q) ... below:

The ps instance which is spinning on kernel_flag in proc_root_lookup is
what's holding things up.

Or is it spinning in proc_lookup() or proc_pid_lookup()?  I have a vague
feeling that I've seen these traces miss out the innermost stack slot...

Suggest:

a) Use CONFIG_SPINLINE, get a new sysrq-T trace

b) Enable spinlock debugging

c) Try disabling the sched_balance_exec() code.


