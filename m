Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318324AbSGRSvj>; Thu, 18 Jul 2002 14:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318306AbSGRSvi>; Thu, 18 Jul 2002 14:51:38 -0400
Received: from chaos.analogic.com ([204.178.40.224]:41346 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318324AbSGRSui>; Thu, 18 Jul 2002 14:50:38 -0400
Date: Thu, 18 Jul 2002 14:56:33 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Robert Love <rml@tech9.net>
cc: Szakacsits Szabolcs <szaka@sienet.hu>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
In-Reply-To: <1027016939.1086.127.camel@sinai>
Message-ID: <Pine.LNX.3.95.1020718144203.1123A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jul 2002, Robert Love wrote:

> On Thu, 2002-07-18 at 10:25, Szakacsits Szabolcs wrote:
> 
> > And my point (you asked for comments) was that, this is only (the
> > harder) part of the solution making Linux a more reliable (no OOM
> > killing *and* root always has the control) and cost effective platform
> > (no need for occasionally very complex and continuous resource limit
> > setup/adjusting, especially for inexpert home/etc users).
> 
> I understand your point, and you are entirely right.
> 
> But it is a _completely_ unrelated issue.  The goal here is to not
> overcommit memory and I think we succeeded.
> 

Let's see, I have 30 network daemons that are all sleeping, each
requested and got 200 MB of memory to work with. I've got 10 NFS
daemons that allocated their worse-case 228 MB data-buffers. They
are all sleeping. I have 6 gettys, sleeping on terminals, they
all requested and got 32 MB. I am now trying to log-in, but
/bin/login fails to exec because there is no memory.

What should have happened is each of the tasks need only about
4k until they actually access something. Since they can't possibly
access everything at once, we need to fault in pages as needed,
not all at once. This is what 'overcomit' is, and it is necessary.

If the machine was set up with the correct amount of swap, and
if resource limits are correctly in-place, even a 16 megabyte RAM
machine will not fail due to OOM.

If you have 'fixed' something so that no RAM ever has to be paged
you have a badly broken system.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.


