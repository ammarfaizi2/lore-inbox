Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSGVMmc>; Mon, 22 Jul 2002 08:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316848AbSGVMmc>; Mon, 22 Jul 2002 08:42:32 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:23503 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S316845AbSGVMmc>; Mon, 22 Jul 2002 08:42:32 -0400
Date: Mon, 22 Jul 2002 13:45:40 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Szakacsits Szabolcs <szaka@sienet.hu>, Adrian Bunk <bunk@fs.tum.de>,
       Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strict VM overcommit
In-Reply-To: <1027342809.31782.28.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0207221332040.1034-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jul 2002, Alan Cox wrote:
> 
> Lets put this bluntly. Your swapdisk is losing sectors left right and
> centre. You propose a system where the kernel says "sorry might cause an
> OOM" and I lose everything as the disk goes down. Letting the admin set
> policy means I can swapoff, maybe lose a program or two to OOM but not
> lose the entire system in the process.
> 
> Its quite clear that being able to override the kernels assumptions
> about what is right are sensible. It always has been

Suggested compromise: swapoff (in loose overcommit-permitted mode)
should always swap off as much as it can, a small margin short of
causing OOM, but should then give up with ENOMEM (leaving the whole
swap area available again, for consistency).  Seeing its failure,
the admin can then choose processes to kill (overriding the kernel's
assumptions about what is right to kill), and try swapoff again.

At present it never gives up: I do intend to fix that.

In strict no-overcommit mode, it should probably decide in advance
whether to embark on swapping off: I think you suggested that
earlier in the thread, that it's acceptable to switch overcommit
mode temporarily to achieve whichever behaviour is desirable?

Hugh

