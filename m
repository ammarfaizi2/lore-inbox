Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269198AbUJFKzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269198AbUJFKzH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 06:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269203AbUJFKzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 06:55:07 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:35741 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S269198AbUJFKzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 06:55:02 -0400
Date: Wed, 6 Oct 2004 11:54:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Pasi Savolainen <psavo@iki.fi>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc3-mm2
In-Reply-To: <Pine.LNX.4.44.0410051251210.6757-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0410061138400.5936-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2004, Hugh Dickins wrote:
> On Tue, 5 Oct 2004, Peter Zijlstra wrote:
> > On Mon, 2004-10-04 at 19:13, Pasi Savolainen wrote:
> > > make: *** wait: No child processes.  Stop.
> > Just a simple mee too!
> 
> I've been suffering the occasional leftover zombie from multiple
> kernel builds precisely since the preempt-smp.patch went in; been
> hunting it unsuccessfully in spare moments, yesterday noticed that
> bug, today realize it's probably what I've been hunting - I'm
> about to start my own tests again, can't be sure until tomorrow.

Yes, that _raw_read_trylock patch has fixed my zombie problem: since
2.6.9-rc2-mm1 my repeated kernel builds would hang after several hours,
with a zombie (usually cc1) on one cpu and its waiting parent (usually
gcc) on another, with the puzzle of why the parent had never got woken -
because do_wait's read_lock(&tasklist_lock) went ahead even while
exit_notify held the write lock.

Hugh

