Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310430AbSCSH6q>; Tue, 19 Mar 2002 02:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310438AbSCSH60>; Tue, 19 Mar 2002 02:58:26 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:62471 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S310430AbSCSH6Y>; Tue, 19 Mar 2002 02:58:24 -0500
Message-ID: <3C96EF17.32C9B8A0@zip.com.au>
Date: Mon, 18 Mar 2002 23:56:07 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: Russ Weight <rweight@us.ibm.com>, mingo@elte.hu,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Scalable CPU bitmasks
In-Reply-To: <20020318140700.A4635@us.ibm.com> <200203190728.g2J7Srq31344@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> 
> On 18 March 2002 20:07, Russ Weight wrote:
> >           While systems with more than 32 processors are still
> >   out in the future, these interfaces provide a path for gradual
> >   code migration. One of the primary goals is to provide current
> >   functionality without affecting performance.
> 
> Not so far in the future. "7.52 second kernel compile" thread is about
> timing kernel compile on the 32 CPU SMP box.

The x86 spinlock implementation underflows at 128 CPUs [1].
 
> I don't know whether BUG() in inlines makes them too big,

It does, on all but very recent gcc's.  Strings in inlines
generally cause vast kernel bloatage.

> but _for() _loops_ in inline functions definitely do that.
> Here's one of the overgrown inlines:

Sigh.  There is far too much inlining in Linux.

[1] Untested.

-
