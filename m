Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266148AbUGIMVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266148AbUGIMVn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 08:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266151AbUGIMVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 08:21:43 -0400
Received: from mail.zelnet.ru ([80.92.97.13]:37306 "HELO zelnet.ru")
	by vger.kernel.org with SMTP id S266148AbUGIMVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 08:21:39 -0400
Message-Id: <200001011731.e01HVoNu001908@altair.deep.net>
To: linux-kernel@vger.kernel.org
cc: kernel@kolivas.org, akpm@osdl.org
Subject: Re: Autoregulate swappiness & inactivation
X-Mailer: MH-E 7.4.3; nmh 1.1; GNU Emacs 21.3.1
Date: Sat, 01 Jan 2000 18:31:50 +0100
From: deepfire@zelnet.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton <akpm@osdl.org> wrote at Thu, 8 Jul 2004 09:44:06 -0700:
> Con Kolivas <kernel@kolivas.org> wrote:
> >
> > Here is another try at providing feedback to tune the vm_swappiness.
> 
> I spent some time yesterday trying to demonstrate performance improvements
> from those two patches.  Using
> 
> 	make -j4 vmlinux with mem=64m
> 
> and
> 
> 	qsbench -p 4 -m 96 with mem=256m
> 
> and was not able to do so, which is what I expected.
> 
> We do need more quantitative testing on this work.

i`ve done some of my favorite under-bridge-crafted tests, so to speak.

the test looked like this:

time find / -xdev | \
bzcat --compress | bzcat --decompress | \
bzcat --compress | bzcat --decompress | \
bzcat --compress | bzcat --decompress | \
cat > /dev/null

The patches applied were Con`s autoswap + autoregulate

it was performed on a p3-600, 10krpm scsi in two following scenarios:


1. mem=48M, swap=off

2.4.20-pre9:		3m20
2.6.7-con:		4m09
2.6.7-vanilla:		4m09


2. mem=32M, swap=on

2.4.20-pre9:		5m37
2.6.7-con:		6m37
2.6.7-vanilla:		7m31



which still leaves 2.4 the leader.


regards, Samium "2.4" Gromoff
