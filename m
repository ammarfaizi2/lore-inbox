Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265947AbSKBMQc>; Sat, 2 Nov 2002 07:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265948AbSKBMQc>; Sat, 2 Nov 2002 07:16:32 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:59406 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265947AbSKBMQb>; Sat, 2 Nov 2002 07:16:31 -0500
Message-Id: <200211021216.gA2CGEp24534@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] 2/2 2.5.45 cleanup & add original copy_ro/from_user
Date: Sat, 2 Nov 2002 15:08:16 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20021102025838.220E.AT541@columbia.edu.suse.lists.linux.kernel> <200211021203.gA2C37p24480@Port.imtp.ilyichevsk.odessa.ua> <20021102130954.A30729@wotan.suse.de>
In-Reply-To: <20021102130954.A30729@wotan.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 November 2002 10:09, Andi Kleen wrote:
> > That depends on size. If you do huge memcpy (say 1 mb) it still
> > wins by wide margin. Not that we do such huge operations often,
> > but code can check size and pick different routines for small
> > and big blocks
>
> The kernel nevers does such huge memcpys. It rarely does handle any
> buffer bigger than a page (4K)

Okay I take that.

How did you determined that movntXX stores are net loss?
I thought about that and didn't came to a working solution.

It's easy to time memcpy() but harder to measure susequent
cache misses when copied data gets accessed. We can read it
back after memcpy and measure memcpy()+read, but is entire
copy gets used immediately after memcpy() in real world usage?
We're in benchmarking hell :(
--
vda
