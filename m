Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269857AbTGOW4f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 18:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269861AbTGOW4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 18:56:35 -0400
Received: from dub.inr.ac.ru ([193.233.7.105]:55975 "HELO dub.inr.ac.ru")
	by vger.kernel.org with SMTP id S269857AbTGOW4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 18:56:32 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200307152310.DAA09663@dub.inr.ac.ru>
Subject: Re: [PATCH] [1/2] kernel error reporting (revised)
To: akpm@osdl.org (Andrew Morton)
Date: Wed, 16 Jul 2003 03:10:47 +0400 (MSD)
Cc: jkenisto@us.ibm.com, jmorris@intercode.com.au, davem@redhat.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com,
       alan@lxorguk.ukuu.org.uk, rddunlap@osdl.org, kuznet@ms2.inr.ac.ru
In-Reply-To: <20030715125121.315920a2.akpm@osdl.org> from "Andrew Morton" at  =?ISO-8859-1?Q?=20=E9?=
	=?ISO-8859-1?Q?=C0=CC?= 15, 2003 12:51:21 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> netlink_broadcast() does read_lock(&nl_table_lock).  But nl_table_lock is
> not an irq-safe lock.

Just as reminder, there are _no_ irq safe locks in net/*. A few of
local_irq_disable()s are segregated in interface to device drivers.


> Possibly netlink_broadcast() can be made callable from hardirq context, but
> it looks to be non trivial.

Trivial or non-trivial, before all this is highly not desired.
net/* is better to remain in the form free of knowledge of hardirqs.

Alexey
