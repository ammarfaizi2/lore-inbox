Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266123AbTGDTHM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 15:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbTGDTHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 15:07:12 -0400
Received: from air-2.osdl.org ([65.172.181.6]:9877 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266123AbTGDTHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 15:07:05 -0400
Date: Fri, 4 Jul 2003 12:21:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: benh@kernel.crashing.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linuxppc-dev@lists.linuxppc.org>, <linuxppc64-dev@lists.linuxppc.org>
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
In-Reply-To: <20030704174558.GC22152@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0307041217180.1748-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jul 2003, Jörn Engel wrote:
> 
> This is the generic part of the signal stack fixes, it simply
> introduces a new PF-flag that indicates whether we are using the
> signal stack right now or not.

My reason for disliking this patch is that it adds user-space information 
to the kernel - in a place where user space cannot get at it.

In particular, any traditional cooperative user-space threading package
wants to switch its own stack around, and they all do it by just changing
%esp directly. The whole point of such threading is that it's _fast_,
since it doesn't need any kernel support (and since it's cooperative, you
can avoid locking).

The old "optimization" that you didn't like was not an optimization at 
all: it got the case of user space changing stacks _right_, while still 
allowing yet another stack for signal handling and exiting the signal by 
hand.

Does anybody do that? I don't know. But it was done the way it was done on 
purpose.

		Linus

