Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWFRLES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWFRLES (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 07:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWFRLES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 07:04:18 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:30431 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1750982AbWFRLES
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 18 Jun 2006 07:04:18 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17557.12770.248608.998213@gargle.gargle.HOWL>
Date: Sun, 18 Jun 2006 14:58:42 +0400
To: Con Kolivas <kernel@kolivas.org>
Cc: ck list <ck@vds.kolivas.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [ckpatch][8/29] track_mutexes-1.patch
Newsgroups: gmane.linux.kernel.ck,gmane.linux.kernel
In-Reply-To: <200606181731.14664.kernel@kolivas.org>
References: <200606181731.14664.kernel@kolivas.org>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas writes:
 > Keep a record of how many mutexes are held by any task. This allows cpu
 > scheduler code to use this information in decision making for tasks that
 > hold contended resources.

Natural extension of this idea is to specify priority bump for every
mutex, with default mutex initializer setting this value to 1.

In fact, this looks like an old UNIX method of specifying priority value
as an argument to the call of sleeping function (sleep, tsleep,
etc.).

 > 
 > Signed-off-by: Con Kolivas <kernel@kolivas.org>
 > 

[...]

 >  	void *journal_info;
 > Index: linux-ck-dev/kernel/fork.c
 > ===================================================================
 > --- linux-ck-dev.orig/kernel/fork.c	2006-06-18 15:20:14.000000000 +1000
 > +++ linux-ck-dev/kernel/fork.c	2006-06-18 15:23:44.000000000 +1000
 > @@ -1022,6 +1022,7 @@ static task_t *copy_process(unsigned lon
 >  	p->io_context = NULL;
 >  	p->io_wait = NULL;
 >  	p->audit_context = NULL;
 > +	p->mutexes_held = 0;

You may also add 

        BUG_ON(p->mutexes_held != 0);

check to do_exit().

Nikita.
