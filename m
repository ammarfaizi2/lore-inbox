Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264933AbUF1NBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUF1NBm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 09:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264934AbUF1NBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 09:01:41 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:27344 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264933AbUF1NBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 09:01:36 -0400
Date: Mon, 28 Jun 2004 14:01:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: William Lee Irwin III <wli@holomorphy.com>
cc: Brian <bmg300@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel VM bug?
In-Reply-To: <20040628025832.GM21066@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0406281342480.13228-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004, William Lee Irwin III wrote:
> 
> Strict non-overcommit is also good to have in order for orderly
> application shutdown or otherwise application self-regulation of
> resource demands to occur at the time of hardware resource exhaustion.
> This is by necessity enabled by default and has to be disabled at
> runtime. You shouldn't have to do anything to enable it, but to
> doublecheck that strict non-overcommit hasn't been disabled by e.g.
> initscripts, please check that /proc/sys/vm/overcommit_memory stays 0.

I'm not sure if I'm niggling over terminology, or pointing out a
significant misunderstanding: but /proc/sys/vm/overcommit_memory 0
(indeed the default) is not what I call strict non-overcommit: that's 2.

All settings (0, 1, 2) maintain the Committed_AS count shown in
/proc/meminfo; but only /proc/sys/vm/overcommit_memory 2 totals and
limits reservations using it.  1 imposes no limit.  0 checks that the
particular "reservation" could plausibly be made available now, but
without considering the total: so allows any number of concurrent
maximum reservations - traditional relaxed Linux behaviour, not strict.

(2 came along much later, yes the naming and numbering are both horrid.)

Hugh

