Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSHXRnx>; Sat, 24 Aug 2002 13:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSHXRnx>; Sat, 24 Aug 2002 13:43:53 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:3845
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S316578AbSHXRnw>; Sat, 24 Aug 2002 13:43:52 -0400
Subject: Re: Preempt note in the logs
From: Robert Love <rml@tech9.net>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Arador <diegocg@teleline.es>, dag@newtech.fi, linux-kernel@vger.kernel.org,
       conman@kolivas.net
In-Reply-To: <Pine.LNX.4.44.0208241109210.3234-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0208241109210.3234-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Aug 2002 13:48:03 -0400
Message-Id: <1030211284.1935.4991.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-24 at 13:12, Thunder from the hill wrote:

> We have to check
> 1. process kicking code
> 2. process killing code
> 3. memory allocation code
> 4. read/write code

The problem can be anywhere, actually.  #4 (and other file I/O) is the
best bet though, I suspect.

It is caused by any mismatched locking - it is a good debugging check
regardless of preemption.

The only known place I or others see it now is on shutdown, since we
have kernel threads that do not drop the BKL and other locks when they
shutdown since the system is about to halt anyway.

There was some reports of XFS earlier... I thought they were fixed (I
talked to those guys).  Maybe some other rogue module...

	Robert Love

