Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbTGHSMa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 14:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265177AbTGHSMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 14:12:30 -0400
Received: from air-2.osdl.org ([65.172.181.6]:15541 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265176AbTGHSM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 14:12:28 -0400
Date: Tue, 8 Jul 2003 11:20:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: idan@idanso.dyndns.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug 890] New: performance regression compared to 2.4.20 under
 tight RAM conditions
Message-Id: <20030708112048.2c3b680d.akpm@osdl.org>
In-Reply-To: <40390000.1057673479@[10.10.2.4]>
References: <40390000.1057673479@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> As can be seen, the differences are quite significant, about three seconds on
> average, which I believe may be related to the increased swapping time I have
> encountered.

The 2.4 VM's virtual scan has the effect of swapping out one process at a
time.  2.5's physical(ish) scan doesn't have that side-effect.

It means that in 2.4, the lucky processes can make decent progress.  In
2.5, everyone makes equal progress and everyone thrashes everyone else to
bits.

To fix this properly we need load control: to identify when the system is
thrashing and to explicitly suspend chosen processes for a while, so other
processes can make decent progress.  A couple of people are looking at
that; I'm not sure what stage it is at.

