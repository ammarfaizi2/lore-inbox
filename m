Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbUC2QTw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 11:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbUC2QTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 11:19:11 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:55987 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262990AbUC2QSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 11:18:12 -0500
Date: Mon, 29 Mar 2004 17:18:12 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: John Stoffel <stoffel@lucent.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-mm1 - swapoff dies with OOM, why?
In-Reply-To: <16488.14980.884442.349267@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.44.0403291708001.18667-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004, John Stoffel wrote:
> 
> I'm still wondering why swapoff dies though.  Shouldn't it complete,
> or at least have some way *to* complete if needed?  I realize, with a
> memory leak in the filesystem, it's a hard thing to deal with.  

If there's not enough freeable memory for what's out on swap, swapoff
cannot very well complete.  Either it can hang while other processes
get killed by the OOM killer once swapoff has filled memory (as 2.4),
until there's enough memory free to take in what's still needed from
swap; or the OOM killer can kill it off (as 2.6).  I much prefer the
2.6 behaviour - unlike many processes, swapoff can safely be restarted.
So the admin can then choose what else to kill, or add replacement
swap, then try the original swapoff again.

Hugh

