Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbUJ2WzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbUJ2WzF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbUJ2Wwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:52:53 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:31399
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261446AbUJ2WsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 18:48:06 -0400
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Javier Marcet <javier@marcet.info>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <20041023125948.GC9488@marcet.info>
References: <20041023125948.GC9488@marcet.info>
Content-Type: text/plain
Organization: linutronix
Date: Sat, 30 Oct 2004 00:39:50 +0200
Message-Id: <1099089590.22115.79.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 14:59 +0200, Javier Marcet wrote:
> I've been following quite closely the development of 2.6.9, testing
> every -rc release and a lot of -bk's.
> 
> Upon changing from 2.6.9-rc2 to 2.6.9-rc3 I began experiencing random
> oom kills whenever a high memory i/o load took place.
> This happened with plenty of free memory, and with whatever values I
> used for vm.overcommit_ratio and vm.overcommit_memory
> Doubling the physical RAM didn't change the situation either.
> 
> Having traced the problem to 2.6.9-rc3, I took a look at the differences
> in memory handling between 2.6.9-rc2 and 2.6.9-rc3 and with the attached
> patch I have no more oom kills. Not a single one.
> 
> I'm not saying everything within the patch is needed, not even that it's
> the right thing to change. Nonetheless, 2.6.9 vanilla was unusable,
> while this avoids those memory leaks.
> 
> Please, review and see what's wrong there :)

The changes in mempolicy.c are unrelated, except you have a NUMA enabled
machine.

The flush_dcache_page() is only relevant for non x86, as they result in
a NOP there.

tglx



