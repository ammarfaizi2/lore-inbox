Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265179AbTF1NYG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 09:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265188AbTF1NYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 09:24:06 -0400
Received: from angband.namesys.com ([212.16.7.85]:16345 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S265179AbTF1NYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 09:24:02 -0400
Date: Sat, 28 Jun 2003 17:38:18 +0400
From: Oleg Drokin <green@namesys.com>
To: "T. Weyergraf" <kirk@colinet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.73 on alpha/smp build failure
Message-ID: <20030628133818.GA6073@namesys.com>
References: <kirk-1030628112813.A0111034@hydra.colinet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kirk-1030628112813.A0111034@hydra.colinet.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Jun 28, 2003 at 11:28:13AM +0200, T. Weyergraf wrote:

> Any ideas ?  ( what puzzles me, is that i am apparently the only
> alpha user with that problem... )

Speaking of alphas, I have strange alpha problem myself.
When I compile the kernel the alpha itself (tried shipped suse 8.1 gcc 3.2.2
and self-compiled gcc 2.95.3), it jumps to the address zero quickly after
launching init and panics.
If I cross compile kernel with crosscompiler (2.95.3) on my x86 PC,
kernel boots, but there are a lot of strangeness happens.
For example find a program below, if I compile it with a cross-compiler,
it produces "vs-500: unknown uniqueness -2" message, but if compiled with
a native compiler it produces expected "result is 1".
This code below is a part of reiserfs code, and when it does not work
as expected, no wonder reiserfs breaks in a lot of funny ways.
(besides the fact that I was debugging other reiserfs problem on 64 bit platforms).
Also in kernel compiled with the crosscompiler, pty/tty stuff does not work and
other funny errors from other parts of kernel (but still this is much better compared
to native compile). Of course the config is the same for both native and crosscompilation.
Kernel I am compiling is 2.5.73+ (some bk snapshot, last changeset is this
"ChangeSet@1.1505, 2003-06-26 20:35:32-07:00, greg@kroah.com")

I wonder is anyone have any advices on how to overcome those problems I am facing.
Our Alpha is a Ruffian-type of system with EV56 500 Mhz CPU.

The testcase code is (if you cast uniqueness to int in the switch(), it works as expected
even with crosscompiler):

#include <stdio.h>
#include <sys/types.h>
#define V1_DIRECT_UNIQUENESS 0xffffffff
#define V1_DIRENTRY_UNIQUENESS 500
#define V1_ANY_UNIQUENESS 555 // FIXME: comment is required
#define V1_INDIRECT_UNIQUENESS 0xfffffffe
#define V1_SD_UNIQUENESS 0

#define TYPE_STAT_DATA 0
#define TYPE_INDIRECT 1
#define TYPE_DIRECT 2
#define TYPE_DIRENTRY 3
#define TYPE_MAXTYPE 3
#define TYPE_ANY 15 // FIXME: comment is required

static inline int uniqueness2type (unsigned int uniqueness)
{
    switch (uniqueness) {
    case V1_SD_UNIQUENESS: return TYPE_STAT_DATA;
    case V1_INDIRECT_UNIQUENESS: return TYPE_INDIRECT;
    case V1_DIRECT_UNIQUENESS: return TYPE_DIRECT;
    case V1_DIRENTRY_UNIQUENESS: return TYPE_DIRENTRY;
    default:
printf("vs-500: unknown uniqueness %d\n", uniqueness);
return TYPE_ANY;
    }
}

int main(void)
{
unsigned int a=V1_INDIRECT_UNIQUENESS;
printf("result is %d\n", uniqueness2type(a));
return 0;
}

Bye,
    Oleg
