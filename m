Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266439AbTGETnw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 15:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266441AbTGETnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 15:43:52 -0400
Received: from quechua.inka.de ([193.197.184.2]:45249 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S266439AbTGETnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 15:43:51 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH - RFC] [1/5] 64-bit network statistics - generic net
In-Reply-To: <200307041357.32871.jeffpc@optonline.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19YtAq-0006Xf-00@calista.inka.de>
Date: Sat, 05 Jul 2003 21:58:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200307041357.32871.jeffpc@optonline.net> you wrote:
> If one cpu tries to read a u_int64_t variable while another tries to 
> update it, the worst case scenario is that the reader will get the high 
> 32-bits before the write, and low 32-bit after the write, now if the counter 
> overflow, the number would be off by 4GB! (This only applies to 32-bit 
> architectures.) True, there are cache coherency algorithms, etc...

a reader like ifconfig can easyly work around this with multiple tries, but
incremeting those variables wont work that easy, and therefore needs a lock,
which will be a major pita.

64bit counters should be a result of lockless per-cpu network counters
(32bit) with some kind of async merging.

Or we wait till 64bit hardware is more common :)

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
