Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266135AbTGDTci (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 15:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbTGDTch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 15:32:37 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:2203 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266135AbTGDTcg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 15:32:36 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 4 Jul 2003 12:39:16 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       benh@kernel.crashing.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@lists.linuxppc.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
In-Reply-To: <Pine.LNX.4.44.0307041217180.1748-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.55.0307041231350.5132@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0307041217180.1748-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jul 2003, Linus Torvalds wrote:

> My reason for disliking this patch is that it adds user-space information
> to the kernel - in a place where user space cannot get at it.
>
> In particular, any traditional cooperative user-space threading package
> wants to switch its own stack around, and they all do it by just changing
> %esp directly. The whole point of such threading is that it's _fast_,
> since it doesn't need any kernel support (and since it's cooperative, you
> can avoid locking).
>
> The old "optimization" that you didn't like was not an optimization at
> all: it got the case of user space changing stacks _right_, while still
> allowing yet another stack for signal handling and exiting the signal by
> hand.
>
> Does anybody do that? I don't know. But it was done the way it was done on
> purpose.

Yes, GNU Pth :

http://www.gnu.org/software/pth/

and, for example :

http://www.xmailserver.org/libpcl.html

They use the generic POSIX stack setup described here :

http://www.gnu.org/software/pth/rse-pmt.ps

My Pine's 'd' key deleted his patch before I could take an exhaustive
look, but it should be fine though. They both do use to enter the signal
handler simply to get a snapshot of the context, and they exit the handler
by letting the kernel to clean the on-sig-stack flag. try to search
archives to take a better look at the patch ...



- Davide

