Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265953AbSKBMBw>; Sat, 2 Nov 2002 07:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265954AbSKBMBv>; Sat, 2 Nov 2002 07:01:51 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:13838 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265953AbSKBMBu>; Sat, 2 Nov 2002 07:01:50 -0500
Message-Id: <200211021203.gA2C37p24480@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] 2/2 2.5.45 cleanup & add original copy_ro/from_user
Date: Sat, 2 Nov 2002 14:55:08 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <20021102025838.220E.AT541@columbia.edu.suse.lists.linux.kernel> <3DC3A9C0.7979C276@digeo.com.suse.lists.linux.kernel> <p73y98cqlv3.fsf@oldwotan.suse.de>
In-Reply-To: <p73y98cqlv3.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 November 2002 08:58, Andi Kleen wrote:
> Andrew Morton <akpm@digeo.com> writes:
> > (That is, using the movnta instructions for well-aligned copies
> > and clears so that we don't read the destination memory while
> > overwriting it).
>
> I did some experiments with movnta and it was near always a loss for
> memcpy/copy_*_user type stuff. The reason is that it flushes the
> destination out of cache and when you try to read it afterwards for
> some reason (which happens often - e.g. most copy_*_user uses
> actually do access it afterwards) then you eat a full cache miss for
> them and that is costly and kills all other advantages.

That depends on size. If you do huge memcpy (say 1 mb) it still
wins by wide margin. Not that we do such huge operations often,
but code can check size and pick different routines for small
and big blocks
--
vda
