Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSJFV4k>; Sun, 6 Oct 2002 17:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262216AbSJFV4k>; Sun, 6 Oct 2002 17:56:40 -0400
Received: from packet.digeo.com ([12.110.80.53]:20633 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262215AbSJFV4j>;
	Sun, 6 Oct 2002 17:56:39 -0400
Message-ID: <3DA0B2E1.74E4FBB4@digeo.com>
Date: Sun, 06 Oct 2002 15:02:09 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Molina <tmolina@cox.net>
CC: linux-kernel@vger.kernel.org, mec@shout.net
Subject: Re: 2.5.40:  problem with configuration system
References: <Pine.LNX.4.44.0210061554520.8057-100000@dad.molina>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2002 22:02:10.0655 (UTC) FILETIME=[04FC4EF0:01C26D84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina wrote:
> 
> I was configuring a kernel for a rescue disk, so lots of things were not
> configured that normally would be.  At the end of the compile I get:
> 
> arch/i386/kernel/built-in.o: In function `MP_processor_info':
> arch/i386/kernel/built-in.o(.text.init+0x31ab): undefined reference to
> `Dprintk'

that's a bug in arch/i386/kernel/mpparse.c.  It doesn't have a
definition of Dprintk in scope on uniprocessor, non-IO-apic
builds.

Selecting io-apic-on-uniprocessor makes it go away.
