Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbUDSTtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 15:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbUDSTtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 15:49:07 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:50666 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261790AbUDSTtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 15:49:02 -0400
Date: Mon, 19 Apr 2004 21:49:38 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Fabiano Ramos <fabramos@bol.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: task switching at Page Faults
In-Reply-To: <1082399579.1146.15.camel@slack.domain.invalid>
Message-ID: <Pine.LNX.4.58.0404192146330.31901@artax.karlin.mff.cuni.cz>
References: <1082399579.1146.15.camel@slack.domain.invalid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi all.
>
> 	I am in doubt about the linux kernel behaviour is this situation:
> supose a have the process A, with the highest realtime
> priority and SCHED_FIFO policy. The process then issues a syscall,
> say read():
>
> 	1) Can I be sure that there will be no process switch during the
> syscall processing, even if the system call causes a page fault?

No. If the data read is not in cache and if read operations causes page
fault there will be process switch.

Additionally, if you don't mlock memory, there can be process switch at
any place, because of page faults on code pages or swapping of data pages.

> 	2) What if the process was a non-realtime processes (ordinary
> one, SCHED_OTHER)?

There can be process switches too.

Mikulas
