Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318396AbSGaQL4>; Wed, 31 Jul 2002 12:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318397AbSGaQL4>; Wed, 31 Jul 2002 12:11:56 -0400
Received: from mail.coastside.net ([207.213.212.6]:31986 "EHLO
	mail.coastside.net") by vger.kernel.org with ESMTP
	id <S318396AbSGaQL4>; Wed, 31 Jul 2002 12:11:56 -0400
Mime-Version: 1.0
Message-Id: <p05111a0bb96dbbf51858@[207.213.214.37]>
In-Reply-To: <1028125599.7886.68.camel@irongate.swansea.linux.org.uk>
References: <00c201c23892$1c5fb450$638317d2@pacific.net.au>
 <1028125599.7886.68.camel@irongate.swansea.linux.org.uk>
Date: Wed, 31 Jul 2002 09:15:07 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: NMI watchdog, die(), & console_loglevel
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The i386 NMI watchdog handler prints a message, sets console_loglevel 
to 0 (no output to console), and then kills the current task 
(arch/i386/kernel/nmi.c:nmi_watchdog_tick()); it then leaves the 
console turned off.

die(), on the other hand, starts out by setting console_loglevel to 
15 (print everything), and leaves it there.

Neither behavior seems particularly appropriate, and taken together 
they seem at least inconsistent. What's the justification, if any, 
and wouldn't it be better to leave console_loglevel alone and set an 
appropriate message loglevel? (Not that I'd claim for an instant that 
message loglevels are used consistently; have a look at the various 
applications of KERN_EMERG, for example.)
-- 
/Jonathan Lundell.
