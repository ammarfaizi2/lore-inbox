Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbTFKLFg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 07:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbTFKLFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 07:05:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6530 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264346AbTFKLFf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 07:05:35 -0400
Date: Wed, 11 Jun 2003 07:20:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Steve French <smfrench@austin.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling kernel with SuSE 8.2/gcc 3.3
In-Reply-To: <3EE6B7A2.3000606@austin.rr.com>
Message-ID: <Pine.LNX.4.53.0306110713580.8991@chaos>
References: <3EE6B7A2.3000606@austin.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jun 2003, Steve French wrote:

> Stephan von Krawczynski <skraw@ithnet.com> writes:
>
> > during tests with latest SuSE distro 8.2 compiling 2.4.21-pre6 showed a lot of
> > "comparison between signed and unsigned" warnings. It looks like SuSE ships gcc
>
> I also noticed lots of compiler warnings with gcc 3.3, now default in SuSE,
> and cleaned up most of them for the cifs vfs but there are a few that just
> look wrong for gcc to spit out warnings on.   For example the following
> local variable definition and the similar ones in the same file
> (fs/cifs/inode.c):
>
> 	__u64 uid = 0xFFFFFFFFFFFFFFFF;
>
> generates a warning saying the value is too long for a long on
> x86 SuSE 8.2 with gcc 3.3 - which makes no sense.  Any value
> above 0xFFFFFFFFF generates the same warning (intuitively
> 36 bits should fit in an unsigned 64 bit local variable).
[SNIPPED...]

I think the compiler doesn't have a default type for something
that long. Therefore you have to define is as:

 	__u64 uid = 0xFFFFFFFFFFFFFFFFULL;

Seems dumb, but it even works.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

