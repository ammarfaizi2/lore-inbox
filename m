Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265047AbTFLXXi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265046AbTFLXXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:23:37 -0400
Received: from mail.webmaster.com ([216.152.64.131]:37612 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S265047AbTFLXX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:23:27 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Timothy Miller" <miller@techsource.com>
Cc: "Muthian Sivathanu" <muthian_s@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: RE: limit resident memory size
Date: Thu, 12 Jun 2003 16:37:08 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMECFDKAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <3EE90933.8090209@techsource.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> David Schwartz wrote:
> >>I would like to limit the maximum resident memory size
> >>of a process within a threshold, i.e. if its virtual
> >>memory footprint exceeds this threshold, it needs to
> >>swap out pages *only* from within its VM space.

> > Why? If you think this is a good way to be nice to other
> > processes, you're
> > wrong.

> Why is he wrong?

	Because increasing the amount of swapping and paging will slow the system
down overall. Other processes will be interrupted more frequently and cache
effectiveness will decline. If the disks are shared, the additional disk
access will slow down other processes on the system as well.

	It's also not clear how shared pages should be handled. If this process
causes large chunks of a shared library to be resident that wouldn't be
otherwise, should this be charged against the process or not? If you exempt
all shared memory, you not only create a whole a malicious process could
drive a truck through but you don't measure accurately.

	If the process has a limited amount of work to do, it's much more sensible
to just let it get done using the memory it needs to run quickly so it can
get out of the way of other processes. If the process has an unlimited
amonut of work to do, it makes more sense to control its use of processor
resources, which will inherently limit its resident set size.

	Basically, which pages should be resident is just one of those things the
system knows better than you. Trying to make things better for one process
may wind up making them worse as the system as a whole bogs down.

	Overall, this just doesn't strike me as a sensible thing to do. Depending
upon what effect he's trying to achieve, there are probably more sensible
ways to do it.

	DS


