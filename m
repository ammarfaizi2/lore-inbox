Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314389AbSFNU4E>; Fri, 14 Jun 2002 16:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314241AbSFNU4D>; Fri, 14 Jun 2002 16:56:03 -0400
Received: from mail.webmaster.com ([216.152.64.131]:60108 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S314227AbSFNU4D> convert rfc822-to-8bit; Fri, 14 Jun 2002 16:56:03 -0400
From: David Schwartz <davids@webmaster.com>
To: <kernel@tekno-soft.it>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Fri, 14 Jun 2002 13:56:00 -0700
In-Reply-To: <5.1.1.6.0.20020613171707.03f09720@mail.tekno-soft.it>
Subject: Re: Developing multi-threading applications
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020614205601.AAA9369@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Jun 2002 18:26:54 +0200, Roberto Fichera wrote:
>At 04.58 13/06/02 -0700, David Schwartz wrote:

>This is a scheduler problem! All threads waiting for I/O are blocked by
>the scheduler, and this doesn't have any impact for the context switches
>it increase only the waitqueue, using the Ingo's O(1) scheduler, a big piece
>of code, it should make a big difference for example.

	You are incorrect. If you have ten threads each waiting for an I/O and all 
ten I/Os are ready, then ten context switches are needed. If you have one 
thread waiting for ten I/Os, and then I/Os come ready, one context switch is 
needed.

[snip]

>I don't think "more threads == more work done"! With the thread's approch
>it's
>possible to split a big sequential program in a variety of concurrent 
>logical
>programs with a big win for code revisions and new implementation.

	I'm not advising eliminating the threads approach. I'm only advising not 
using threads as your abstraction for clients or work to be done. Use threads 
as the execution vehicles that pick up work when there's work to be done. 
(Think thread pools, think separating I/O from computation.)

[snip]
>You are right! But depend by the application! If you have todo I/O like
>signal acquisition,
>sensors acquisitions and so on, you must have a one thread for each type of
>data acquisition,

	Even if that's true, and it's often not, how many different types of data 
acquisition can you have? Ten? Twenty? That's a far cry from 300.

	DS


